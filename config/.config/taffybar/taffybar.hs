import System.Taffybar

import System.Taffybar.WorkspaceSwitcher
import System.Taffybar.WindowSwitcher
import System.Taffybar.LayoutSwitcher

import System.Taffybar.Pager
import System.Taffybar.SimpleClock
import System.Taffybar.FreedesktopNotifications
import System.Taffybar.Weather
import System.Taffybar.MPRIS
import System.Taffybar.Battery

import System.Taffybar.Widgets.PollingBar
import System.Taffybar.Widgets.PollingGraph

import Text.Printf ( printf )
import qualified Text.StringTemplate as ST
import System.Information.CPU
import System.Taffybar.Widgets.PollingLabel ( pollingLabelNew )
import qualified Graphics.UI.Gtk as Gtk
import System.Information.Memory
import qualified Data.ByteString.Lazy.Char8 as B

import Graphics.UI.Gtk.General.RcStyle (rcParseString)

import Graphics.UI.Gtk.Misc.TrayManager
import Data.IORef

import System.Information.Network (getNetInfo)

--------------------------------------------------
-- Helper
formatPercent :: Double -> String
formatPercent = printf "%.0f"

getColor value 
  | value < 0.33 = "#00FF00"
  | value < 0.67 = "#FFD700"
  | otherwise = "#FF0000"

textWidgetNew :: String -> IO Gtk.Widget
textWidgetNew str = do
  box <- Gtk.hBoxNew False 0
  label <- Gtk.labelNew $ Just str
  Gtk.boxPackStart box label Gtk.PackNatural 0
  Gtk.widgetShowAll box
  return $ Gtk.toWidget box

--------------------------------------------------
-- Net

downNetMonitorNew :: Double -> String -> IO Gtk.Widget
downNetMonitorNew interval interface = do
  sample <- newIORef 0
  label <- pollingLabelNew "" interval $ getNetDown sample interval interface
  Gtk.widgetShowAll label
  return $ Gtk.toWidget label

upNetMonitorNew :: Double -> String -> IO Gtk.Widget
upNetMonitorNew interval interface = do
  sample <- newIORef 0
  label <- pollingLabelNew "" interval $ getNetUp sample interval interface
  Gtk.widgetShowAll label
  return $ Gtk.toWidget label

getNetDown :: IORef Integer -> Double -> String -> IO String
getNetDown sample interval interface = do
  Just [new, _] <- getNetInfo interface
  old <- readIORef sample
  writeIORef sample new
  let delta = new - old
      incoming = fromIntegral delta/(interval*1e3)
  if old == 0 then return $ "…………" ++ colorize "#586E75" "" "KB/s"
  else return $ "Down: " ++ (take 4 $ printf "%.2f" incoming) ++ colorize "#586E75" "" "KB/s"

getNetUp :: IORef Integer -> Double -> String -> IO String
getNetUp sample interval interface = do
  Just [_, new] <- getNetInfo interface
  old <- readIORef sample
  writeIORef sample new
  let delta = new - old
      outgoing = fromIntegral delta/(interval*1e3)
  if old == 0 then return $ "…………" ++ colorize "#586E75" "" "KB/s"
  else return $ "Up: " ++ (take 4 $ printf "%.2f" outgoing) ++ colorize "#586E75" "" "KB/s"

--------------------------------------------------
-- CPU Monitor Related
textCpuMonitorNew :: String
                  -> Double
                  -> IO Gtk.Widget
textCpuMonitorNew fmt period = do
  label <- pollingLabelNew fmt period callback
  Gtk.widgetShowAll label
  return label
  where
    callback = do
      (_, _, totalLoad) <- cpuLoad
      let load = formatPercent (totalLoad * 100)
      let color = getColor totalLoad
      let template = ST.newSTMP fmt
      let template' = ST.setManyAttrib [("total", "<span fgcolor='" ++ color ++ "'>" ++ load ++ "</span>")] template
      return $ ST.render template'     

--------------------------------------------------
-- Mem Monitor Related
textMemoryMonitorNew :: String 
                     -> Double 
                     -> IO Gtk.Widget
