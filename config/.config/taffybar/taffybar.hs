import System.Taffybar

import System.Taffybar.Pager
import System.Taffybar.SimpleClock
import System.Taffybar.FreedesktopNotifications

import System.Taffybar.Widgets.PollingLabel ( pollingLabelNew )

import Text.Printf ( printf )
import qualified Text.StringTemplate as ST
import qualified Graphics.UI.Gtk as Gtk
import qualified Data.ByteString.Lazy.Char8 as B
import Data.Char (isSpace)
import Graphics.X11.Xlib.Extras (Event)

import Data.IORef
import Graphics.UI.Gtk.Misc.TrayManager
import Network.HTTP
import Data.Time
import Data.List

import System.Information.X11DesktopInfo
import System.Information.EWMHDesktopInfo
import System.Information.Memory
import System.Information.Network (getNetInfo)
import System.Process (readProcess)
import Control.Exception
import Control.Exception.Enclosed (catchAny)

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

  let clock = textClockNew Nothing (colorize "orange" "" "%a %b %_d %Y %H:%M:%S") 1
      wsm = textWorkspaceMonitorNew pager
      los = textActiveLayoutNew pager
      wnd = textActiveWindowNew pager
      note = notifyAreaNew defaultNotificationConfig
      wea = textWeatherNew ("$name$: $tempC$" ++ colorize "#586E75" "" "C") "CYLW" 60
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
                                        , endWidgets = [ clock, sepL, tray, sepR, wea, sep, wsm, sepAlt, los, sepAlt, wnd ]
}

--------------------------------------------------
-- Helper
roundDbl :: Double -> Integer -> String
roundDbl value digits = printf ("%." ++ (show digits) ++ "f") value

strip :: String -> String
strip = reverse . dropWhile isSpace . reverse . dropWhile isSpace

getUrl :: String -> IO String
getUrl url = simpleHTTP (getRequest url) >>= getResponseBody

ignoreException :: SomeException -> IO ()
ignoreException _ = return ()

wrapLabel :: Gtk.Label -> IO Gtk.Widget
wrapLabel label = do
  box <- Gtk.hBoxNew False 0
  Gtk.boxPackStart box label Gtk.PackNatural 0
  Gtk.widgetShowAll box
  return $ Gtk.toWidget box
--------------------------------------------------
-- Workspace Monitor
textWorkspaceMonitorNew :: Pager -> IO Gtk.Widget
textWorkspaceMonitorNew pager = do
  label <- Gtk.labelNew $ Just "label"
  let cfg = config pager
      callback = pagerCallback cfg label
  subscribe pager callback "_NET_DESKTOP_NAMES"
  subscribe pager callback "_NET_NUMBER_OF_DESKTOPS"
  wrapLabel label
  where
    pagerCallback :: PagerConfig -> Gtk.Label -> Event -> IO ()
    pagerCallback cfg label _ = do
      catchAny $ do
        wsNames <- withDefaultCtx getWorkspaceNames
        wsNonEmpty <- withDefaultCtx $ mapM getWorkspace =<< getWindows
        wsVisible <- withDefaultCtx getVisibleWorkspaces
        wsCurrent <- withDefaultCtx getVisibleWorkspaces
        let fkt = \x -> case () of
                        _ | elem x wsCurrent  -> (activeWorkspace cfg) (wsNames!!x)
                          | elem x wsVisible  -> (visibleWorkspace cfg) (wsNames!!x)
                          | elem x wsNonEmpty -> (hiddenWorkspace cfg) (wsNames!!x)
                          | otherwise         -> (emptyWorkspace cfg) (wsNames!!x)
        let result = map fkt [0 .. length wsNames - 1]
        Gtk.postGUIAsync $ do
          catchAny $ do
            Gtk.labelSetMarkup label (intercalate " " result)
          $ ignoreException
      $ ignoreException

--------------------------------------------------
-- Active Layout
textActiveLayoutNew :: Pager -> IO Gtk.Widget
textActiveLayoutNew pager = do
  label <- Gtk.labelNew $ Just "label"
  let cfg = config pager
      callback = pagerCallback cfg label
  subscribe pager callback "_XMONAD_CURRENT_LAYOUT"
  wrapLabel label
  where
    pagerCallback :: PagerConfig -> Gtk.Label -> Event -> IO ()
    pagerCallback cfg label _ = do
      catchAny $ do
        layout <- withDefaultCtx $ readAsString Nothing "_XMONAD_CURRENT_LAYOUT"
        let decorate = activeLayout cfg
        Gtk.postGUIAsync $ do
          catchAny $ do
            Gtk.labelSetMarkup label (decorate layout)
          $ ignoreException
      $ ignoreException

--------------------------------------------------
-- Active Window
textActiveWindowNew :: Pager -> IO Gtk.Widget
textActiveWindowNew pager = do
  label <- Gtk.labelNew $ Just "label"
  let cfg = config pager
      callback = pagerCallback cfg label
  subscribe pager callback "_NET_ACTIVE_WINDOW"
  wrapLabel label
  where
    nonEmpty :: String -> String
    nonEmpty x = case x of
      [] -> "(nameless window)"
      _  -> x
    pagerCallback :: PagerConfig -> Gtk.Label -> Event -> IO ()
    pagerCallback cfg label _ = do
      catchAny $ do
        title <- withDefaultCtx getActiveWindowTitle
        let decorate = activeWindow cfg
        Gtk.postGUIAsync $ do
         catchAny $ do
           Gtk.labelSetMarkup label (decorate $ nonEmpty title)
         $ ignoreException
      $ ignoreException

--------------------------------------------------
-- Text Widget
textWidgetNew :: String -> IO Gtk.Widget
textWidgetNew str = do
  label <- Gtk.labelNew $ Just str
  wrapLabel label

--------------------------------------------------
-- Weather
textWeatherNew :: String
               -> String
               -> Double
               -> IO Gtk.Widget
textWeatherNew fmt station period = do
  initTime <- getCurrentTime
  label <- pollingLabelNew fmt period (callback station initTime)
  Gtk.widgetShowAll label
  return label
  where
    callback station initTime = do
      currentTime <- getCurrentTime
      -- start with delay (speed up when no network)
      if (diffUTCTime currentTime initTime) < 30 then
        return "Pending..."
      else do
        body <- getUrl ("http://tgftp.nws.noaa.gov/data/observations/metar/decoded/" ++ station ++ ".TXT")
        name <- readProcess "grep" ["-o", "-P", "^.*(?=,.*\\(" ++ station ++ "\\))"] body

        tempLine <- readProcess "grep" ["-o", "-P", "(?<=Temperature:).*$"] body
        temp <- readProcess "grep" ["-o", "-P", "(?<=\\().*?(?= C\\))"] tempLine

        let template = ST.newSTMP fmt
        let template' = ST.setManyAttrib [ ("name", strip name), ("tempC", strip temp) ] template
        return $ ST.render template'

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
  else return $ (take 4 $ roundDbl incoming 2)

getNetUp :: IORef Integer -> Double -> String -> IO String
getNetUp sample interval interface = do
  Just [_, new] <- getNetInfo interface
  old <- readIORef sample
  writeIORef sample new
  let delta = new - old
      outgoing = fromIntegral delta/(interval*1e3)
  if old == 0 then return $ "…………"
  else return $ (take 4 $ roundDbl outgoing 2)

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
