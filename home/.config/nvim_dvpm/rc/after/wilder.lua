-- =============================================================================
-- File        : wilder.lua
-- Author      : yukimemi
-- Last Change : 2023/12/04 01:33:40.
-- =============================================================================

local wilder = require('wilder')
wilder.setup({ modes = { ':', '/', '?' } })
-- Disable Python remote plugin
wilder.set_option('use_python_remote_plugin', 0)

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      fuzzy = 1,
    }),
    wilder.vim_search_pipeline()
  )
})

wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
    highlighter = wilder.basic_highlighter(),
    left = {
      ' ',
      wilder.popupmenu_devicons()
    },
    right = {
      ' ',
      wilder.popupmenu_scrollbar()
    },
  })),
  ['/'] = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
    highlighter = wilder.basic_highlighter(),
  })),
}))
