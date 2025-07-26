local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config.enable_tab_bar = false
config.automatically_reload_config = true
config.window_decorations = "RESIZE"
config.term = "xterm-256color"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrains Mono")
config.window_background_opacity = 0.9
config.macos_window_background_blur = 55

config.default_cursor_style = 'SteadyBar'
-- local is_windows = package.config:sub(1, 1) == "\\"
--
-- if is_windows then
--     print("Running on Windows")
-- else
--     print("Running on Linux/Unix")
-- end
--
-- if is_windows then
	config.default_prog = { 'pwsh'}
-- end

local function isViProcess(pane)
	-- get_foreground_process_name On Linux, macOS and Windows,
	-- the process can be queried to determine this path. Other operating systems
	-- (notably, FreeBSD and other unix systems) are not currently supported
	return pane:get_foreground_process_name():find('n?vim') ~= nil or pane:get_title():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
	if isViProcess(pane) then
		window:perform_action(
		-- This should match the keybinds you set in Neovim.
			act.SendKey({ key = vim_direction, mods = 'CTRL' }),
			pane
		)
	else
		window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
	end
end

wezterm.on('ActivatePaneDirection-right', function(window, pane)
	conditionalActivatePane(window, pane, 'Right', 'l')
end)
wezterm.on('ActivatePaneDirection-left', function(window, pane)
	conditionalActivatePane(window, pane, 'Left', 'h')
end)
wezterm.on('ActivatePaneDirection-up', function(window, pane)
	conditionalActivatePane(window, pane, 'Up', 'k')
end)
wezterm.on('ActivatePaneDirection-down', function(window, pane)
	conditionalActivatePane(window, pane, 'Down', 'j')
end)

config.keys = {
	{
		key = "v",
		mods = "ALT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "h",
		mods = "ALT",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "f",
		mods = "ALT",
		action = wezterm.action.ToggleFullScreen,
	},
	{ key = 'h', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-left') },
	{ key = 'j', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-down') },
	{ key = 'k', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-up') },
	{ key = 'l', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-right') },
	{ key = "t", mods = "ALT",  action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
	{ key = "1", mods = "ALT",  action = wezterm.action { ActivateTab = 0 } },
	{ key = "2", mods = "ALT",  action = wezterm.action { ActivateTab = 1 } },
	{ key = "3", mods = "ALT",  action = wezterm.action { ActivateTab = 2 } },
	{ key = "4", mods = "ALT",  action = wezterm.action { ActivateTab = 3 } },
	{ key = "5", mods = "ALT",  action = wezterm.action { ActivateTab = 4 } },
	{ key = "6", mods = "ALT",  action = wezterm.action { ActivateTab = 5 } },
	{ key = "7", mods = "ALT",  action = wezterm.action { ActivateTab = 6 } },
	{ key = "8", mods = "ALT",  action = wezterm.action { ActivateTab = 7 } },
	{ key = "9", mods = "ALT",  action = wezterm.action { ActivateTab = 8 } },
	{ key = "y", mods = "ALT",  action = wezterm.action { CopyTo = "Clipboard" } },
	{ key = "p", mods = "ALT",  action = wezterm.action { PasteFrom = "Clipboard" } },
}
return config
