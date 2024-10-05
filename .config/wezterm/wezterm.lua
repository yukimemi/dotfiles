-- =============================================================================
-- File        : wezterm.lua
-- Author      : yukimemi
-- Last Change : 2024/10/06 00:27:49.
-- =============================================================================

-- https://karukichi-blog.netlify.app/blogs/wezterm
local status, wezterm = pcall(require, "wezterm")
if not status then
  return
end
local mux = wezterm.mux

local function day_of_week_ja(w_num)
  if w_num == 1 then
    return "日"
  elseif w_num == 2 then
    return "月"
  elseif w_num == 3 then
    return "火"
  elseif w_num == 4 then
    return "水"
  elseif w_num == 5 then
    return "木"
  elseif w_num == 6 then
    return "金"
  elseif w_num == 7 then
    return "土"
  end
end

wezterm.on("update-status", function(window, pane)
  local wday = os.date("*t").wday
  local wday_ja = string.format("(%s) ", day_of_week_ja(wday))
  local date = wezterm.strftime("📆 %Y-%m-%d " .. wday_ja .. "⏰ %H:%M:%S")

  local bat = ""

  for _, b in ipairs(wezterm.battery_info()) do
    local battery_state_of_charge = b.state_of_charge * 100
    local battery_icon = ""

    if battery_state_of_charge >= 80 then
      battery_icon = "🌕 "
    elseif battery_state_of_charge >= 70 then
      battery_icon = "🌖 "
    elseif battery_state_of_charge >= 60 then
      battery_icon = "🌖 "
    elseif battery_state_of_charge >= 50 then
      battery_icon = "🌗 "
    elseif battery_state_of_charge >= 40 then
      battery_icon = "🌗 "
    elseif battery_state_of_charge >= 30 then
      battery_icon = "🌘 "
    elseif battery_state_of_charge >= 20 then
      battery_icon = "🌘 "
    else
      battery_icon = "🌑 "
    end

    bat = string.format("%s%.0f%% ", battery_icon, battery_state_of_charge)
  end

  window:set_right_status(wezterm.format({
    { Text = date .. "  " .. bat },
  }))
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local tab_index = tab.tab_index + 1

  if tab.is_active and string.match(tab.active_pane.title, "Copy mode:") ~= nil then
    return string.format(" %d %s ", tab_index, "Copy mode...")
  end

  return string.format(" %d ", tab_index)
end)

local base_colors = {
  dark = "#172331",
  yellow = "#ffe64d",
}

local colors = {
  cursor_bg = base_colors["yellow"],
  split = "#6fc3df",
  -- the foreground color of selected text
  selection_fg = base_colors["dark"],
  -- the background color of selected text
  selection_bg = base_colors["yellow"],
  tab_bar = {
    background = base_colors["dark"],
    -- The active tab is the one that has focus in the window
    active_tab = {
      bg_color = "aliceblue",
      fg_color = base_colors["dark"],
    },
    -- plus button hidden
    new_tab = {
      bg_color = base_colors["dark"],
      fg_color = base_colors["dark"],
    },
  },
}

local function is_found(str, pattern)
  return string.find(str, pattern) ~= nil
end

local function platform()
  local is_win = is_found(wezterm.target_triple, "windows")
  local is_linux = is_found(wezterm.target_triple, "linux")
  local is_mac = is_found(wezterm.target_triple, "apple")
  local os = is_win and "windows" or is_linux and "linux" or is_mac and "mac" or "unknown"
  return {
    os = os,
    is_win = is_win,
    is_linux = is_linux,
    is_mac = is_mac,
  }
end

local os = platform()

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  -- window:gui_window():maximize()
end)

return {
  adjust_window_size_when_changing_font_size = false,
  audible_bell = "Disabled",
  -- color_scheme = 'Popping and Locking',
  color_scheme = "Catppuccin Mocha",
  -- color_scheme = 'nightfox',
  colors = colors,
  front_end = "WebGpu",
  hide_tab_bar_if_only_one_tab = false,
  leader = leader,
  line_height = 1.00,
  scrollback_lines = 3500,
  use_fancy_tab_bar = false,
  use_ime = true,
  window_background_opacity = 0.90,
  font_size = os.is_mac and 20.0 or 12.0,
  font = wezterm.font_with_fallback({
    "PlemolJP Console NF",
    "UDEV Gothic NF",
    "HackGen Console NF",
  }),
  dpi = 96.0,
  inactive_pane_hsb = {
    saturation = 1,
    brightness = 1,
  },
}
