local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(
	config,
  	{
		modules = {
			username = {
				enabled = false,
				icon = wezterm.nerdfonts.fa_user,
				color = 6,
			},
			hostname = {
				enabled = false,
				icon = wezterm.nerdfonts.cod_server,
				color = 8,
			},
		},
  	}
)
-- local gpus = wezterm.gui.enumerate_gpus()
-- config.webgpu_preferred_adapter = gpus[1]
-- config.front_end = "WebGpu"

-- Functions
local function get_current_working_dir(tab)
	local current_dir = tostring(tab.active_pane.current_working_dir) or ''
	current_dir = string.gsub(current_dir, "^file:///[A-Za-z]:/", "")
	return current_dir
end

local process_icons = {
	['docker'] = wezterm.nerdfonts.linux_docker,
	['docker-compose'] = wezterm.nerdfonts.linux_docker,
	['psql'] = wezterm.nerdfonts.dev_postgresql,
	['kuberlr'] = wezterm.nerdfonts.linux_docker,
	['kubectl'] = wezterm.nerdfonts.linux_docker,
	['stern'] = wezterm.nerdfonts.linux_docker,
	['nvim'] = wezterm.nerdfonts.custom_vim,
	['make'] = wezterm.nerdfonts.seti_makefile,
	['vim'] = wezterm.nerdfonts.dev_vim,
	['go'] = wezterm.nerdfonts.seti_go,
	['zsh'] = wezterm.nerdfonts.dev_terminal,
	['bash'] = wezterm.nerdfonts.cod_terminal_bash,
	['btm'] = wezterm.nerdfonts.mdi_chart_donut_variant,
	['htop'] = wezterm.nerdfonts.mdi_chart_donut_variant,
	['cargo'] = wezterm.nerdfonts.dev_rust,
	['sudo'] = wezterm.nerdfonts.fa_hashtag,
	['lazydocker'] = wezterm.nerdfonts.linux_docker,
	['git'] = wezterm.nerdfonts.dev_git,
	['lua'] = wezterm.nerdfonts.seti_lua,
	['wget'] = wezterm.nerdfonts.mdi_arrow_down_box,
	['curl'] = wezterm.nerdfonts.mdi_flattr,
	['gh'] = wezterm.nerdfonts.dev_github_badge,
	['ruby'] = wezterm.nerdfonts.cod_ruby,
	['pwsh'] = wezterm.nerdfonts.seti_powershell,
	['node'] = wezterm.nerdfonts.dev_nodejs_small,
	['dotnet'] = wezterm.nerdfonts.md_language_csharp,
  }
local function get_process(tab)
	local process_name = tab.active_pane.foreground_process_name:match("([^/\\]+)%.exe$") or
		tab.active_pane.foreground_process_name:match("([^/\\]+)$")
  
	-- local icon = process_icons[process_name] or string.format('[%s]', process_name)
	local icon = process_icons[process_name] or wezterm.nerdfonts.seti_checkbox_unchecked
  
	return icon
end

-- Initialize Configuration
local opacity = 0.9
local config = wezterm.config_builder()

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(
	config,
  	{
		modules = {
			username = {
				enabled = false,
				icon = wezterm.nerdfonts.fa_user,
				color = 6,
			},
			hostname = {
				enabled = false,
				icon = wezterm.nerdfonts.cod_server,
				color = 8,
			},
		},
  	}
)

config.front_end = "OpenGL"
config.max_fps = 120
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1 -- If your system does not have GPU or you dont like animations
config.cursor_blink_rate = 500
config.term = "xterm-256color" -- Set the terminal type
config.font = wezterm.font_with_fallback({
    {
        family = "JetBrainsMono Nerd Font",
        weight = "Regular",
    },
    "FiraCode Nerd Font Mono",
})
config.window_background_opacity = opacity
config.prefer_egl = true
config.font_size = 12.0
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Default Dir
config.default_cwd = "C:/Projects"

-- Colorscheme
config.color_scheme = "rose-pine-moon"
local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
-- swap green and blue to match correct theme
local ansi = scheme.ansi
ansi[3] = "#3e8fb0"
ansi[5] = "#9ccfd8"

