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
    keys = {
      { key = "a", mods = "SUPER|CTRL",  action=wezterm.action{SendString="\x01"}},
      { key = "-", mods = "SUPER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
      { key = "\\",mods = "SUPER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
      { key = "s", mods = "SUPER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
      { key = "v", mods = "SUPER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
      { key = "o", mods = "SUPER",       action="TogglePaneZoomState" },
      { key = "z", mods = "SUPER",       action="TogglePaneZoomState" },
      { key = "c", mods = "SUPER",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
      { key = "h", mods = "SUPER",       action=wezterm.action{ActivatePaneDirection="Left"}},
      { key = "j", mods = "SUPER",       action=wezterm.action{ActivatePaneDirection="Down"}},
      { key = "k", mods = "SUPER",       action=wezterm.action{ActivatePaneDirection="Up"}},
      { key = "l", mods = "SUPER",       action=wezterm.action{ActivatePaneDirection="Right"}},
      { key = "H", mods = "SUPER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
      { key = "J", mods = "SUPER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
      { key = "K", mods = "SUPER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
      { key = "L", mods = "SUPER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
      { key = "1", mods = "SUPER",       action=wezterm.action{ActivateTab=0}},
      { key = "2", mods = "SUPER",       action=wezterm.action{ActivateTab=1}},
      { key = "3", mods = "SUPER",       action=wezterm.action{ActivateTab=2}},
      { key = "4", mods = "SUPER",       action=wezterm.action{ActivateTab=3}},
      { key = "5", mods = "SUPER",       action=wezterm.action{ActivateTab=4}},
      { key = "6", mods = "SUPER",       action=wezterm.action{ActivateTab=5}},
      { key = "7", mods = "SUPER",       action=wezterm.action{ActivateTab=6}},
      { key = "8", mods = "SUPER",       action=wezterm.action{ActivateTab=7}},
      { key = "9", mods = "SUPER",       action=wezterm.action{ActivateTab=8}},
      { key = "&", mods = "SUPER|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=true}}},
      { key = "d", mods = "SUPER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
      { key = "x", mods = "SUPER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
      { key = "u", mods = "SUPER",       action = "ActivateCopyMode" },
      { key = "i", mods = "SUPER",       action = wezterm.action({ PasteFrom = "PrimarySelection" }) },
    },
  }

return config
