local wezterm = require("wezterm")
local key_bindings = require("key-bindings")

local launch_menu = {}
local default_prog = {}
local set_environment_variables = {}

-- Using shell
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	Term = "" -- Set to empty so FZF works on windows
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})
	default_prog = { "powershell.exe", "-NoLogo" }
else
	table.insert(launch_menu, {
		label = "zsh",
		args = { "zsh", "-l" },
	})
	default_prog = { "zsh", "-l" }
end

-- Title
local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local pane = tab.active_pane

	local index = ""
	if #tabs > 1 then
		index = string.format("%d: ", tab.tab_index + 1)
	end

	local process = basename(pane.foreground_process_name)

	return { {
		Text = " " .. index .. process .. " ",
	} }
end)

-- Startup
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

local config = {
	-- Basic
	check_for_updates = false,
	switch_to_last_active_tab_when_closing_tab = false,
	enable_scroll_bar = true,

	-- Window
	native_macos_fullscreen_mode = true,
	adjust_window_size_when_changing_font_size = true,
	window_background_opacity = 0.9,
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},
	window_background_image_hsb = {
		brightness = 0.9,
		hue = 1.0,
		saturation = 1.0,
	},
	initial_cols = 160,
	initial_rows = 90,

	-- Font
	font = wezterm.font_with_fallback({
		{
			family = "MesloLGS Nerd Font",
		},
		"MesloLGS NF",
		"Noto Emoji",
		"Noto Serif CJK SC",
	}),
	font_size = 12,
	normalize_output_to_unicode_nfc = true,

	-- Tab bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = false,
	tab_bar_at_bottom = true,
	tab_max_width = 25,

	-- Keys
	disable_default_key_bindings = false,
	keys = key_bindings.keys,
	key_tables = key_bindings.key_tables,

	-- Allow using ^ with single key press
	use_dead_keys = false,

	color_scheme = "One Dark (Gogh)",

	inactive_pane_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 1.0,
	},

	mouse_bindings = {
		{ --Paste on right-click
			event = {
				Down = {
					streak = 1,
					button = "Right",
				},
			},
			mods = "NONE",
			action = wezterm.action({
				PasteFrom = "Clipboard",
			}),
		},
		{
			event = {
				Up = {
					streak = 1,
					button = "Left",
				},
			},
			mods = "NONE",
			action = wezterm.action({
				CompleteSelection = "PrimarySelection",
			}),
		},
		{
			event = {
				Up = {
					streak = 1,
					button = "Left",
				},
			},
			mods = "CTRL",
			action = "OpenLinkAtMouseCursor",
		},
	},

	default_prog = default_prog,
	set_environment_variables = set_environment_variables,
	launch_menu = launch_menu,
}

return config
