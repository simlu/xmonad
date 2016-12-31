import System.Taffybar

import System.Taffybar.WorkspaceSwitcher
import System.Taffybar.WindowSwitcher
import System.Taffybar.LayoutSwitcher

import System.Taffybar.Systray
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

--------------------------------------------------
-- Helper
formatPercent :: Double -> String
formatPercent = printf "%.0f"

--------------------------------------------------
-- CPU Monitor Related
textCpuMonitorNew :: String -- ^ Format. You can use variables: $total$, $user$, $system$
                  -> Double -- ^ Polling period (in seconds)
                  -> IO Gtk.Widget
textCpuMonitorNew fmt period = do
  label <- pollingLabelNew fmt period callback
  Gtk.widgetShowAll label
  return label
  where
    callback = do
      (userLoad, systemLoad, totalLoad) <- cpuLoad
      let [userLoad', systemLoad', totalLoad'] = map (formatPercent.(*100)) [userLoad, systemLoad, totalLoad]
      let template = ST.newSTMP fmt
      let template' = ST.setManyAttrib [ ("user", userLoad'),
                                         ("system", systemLoad'),
                                         ("total", "<span fgcolor='" ++ (if totalLoad < 0.5 then "#00ff00" else "#ff0000") ++ "'>" ++ totalLoad' ++ "</span>") ] template
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
        let labels = ["perc"]
        let actions = [memoryUsedRatio]
            actions' = map ((show) .) actions
        let stats = [f info | f <- actions']
        let ratio = read (stats!!0) :: Double
        let template' = ST.setManyAttrib [("perc", formatPercent (ratio * 100))] template
        return $ ST.render template'

---------------------------------------------------

main = do
  let cfg = defaultTaffybarConfig { barHeight = 25
                                  , barPosition = Top
                                  , widgetSpacing = 8
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
      mem = textMemoryMonitorNew "Mem: $perc$%" 5
      cpu = textCpuMonitorNew "Cpu: $total$%" 5
  defaultTaffybar cfg { startWidgets = [ cpu, mem ]
                                        , endWidgets = [ clock, tray, wea, note, wss, los, wnd ]
}