local brights = scheme.brights
brights[3] = "#3e8fb0"
brights[5] = "#9ccfd8"

local colors = {
	tab_bar = {
		background = "transparent",
		active_tab = {
			fg_color = ansi[4],
			bg_color = "#2a273f",
		},
		inactive_tab = {
			fg_color = ansi[6],
			bg_color = "#2a273f",
		},
	},
	cursor_bg = "#56526e",
	cursor_border = "#56526e",
	cursor_fg = scheme.foreground,
	selection_bg = "#44415a",
	split = scheme.ansi[7],
	ansi = ansi,
	brights = brights,
	compose_cursor = scheme.ansi[2]
}

config.colors = colors
config.command_palette_bg_color = "#393552"
config.command_palette_fg_color = scheme.foreground
config.force_reverse_video_cursor = false
config.inactive_pane_hsb = { brightness = 0.9 }
-- config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_decorations = "RESIZE"

-- Tabs
config.hide_tab_bar_if_only_one_tab = false
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = true

-- Keymaps
config.leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 3000 }
config.keys = {
	{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },

	-- Pane Keybindings
	{ key = "-", mods = "LEADER", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
	{ key = "|", mods = "LEADER", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane { confirm = true } },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "s", mods = "LEADER", action = act.RotatePanes "Clockwise" },
	-- We could make separate keybindings for resizing panes
	-- But Wezterm offers a custom mode we will use here
	{ key = "r", mods = "LEADER", action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },
  
	-- Tab Keybindings
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "t", mods = "LEADER", action = act.ShowTabNavigator },
	-- Table for moving tabs around
	{ key = "m", mods = "LEADER", action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },
  
	-- Workspace
	{ key = "w", mods = "LEADER", action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
	{
	  key = 'W',
	  mods = 'LEADER',
	  action = act.PromptInputLine {
		description = wezterm.format {
		  { Attribute = { Intensity = 'Bold' } },
		  { Foreground = { AnsiColor = 'Fuchsia' } },
		  { Text = 'Enter name for new workspace' },
		},
		action = wezterm.action_callback(function(window, pane, line)
		  -- line will be `nil` if they hit escape without entering anything
		  -- An empty string if they just hit enter
		  -- Or the actual line of text they wrote
		  if line then
			window:perform_action(
			  act.SwitchToWorkspace {
				name = line,
			  },
			  pane
			)
		  end
		end),
	  },
	},

	-- Other 
	{
		key = "h",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "U",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "I",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "O",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "P",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{ key = "9", mods = "CTRL", action = act.PaneSelect },
	{ key = "L", mods = "CTRL", action = act.ShowDebugOverlay },
	{
		key = "O",
		mods = "CTRL|ALT",
		-- toggling opacity
		action = wezterm.action_callback(function(window, _)
			local overrides = window:get_config_overrides() or {}
			if overrides.window_background_opacity == 1.0 then
				overrides.window_background_opacity = opacity
			else
				overrides.window_background_opacity = 1.0
			end
			window:set_config_overrides(overrides)
		end),
	},
	{
		key = "B",
		mods = "CTRL|ALT",
		action = wezterm.action_callback(function(window, _)
			local overrides = window:get_config_overrides() or {}
			overrides.colors = colors
			if overrides.colors and overrides.colors.background == "#000000" then
				overrides.colors.tab_bar.active_tab.bg_color = scheme.background
				overrides.colors.background = scheme.background
			else
				overrides.colors.tab_bar.active_tab.bg_color = "#000000"
				overrides.colors.background = "#000000"
			end
			window:set_config_overrides(overrides)
		end),
	},
	{
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
}

-- Quick tab movement
for i = 1, 9 do
	table.insert(config.keys, {
	  key = tostring(i),
	  mods = "LEADER",
	  action = act.ActivateTab(i - 1)
	})
end

-- Default Shell Configuration
config.default_prog = { "pwsh", "-NoLogo" }
config.initial_cols = 80


-- and finally, return the configuration to wezterm
return config
