_Generated via Gemini_

--------------------------

# XMonad Configuration Shortcuts

This document outlines the keyboard and mouse shortcuts configured in the provided `xmonad.hs` file.

## Modifier Key

The primary modifier key (`Mod`) is set to `mod1Mask`, which is the **Alt key** on most keyboards.

## Mouse Bindings

* `Mod + Left Mouse Button (drag)`: Sets the window to floating mode and moves it by dragging.
* `Mod + Middle Mouse Button (click)`: Raises the clicked window to the top of the stack (makes it the master window).
* `Mod + Right Mouse Button (drag)`: Sets the window to floating mode and resizes it by dragging.

---

## Keyboard Shortcuts

### Launching & Killing Applications
* `Mod + Shift + Enter`: Launches a new terminal (`xterm`).
* `Mod + P`: Opens `dmenu` to run an application.
* `Mod + Shift + P`: Opens `gmrun`.
* `Mod + Shift + C`: Closes the currently focused window.
* `Mod + Shift + M`: Launches the `claws-mail` email client.
* `Mod + Ctrl + P`: Takes a screenshot and saves it to `~/screenshot.png`.

### Layout Management
* `Mod + Space`: Cycles to the next available layout.
* `Mod + Shift + Space`: Resets the layout to the default configuration.
* `Mod + Shift + B`: Toggles the visibility of status bars and docks (like `xmobar`).
* `Mod + T`: Pushes a floating window back into the tiling layout.
* `Mod + F`: Makes the focused window floating and fullscreen.
* `Mod + Ctrl + F`: Makes the focused window floating and centered at 80% screen size.

### Window Focus
* `Mod + J` or `Mod + Tab`: Moves focus to the next window.
* `Mod + K`: Moves focus to the previous window.
* `Mod + M`: Moves focus to the master window.

### Window Swapping & Resizing
* `Mod + Shift + J`: Swaps the focused window with the next window.
* `Mod + Shift + K`: Swaps the focused window with the previous window.
* `Mod + H`: Shrinks the master area.
* `Mod + L`: Expands the master area.
* `Mod + Shift + H`: Shrinks the master area in the `Mirror` layout.
* `Mod + Shift + L`: Expands the master area in the `Mirror` layout.
* `Mod + ,` (comma): Increases the number of windows in the master area by one.
* `Mod + .` (period): Decreases the number of windows in the master area by one.

### Screen Management (for multi-monitor setups)
* `Mod + Ctrl + Left Arrow`: Moves focus to the next screen.
* `Mod + Ctrl + Right Arrow`: Moves focus to the previous screen.
* `Mod + Ctrl + O`: Moves the currently focused window to the next screen.

### System & XMonad
* `Mod + N`: Refreshes the screen and redraws windows.
* `Mod + Q`: Restarts XMonad.

### Workspace Switching
The following keys correspond to your configured workspaces: `1, 2, 3, 4, 5, 6, 7, 8, 9, 0, -, =, Backspace`.

* `Mod + [Workspace Key]`: Switches to the specified workspace.
    * *Example: `Mod + 1` switches to workspace "1".*
    * *Example: `Mod + -` switches to workspace "-".*
* `Mod + Shift + [Workspace Key]`: Moves the focused window to the specified workspace.
    * *Example: `Mod + Shift + 3` moves the current window to workspace "3".*
* `Mod + Ctrl + [Workspace Key]`: Switches to the specified workspace.
    * *Example: `Mod + Ctrl + 5` switches to workspace "5".*

### Media & Function Keys
* `Volume Up Key`: Increases PCM volume.
* `Volume Down Key`: Decreases PCM volume.
* `Mute Key`: Toggles PCM mute.
* `XF86Launch1`: Switches to workspace "1-Main".
* `XF86Launch2`: Switches to workspace "2-Temp".
* `XF86Launch3`: Switches to workspace "3-Work".
* `XF86Launch4`: Switches to workspace "4-Misc".
* `XF86Launch5`: Switches to workspace "5-Msg".
* `XF86Launch6`: Switches to workspace "6-Media".

*Note: These XF86Launch bindings are hardcoded to specific names which differ from the numbered workspaces defined earlier. They will only work if you have workspaces with these exact names (e.g., "1-Main").*
