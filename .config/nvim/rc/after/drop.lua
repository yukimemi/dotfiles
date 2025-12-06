-- =============================================================================
-- File        : drop.lua
-- Author      : yukimemi
-- Last Change : 2025/12/02 11:19:38.
-- =============================================================================

require("drop").setup({
  themes = {
    { theme = "new_year",            from = { month = 12, day = 26 }, to = { month = 1, day = 10 } },
    { theme = "valentines_day",      from = { month = 2, day = 1 },   to = { month = 2, day = 14 } },
    { theme = "st_patricks_day",     from = { month = 3, day = 1 },   to = { month = 3, day = 14 } },
    { theme = "easter",              holiday = "easter" },
    { theme = "april_fools",         from = { month = 4, day = 1 },   to = { month = 4, day = 15 } },
    { theme = "us_independence_day", month = 7,                       day = 4 },
    { theme = "halloween",           from = { month = 10, day = 1 },  to = { month = 10, day = 31 } },
    { theme = "us_thanksgiving",     holiday = "us_thanksgiving" },
    { theme = "xmas",                from = { month = 11, day = 1 },  to = { month = 12, day = 25 } },
    { theme = "leaves",              from = { month = 9, day = 22 },  to = { month = 9, day = 30 } },
    { theme = "snow",                from = { month = 12, day = 26 }, to = { month = 3, day = 19 } },
    { theme = "spring",              from = { month = 3, day = 20 },  to = { month = 6, day = 20 } },
    { theme = "summer",              from = { month = 6, day = 21 },  to = { month = 9, day = 21 } },
  },
  screensaver = 1000 * 60 * 30,
})
