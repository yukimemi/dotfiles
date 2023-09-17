-- =============================================================================
-- File        : wezterm.lua
-- Author      : yukimemi
-- Last Change : 2023/09/17 19:59:12.
-- =============================================================================

local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  front_end = "WebGpu",
  adjust_window_size_when_changing_font_size = false,
  -- color_scheme = 'Catppuccin Mocha',
  color_scheme = 'Popping and Locking',
  audible_bell = "Disabled",
  dpi = 96.0,
  font = wezterm.font_with_fallback({
    "PlemolJP Console NF",
    "UDEV Gothic NF",
    "HackGen Console NF",
  }),
  font_size = 13.0,
  hide_tab_bar_if_only_one_tab = true,
  use_ime = true,
  window_background_opacity = 0.90,
  scrollback_lines = 3500,
}
