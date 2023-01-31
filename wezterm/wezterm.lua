local wezterm = require("wezterm")
local utils = require("utils")

---------------------------------------------------------------
--- keybinds
---------------------------------------------------------------
local tmux_keybinds = {
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
    { key = "j", mods = "SUPER|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }) },
  }

local default_keybinds = {
    { key = "c", mods = "SUPER", action = wezterm.action({ CopyTo = "Clipboard" }) },
    { key = "v", mods = "SUPER", action = wezterm.action({ PasteFrom = "Clipboard" }) },
    { key = "=", mods = "SUPER", action = "ResetFontSize" },
    { key = "+", mods = "SUPER|SHIFT", action = "IncreaseFontSize" },
    { key = "_", mods = "SUPER|SHIFT", action = "DecreaseFontSize" },
    { key = "Space", mods = "SUPER|SHIFT", action = "QuickSelect" },
    { key = "r", mods = "SUPER", action = "ReloadConfiguration" },
    { key = "w", mods = "SUPER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
    { key = "q", mods = "SUPER", action = "HideApplication"},
  }

local function create_keybinds()
  return utils.merge_lists(default_keybinds, tmux_keybinds)
  end

---------------------------------------------------------------
--- load local_config
---------------------------------------------------------------
-- Write settings you don't want to make public, such as ssh_domains
local function load_local_config()
  local ok, _ = pcall(require, "local")
  if not ok then
    return {}
  end
  return require("local").setup()
  end
local local_config = load_local_config()

-- local M = {}
-- local local_config = {
  --   ssh_domains = {
  --     {
  --       -- This name identifies the domain
--       name = "my.server",
--       -- The address to connect to
--       remote_address = "192.168.8.31",
--       -- The username to use on the remote host
--       username = "katayama",
--     },
--   },
-- }
-- function M.setup()
--   return local_config
-- end
-- return M

---------------------------------------------------------------
--- Config
---------------------------------------------------------------
local config = {
    color_scheme = "VSCodeDark+ (Gogh)",
    font_size = 15.0,
    font = wezterm.font("Comic Code"),
    use_dead_keys = false,
    window_decorations = "RESIZE",
    -- hide_tab_bar_if_only_one_tab = true,
    line_height = 1.0,
    keys = create_keybinds(),
    disable_default_key_bindings = true,
    -- tab_bar_at_bottom = true,
    -- window_background_opacity = 0.9,
  }

return utils.merge_tables(config, local_config)
