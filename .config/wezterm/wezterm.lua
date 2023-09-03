local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  front_end = "WebGpu",
  adjust_window_size_when_changing_font_size = false,
  color_scheme = 'Catppuccin Mocha',
  dpi = 96.0,
  font = wezterm.font_with_fallback({
    "UDEV Gothic NF",
    "PlemolJP Console NF",
    "HackGen Console NF",
  }),
  font_size = 13.0,
  hide_tab_bar_if_only_one_tab = true,
  use_ime = true,
  window_background_opacity = 0.90,
  scrollback_lines = 3500,
}
