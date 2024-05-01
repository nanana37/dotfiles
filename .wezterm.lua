local wezterm = require("wezterm")

local config = wezterm.config_builder()

local act = wezterm.action

-- ========================
--   Colors & Appearance
-- ========================
-- color
config.color_scheme = "X::Erosion (terminal.sexy)"

--tab bar
config.hide_tab_bar_if_only_one_tab = true

-- Opacity
config.window_background_opacity = 0.85
config.text_background_opacity = 1.0

-- ========================
--        Font
-- ========================
config.font = wezterm.font("JetBrains Mono")

-- ========================
--        Workspace
-- ========================
wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

config.keys = {
	-- Switch to the default workspace
	{
		key = "0",
		mods = "ALT",
		action = act.SwitchToWorkspace({
			name = "default",
		}),
	},
	-- Switch to a monitoring workspace, which will have `top` launched into it
	{
		key = "u",
		mods = "ALT",
		action = act.SwitchToWorkspace({
			name = "monitoring",
			spawn = {
				args = { "top" },
			},
		}),
	},
	-- Create a new workspace with a random name and switch to it
	{ key = "i", mods = "ALT", action = act.SwitchToWorkspace },
	-- Show the launcher in fuzzy selection mode and have it list all workspaces
	-- and allow activating one.
	{
		key = "9",
		mods = "ALT",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
	{ key = "n", mods = "ALT", action = act.SwitchWorkspaceRelative(1) },
	{ key = "p", mods = "ALT", action = act.SwitchWorkspaceRelative(-1) },
	-- NOTE: Waiting for a new release to kill workspace
}

return config
