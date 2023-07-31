local wezterm = require("wezterm")

local config = {
    color_scheme = "VSCodeDark+ (Gogh)",
    font_size = 15.0,
    font = wezterm.font("Roboto Mono"),
    use_dead_keys = false,
    window_decorations = "RESIZE",
    hide_tab_bar_if_only_one_tab = true,
    line_height = 1.0,
    tab_bar_at_bottom = true,
    window_background_opacity = 0.95,
    keys = {
      { key = "n", mods = "SUPER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
      { key = "h", mods = "SUPER|SHIFT", action = wezterm.action({ ActivateTabRelative = -1 }) },
      { key = "l", mods = "SUPER|SHIFT", action = wezterm.action({ ActivateTabRelative = 1 }) },
      { key = "k", mods = "SUPER", action = "ActivateCopyMode" },
      { key = "j", mods = "SUPER", action = wezterm.action({ PasteFrom = "PrimarySelection" }) },
      { key = "1", mods = "SUPER", action = wezterm.action({ ActivateTab = 0 }) },
      { key = "2", mods = "SUPER", action = wezterm.action({ ActivateTab = 1 }) },
      { key = "3", mods = "SUPER", action = wezterm.action({ ActivateTab = 2 }) },
      { key = "4", mods = "SUPER", action = wezterm.action({ ActivateTab = 3 }) },
      { key = "5", mods = "SUPER", action = wezterm.action({ ActivateTab = 4 }) },
      { key = "6", mods = "SUPER", action = wezterm.action({ ActivateTab = 5 }) },
      { key = "7", mods = "SUPER", action = wezterm.action({ ActivateTab = 6 }) },
      { key = "8", mods = "SUPER", action = wezterm.action({ ActivateTab = 7 }) },
      { key = "9", mods = "SUPER", action = wezterm.action({ ActivateTab = 8 }) },
      { key = "T", mods = "SUPER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
      { key = "t", mods = "SUPER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
      { key = "h", mods = "SUPER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
      { key = "l", mods = "SUPER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
      { key = "k", mods = "SUPER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
      { key = "j", mods = "SUPER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
      { key = "h", mods = "SUPER|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }) },
      { key = "l", mods = "SUPER|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }) },
      { key = "k", mods = "SUPER|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }) },
      { key = "j", mods = "SUPER|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }) }
    }
  }

  return config
