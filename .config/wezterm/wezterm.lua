local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  adjust_window_size_when_changing_font_size = false,
  color_scheme = "Sakura",
  dpi = 96.0,
  font = wezterm.font_with_fallback {
    "Cica",
  },
  font_size = 15.0;
  hide_tab_bar_if_only_one_tab = true,
  use_ime = true,
  window_background_opacity = 0.90,
  scrollback_lines = 3500,
}

