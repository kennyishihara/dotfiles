-- Wezterm config inspired by theopn https://github.com/theopn/dotfiles/tree/main/wezterm

local wezterm = require("wezterm")
local act = wezterm.action

local config = {
    color_scheme = "Kanagawa (Gogh)",
    font_size = 15.0,
    font = wezterm.font("Roboto Mono"),
    use_dead_keys = false,
    hide_tab_bar_if_only_one_tab = true,
    window_decorations = "RESIZE",
    line_height = 1.0,
    inactive_pane_hsb = {
        saturation = 0.24,
        brightness = 0.5,
    },
    -- While we test out tmux, change the leader to C-b
    leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },
    keys = {
        { key = "a",          mods = "LEADER|CTRL", action = act.SendKey { key = "a", mods = "CTRL" } },
        { key = "phys:Space", mods = "LEADER",      action = act.ActivateCommandPalette },
        { key = "c",          mods = "LEADER",      action = "ActivateCopyMode" },

        -- Panes
        { key = "s",          mods = "LEADER",      action = act.SplitVertical { domain = "CurrentPaneDomain" } },
        { key = "v",          mods = "LEADER",      action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
        { key = "h",          mods = "LEADER",      action = act.ActivatePaneDirection("Left") },
        { key = "j",          mods = "LEADER",      action = act.ActivatePaneDirection("Down") },
        { key = "k",          mods = "LEADER",      action = act.ActivatePaneDirection("Up") },
        { key = "l",          mods = "LEADER",      action = act.ActivatePaneDirection("Right") },
        { key = "q",          mods = "LEADER",      action = act.CloseCurrentPane { confirm = true } },
        { key = "o",          mods = "LEADER",      action = act.TogglePaneZoomState },
        { key = "r",          mods = "LEADER",      action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },

        -- Tabs
        { key = "t",          mods = "LEADER",      action = act.SpawnTab("CurrentPaneDomain") },
        { key = "[",          mods = "LEADER",      action = act.ActivateTabRelative(-1) },
        { key = "]",          mods = "LEADER",      action = act.ActivateTabRelative(1) },
        { key = "n",          mods = "LEADER",      action = act.ShowTabNavigator },
        {
            key = "e",
            mods = "LEADER",
            action = act.PromptInputLine {
                description = wezterm.format {
                    { Attribute = { Intensity = "Bold" } },
                    { Foreground = { AnsiColor = "Fuchsia" } },
                    { Text = "Renaming Tab Title...:" },
                },
                action = wezterm.action_callback(function(window, pane, line)
                    if line then
                        window:active_tab():set_title(line)
                    end
                end)
            }
        },
        -- Key table for moving tabs around
        { key = "m", mods = "LEADER",       action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },
        -- Or shortcuts to move tab w/o move_tab table. SHIFT is for when caps lock is on
        { key = "{", mods = "LEADER|SHIFT", action = act.MoveTabRelative(-1) },
        { key = "}", mods = "LEADER|SHIFT", action = act.MoveTabRelative(1) },

        -- Lastly, workspace
        { key = "w", mods = "LEADER",       action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
    },

}

-- Move around tabs with index
for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = act.ActivateTab(i - 1)
    })
end

config.key_tables = {
    resize_pane = {
        { key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
        { key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
        { key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
        { key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
        { key = "Escape", action = "PopKeyTable" },
        { key = "Enter",  action = "PopKeyTable" },
    },
    move_tab = {
        { key = "h",      action = act.MoveTabRelative(-1) },
        { key = "j",      action = act.MoveTabRelative(-1) },
        { key = "k",      action = act.MoveTabRelative(1) },
        { key = "l",      action = act.MoveTabRelative(1) },
        { key = "Escape", action = "PopKeyTable" },
        { key = "Enter",  action = "PopKeyTable" },
    }
}

config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = false
wezterm.on("update-status", function(window, pane)
    -- Workspace name
    local stat = window:active_workspace()
    local stat_color = "#f7768e"
    -- It's a little silly to have workspace name all the time
    -- Utilize this to display LDR or current key table name
    if window:active_key_table() then
        stat = window:active_key_table()
        stat_color = "#7dcfff"
    end
    if window:leader_is_active() then
        stat = "LDR"
        stat_color = "#bb9af7"
    end

    local basename = function(s)
        -- Nothing a little regex can't fix
        return string.gsub(s, "(.*[/\\])(.*)", "%2")
    end

    -- Current working directory
    local cwd = pane:get_current_working_dir()
    if cwd then
        if type(cwd) == "userdata" then
            -- Wezterm introduced the URL object in 20240127-113634-bbcac864
            cwd = basename(cwd.file_path)
        else
            -- 20230712-072601-f4abf8fd or earlier version
            cwd = basename(cwd)
        end
    else
        cwd = ""
    end

    -- Current command
    local cmd = pane:get_foreground_process_name()
    -- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
    cmd = cmd and basename(cmd) or ""

    -- Time
    local time = wezterm.strftime("%H:%M:%S")

    -- Left status (left of the tab line)
    window:set_left_status(wezterm.format({
        { Foreground = { Color = stat_color } },
        { Text = "  " },
        { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
        { Text = " |" },
    }))

    -- Right status
    window:set_right_status(wezterm.format({
        -- Wezterm has a built-in nerd fonts
        -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
        { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
        { Text = " | " },
        { Foreground = { Color = "#e0af68" } },
        { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
        "ResetAttributes",
        { Text = " | " },
        { Text = wezterm.nerdfonts.md_clock .. "  " .. time },
        { Text = "  " },
    }))
end)

return config
