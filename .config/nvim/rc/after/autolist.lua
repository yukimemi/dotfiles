-- =============================================================================
-- File        : autolist.lua
-- Author      : yukimemi
-- Last Change : 2023/12/04 01:32:07.
-- =============================================================================

local autolist = require("autolist")
autolist.setup()
autolist.create_mapping_hook("i", "<CR>", autolist.new)
autolist.create_mapping_hook("i", "<Tab>", autolist.indent)
autolist.create_mapping_hook("i", "<S-Tab>", autolist.indent, "<C-D>")
autolist.create_mapping_hook("n", "o", autolist.new)
autolist.create_mapping_hook("n", "O", autolist.new_before)
autolist.create_mapping_hook("n", ">>", autolist.indent)
autolist.create_mapping_hook("n", "<<", autolist.indent)
autolist.create_mapping_hook("n", "<C-r>", autolist.force_recalculate)
autolist.create_mapping_hook("n", "<leader>x", autolist.invert_entry, "")
