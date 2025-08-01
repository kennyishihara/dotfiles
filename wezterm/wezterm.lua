local wezterm = require("wezterm")
local act = wezterm.action

local config = {
    color_scheme = "One Half Black (Gogh)",
    font_size = 16.0,
    font = wezterm.font("Roboto Mono"),
    window_background_opacity = 0.90,
    macos_window_background_blur = 30,
    use_dead_keys = false,
    hide_tab_bar_if_only_one_tab = true,
    window_decorations = "RESIZE",
    line_height = 1.0,
    audible_bell = "Disabled",
    -- Try to fix the left alt issue with Mac... https://github.com/wez/wezterm/issues/5468
    send_composed_key_when_left_alt_is_pressed = true,
    send_composed_key_when_right_alt_is_pressed = false,
    inactive_pane_hsb = {
        saturation = 0.24,
        brightness = 0.5,
    },
    -- While we test out tmux, change the leader to random
    leader = { key = "`", mods = "CTRL", timeout_milliseconds = 1000 },
    keys = {
        { key = "a",        mods = "LEADER|CTRL", action = act.SendKey { key = "a", mods = "CTRL" } },
        { key = "q",        mods = "LEADER",      action = act.CloseCurrentPane { confirm = true } },
        { key = "LeftArrow", mods = "OPT",        action = wezterm.action { SendString = "\x1bb" } },
        { key = "RightArrow", mods = "OPT",       action = wezterm.action { SendString = "\x1bf" } },
        { key = 'n',        mods = 'OPT',         action = act { SendString = "~" } }
    },
    window_padding = {
        left = 2,
        right = 2,
        top = 2,
        bottom = "0.3cell",
    },
    adjust_window_size_when_changing_font_size = false,
}

-- Move around tabs with index
for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = act.ActivateTab(i - 1)
    })
end

return config
