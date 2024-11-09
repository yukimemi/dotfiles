-- =============================================================================
-- File        : init.lua
-- Author      : yukimemi
-- Last Change : 2024/11/09 15:19:16.
-- =============================================================================

-- https://github.com/dawsers/dual-pane.yazi
require("dual-pane"):setup()

-- https://github.com/Rolv-Apneseth/starship.yazi
require("starship"):setup()

-- https://github.com/hankertrix/augment-command.yazi
require("augment-command"):setup({
  prompt = true,
})
-- https://github.com/MasouShizuka/projects.yazi
require("projects"):setup({})

-- https://github.com/h-hg/yamb.yazi
require("yamb"):setup({})
