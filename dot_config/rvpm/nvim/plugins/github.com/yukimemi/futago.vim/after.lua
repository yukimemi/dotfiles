-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/04/20 01:10:06.
-- =============================================================================

vim.keymap.set("n", "mf",
  '<cmd>call futago#start_chat({"opener": "vsplit", "humanPrompt": "yukimemi", "history": [{"role": "user", "parts": [{ "text": "僕の名前は yukimemi。敬語は使わずにフレンドリーに回答してね。" }]}, {"role": "model", "parts": [{ "text": "了解！覚えておくね！" }]}]})<cr>')
