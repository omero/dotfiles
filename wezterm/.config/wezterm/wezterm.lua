-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- How many lines of scrollback you want to retain per tab
config.scrollback_lines = 3500

-- Color scheme:
config.color_scheme = 'Catppuccin Mocha (Gogh)'
--config.color_scheme = 'catppuccin-mocha'

-- Background properties
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20

-- Fonts
config.font = wezterm.font 'MonaspiceNe Nerd Font Mono'
config.font_size = 15

-- Window decoration
config.window_decorations = "RESIZE"

-- Remove tabs if only one 
config.hide_tab_bar_if_only_one_tab = true

---- Status bar
--local TITLEBAR_COLOR = '#333333'
--
--wezterm.on('update-status', function(window, pane)
--    local cells = {}
--
--    -- Figure out the hostname of the pane on a best-effort basis
--    local hostname = wezterm.hostname()
--    local cwd_uri = pane:get_current_working_dir()
--    if cwd_uri and cwd_uri.host then
--        hostname = cwd_uri.host
--    end
--    table.insert(cells, ' ' .. hostname)
--
--    -- Format date/time in this style: "Wed Mar 3 08:14"
--    local date = wezterm.strftime ' %a %b %-d %H:%M'
--    table.insert(cells, date)
--
--    -- Add an entry for each battery (typically 0 or 1)
--    local batt_icons = {'', '', '', '', ''}
--    for _, b in ipairs(wezterm.battery_info()) do
--        local curr_batt_icon = batt_icons[math.ceil(b.state_of_charge * #batt_icons)]
--        table.insert(cells, string.format('%s %.0f%%', curr_batt_icon, b.state_of_charge * 100))
--    end
--
--    -- Color palette for each cell
--    local text_fg = '#c0c0c0'
--    local colors = {
--        TITLEBAR_COLOR,
--        '#3c1361',
--        '#52307c',
--        '#663a82',
--        '#7c5295',
--        '#b491c8',
--    }
--
--    local elements = {}
--    while #cells > 0 and #colors > 1 do
--        local text = table.remove(cells, 1)
--        local prev_color = table.remove(colors, 1)
--        local curr_color = colors[1]
--
--        table.insert(elements, { Background = { Color = prev_color } })
--        table.insert(elements, { Foreground = { Color = curr_color } })
--        table.insert(elements, { Text = '' })
--        table.insert(elements, { Background = { Color = curr_color } })
--        table.insert(elements, { Foreground = { Color = text_fg } })
--        table.insert(elements, { Text = ' ' .. text .. ' ' })
--    end
--    window:set_right_status(wezterm.format(elements))
--end)

-- Hyperlink config
-- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
    regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
    format = 'https://www.github.com/$1/$3',
})

-- Key bindings
config.keys = {
    { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen, },
    { key = 'q', mods = 'ALT', action = act.QuitApplication, },
    { key = 'o', mods = 'ALT', action = act.EmitEvent 'open-hx-with-scrollback', },

    { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left', },
    { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right', },
    { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down', },
    { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up', },

    { key = 'h', mods = 'SHIFT|ALT', action = act.AdjustPaneSize {'Left', 4}, },
    { key = 'l', mods = 'SHIFT|ALT', action = act.AdjustPaneSize {'Right', 4}, },
    { key = 'j', mods = 'SHIFT|ALT', action = act.AdjustPaneSize {'Down', 4}, },
    { key = 'k', mods = 'SHIFT|ALT', action = act.AdjustPaneSize {'Up', 4}, },

    { key = 'd', mods = 'ALT', action = act.SplitVertical, },
    { key = 'r', mods = 'ALT', action = act.SplitHorizontal, },

    { key = '[', mods = 'ALT', action = act.ActivateTabRelative(-1), },
    { key = ']', mods = 'ALT', action = act.ActivateTabRelative(1), },

    -- Floating panes (not implemented yet)
    -- bind "Alt w" { ToggleFloatingPanes; }
    -- bind "Alt e" { TogglePaneEmbedOrFloating; }
    -- bind "Alt b" { MovePaneBackwards; }

    -- Using defaults for tabs (CMD t, CMD 1-9)
    -- Using defaults for find (CMD f, CTRL-r to toggle case sensitivity & regex modes) 
}

-- and finally, return the configuration to wezterm
return config