textMemoryMonitorNew fmt period = do
  label <- pollingLabelNew fmt period callback
  Gtk.widgetShowAll label
  return label
  where
    callback = do
      info <- parseMeminfo
      let template = ST.newSTMP fmt
      let ratio = memoryUsedRatio info
      let template' = ST.setManyAttrib [("perc", formatPercent (ratio * 100))] template
      return $ ST.render template'

---------------------------------------------------
-- Swap Monitor Related
fileMEM :: IO B.ByteString
fileMEM = B.readFile "/proc/meminfo"

textSwapMonitorNew :: String
                   -> Double
                   -> IO Gtk.Widget
textSwapMonitorNew fmt period = do
  label <- pollingLabelNew fmt period callback
  Gtk.widgetShowAll label
  return label
  where
    callback = do
      file <- fileMEM
      let li i l
            | l /= [] = head l !! i
            | otherwise = B.empty
          fs s l
            | null l    = False
            | otherwise = head l == B.pack s
          get_data s = flip (/) 1024 . read . B.unpack . li 1 . filter (fs s)
          st   = map B.words . B.lines $ file
          tot  = get_data "SwapTotal:" st
          free = get_data "SwapFree:" st
      let template = ST.newSTMP fmt
      let template' = ST.setManyAttrib [("perc", formatPercent (((tot - free) / tot) * 100))] template
      return $ ST.render template'
---------------------------------------------------
-- Tray Related
systrayNew :: IO Gtk.Widget
systrayNew = do
  box <- Gtk.hBoxNew True 1 

  trayManager <- trayManagerNew
  Just screen <- Gtk.screenGetDefault
  _ <- trayManagerManageScreen trayManager screen

  _ <- Gtk.on trayManager trayIconAdded $ \w -> do
    Gtk.widgetShowAll w
    Gtk.boxPackStart box w Gtk.PackNatural 0

  _ <- Gtk.on trayManager trayIconRemoved $ \_ -> do
    putStrLn "Tray icon removed"

  Gtk.widgetShowAll box
  return (Gtk.toWidget box)

--------------------------------------------------


main = do
  let cfg = defaultTaffybarConfig { barHeight = 15
                                  , barPosition = Top
                                  , widgetSpacing = 4 
  }

  pager <- pagerNew defaultPagerConfig 
                  { activeWindow     = colorize "#ffca00" "" . escape . shorten 40
                  , activeLayout     = escape
                  , activeWorkspace  = colorize "#ffca00" "" . escape . wrap "[" "]"
                  , hiddenWorkspace  = colorize "#aaaaaa" "" . escape
                  , emptyWorkspace   = colorize "#666666" "" . escape
                  , visibleWorkspace = colorize "#a88500" "" . escape
                  , urgentWorkspace  = colorize "red" "yellow" . escape
                  , widgetSep        = " : "
  }

  let clock = textClockNew Nothing "<span fgcolor='orange'>%a %b %_d %Y %H:%M:%S</span>" 1
      wss = wspaceSwitcherNew pager
      los = layoutSwitcherNew pager
      wnd = windowSwitcherNew pager
      note = notifyAreaNew defaultNotificationConfig
      wea = weatherNew (defaultWeatherConfig "CYLW") 10
      tray = systrayNew
      swap = textSwapMonitorNew ("Swap: $perc$" ++ colorize "#586E75" "" "%") 1
      mem = textMemoryMonitorNew ("Mem: $perc$" ++ colorize "#586E75" "" "%") 1
      cpu = textCpuMonitorNew ("Cpu: $total$" ++ colorize "#586E75" "" "%") 1

      netDown = downNetMonitorNew 1 "ens33"
      netUp = upNetMonitorNew 1 "ens33"

      sep = textWidgetNew " | "
      sepL = textWidgetNew "| "
      sepR = textWidgetNew " |"
      sepAlt = textWidgetNew ":" 
 
      font = "Ubuntu Mono 9"

  rcParseString $ ""
    ++ "style \"default\" {"
    ++ "  font_name = \"" ++ font ++ "\""
    ++ "}"


  defaultTaffybar cfg { startWidgets = [ cpu, sep, mem, sep, swap, sep, netUp, sep, netDown, note ]
                                        , endWidgets = [ clock, sepL, tray, sepR, wea, sep, wss, sepAlt, los, sepAlt, wnd ]
}
