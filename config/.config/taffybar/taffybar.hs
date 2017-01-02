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
import System.Taffybar.Widgets.PollingLabel ( pollingLabelNew )

import Text.Printf ( printf )
import qualified Text.StringTemplate as ST
import qualified Graphics.UI.Gtk as Gtk
import qualified Data.ByteString.Lazy.Char8 as B
import Data.Char (isSpace)

import Graphics.UI.Gtk.Misc.TrayManager
import Data.IORef

import System.Information.Memory
import System.Information.Network (getNetInfo)
import System.Process (readProcess)

--------------------------------------------------
-- Main
main = do
  let cfg = defaultTaffybarConfig { barHeight = 15
                                  , barPosition = Top
                                  , widgetSpacing = 4
                                  , screenNumber = 0
                                  , monitorNumber = 1
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

      netDown = downNetMonitorNew ("Down: $rate$" ++ colorize "#586E75" "" "KB/s") 1
      netUp = upNetMonitorNew ("Up: $rate$" ++ colorize "#586E75" "" "KB/s") 1

      sep = textWidgetNew " | "
      sepL = textWidgetNew "| "
      sepR = textWidgetNew " |"
      sepAlt = textWidgetNew ":"

  defaultTaffybar cfg { startWidgets = [ cpu, sep, mem, sep, swap, sep, netUp, sep, netDown, note ]
                                        , endWidgets = [ clock, sepL, tray, sepR, wea, sep, wss, sepAlt, los, sepAlt, wnd ]
}

--------------------------------------------------
-- Helper
roundDbl :: Double -> Integer -> String
roundDbl value digits = printf ("%." ++ (show digits) ++ "f") value

strip :: String -> String
strip = reverse . dropWhile isSpace . reverse . dropWhile isSpace

--------------------------------------------------
-- Text Widget
textWidgetNew :: String -> IO Gtk.Widget
textWidgetNew str = do
  box <- Gtk.hBoxNew False 0
  label <- Gtk.labelNew $ Just str
  Gtk.boxPackStart box label Gtk.PackNatural 0
  Gtk.widgetShowAll box
  return $ Gtk.toWidget box

--------------------------------------------------
-- Net

getNetworkAdapter :: IO String
getNetworkAdapter = do
  routeRaw <- readProcess "route" [] ""
  defaultLine <- readProcess "grep" ["^default"] routeRaw
  netAdapterRaw <- readProcess "grep" ["-o", "-P", "\\s\\w+$"] defaultLine
  return (strip netAdapterRaw)

downNetMonitorNew :: String
                  -> Double
                  -> IO Gtk.Widget
downNetMonitorNew fmt period = do
  interface <- getNetworkAdapter
  sample <- newIORef 0
  label <- pollingLabelNew fmt period (callback sample period interface)
  Gtk.widgetShowAll label
  return label
  where
    callback sample period interface = do
      rate <- getNetDown sample period interface
      let template = ST.newSTMP fmt
      let template' = ST.setManyAttrib [("rate", rate)] template
      return $ ST.render template'

upNetMonitorNew :: String
                  -> Double
                  -> IO Gtk.Widget
upNetMonitorNew fmt period = do
  interface <- getNetworkAdapter
  sample <- newIORef 0
  label <- pollingLabelNew fmt period (callback sample period interface)
  Gtk.widgetShowAll label
  return label
  where
    callback sample period interface = do
      rate <- getNetUp sample period interface
      let template = ST.newSTMP fmt
      let template' = ST.setManyAttrib [("rate", rate)] template
      return $ ST.render template'

getNetDown :: IORef Integer -> Double -> String -> IO String
getNetDown sample interval interface = do
  Just [new, _] <- getNetInfo interface
  old <- readIORef sample
  writeIORef sample new
  let delta = new - old
      incoming = fromIntegral delta/(interval*1e3)
  if old == 0 then return $ "…………"
  else return $ (take 4 $ printf "%.2f" incoming)

getNetUp :: IORef Integer -> Double -> String -> IO String
getNetUp sample interval interface = do
  Just [_, new] <- getNetInfo interface
  old <- readIORef sample
  writeIORef sample new
  let delta = new - old
      outgoing = fromIntegral delta/(interval*1e3)
  if old == 0 then return $ "…………"
  else return $ (take 4 $ printf "%.2f" outgoing)

--------------------------------------------------
-- CPU Monitor Related
cpuData :: IO [Int]
cpuData = cpuParser `fmap` B.readFile "/proc/stat"

cpuParser :: B.ByteString -> [Int]
cpuParser = map (read . B.unpack) . tail . B.words . head . B.lines

parseCpu :: IORef [Int] -> IO [Double]
parseCpu cref =
    do a <- readIORef cref
       b <- cpuData
       writeIORef cref b
       let dif = zipWith (-) b a
           tot = fromIntegral $ sum dif
           percent = map ((/ tot) . fromIntegral) dif
       return percent

getCpuTextColor :: Double -> String
getCpuTextColor value
  | value < 0.33 = "#00FF00"
  | value < 0.67 = "#FFD700"
  | otherwise = "#FF0000"

textCpuMonitorNew :: String
                  -> Double
                  -> IO Gtk.Widget
textCpuMonitorNew fmt period = do
  cref <- newIORef []
  label <- pollingLabelNew fmt period (callback cref)
  Gtk.widgetShowAll label
  return label
  where
    callback cref = do
      c <- parseCpu cref
      let totalLoad = sum $ take 3 c
      let load = roundDbl (totalLoad * 100) 0
      let color = getCpuTextColor totalLoad
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
      let template' = ST.setManyAttrib [("perc", roundDbl (ratio * 100) 0)] template
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
      let template' = ST.setManyAttrib [("perc", roundDbl (((tot - free) / tot) * 100) 0)] template
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
