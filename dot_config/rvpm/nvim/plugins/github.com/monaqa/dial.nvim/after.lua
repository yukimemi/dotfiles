-- =============================================================================
-- File        : dial.lua
-- Author      : yukimemi
-- Last Change : 2023/12/04 01:32:19.
-- =============================================================================

local augend = require("dial.augend")
require("dial.config").augends:register_group({
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.new {
      pattern = "%Y/%m/%d",
      default_kind = "day",
    },
    augend.date.new {
      pattern = "%Y-%m-%d",
      default_kind = "day",
    },
    augend.date.new {
      pattern = "%m/%d",
      default_kind = "day",
      only_valid = true,
    },
    augend.date.new {
      pattern = "%H:%M",
      default_kind = "day",
      only_valid = true,
    },
    augend.constant.alias.ja_weekday_full,
    augend.case.new({
      types = { "camelCase", "snake_case", "PascalCase", "SCREAMING_SNAKE_CASE" },
      cyclic = true,
    }),
  },
})
