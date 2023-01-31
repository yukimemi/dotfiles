return {

  "octaltree/linearf",
  dependencies = {
    "octaltree/linearf-my-flavors",
  },

  enabled = false,

  event = "VeryLazy",

  config = function()
    local linearf = require('linearf')
    local flavors = require('linearf-my-flavors')

    -- Initialize with a view module
    linearf.init(require('linearf-vanilla').new())

    -- Specify the sources to include in the build
    linearf.recipe.sources = {
      { name = "identity", path = "flavors_plain::Identity" },
      { name = "command", path = "flavors_tokio::Command" }
    }
    linearf.recipe.converters = {
      { name = "format_line", path = "flavors_plain::FormatLine" }
    }
    linearf.recipe.matchers = {
      { name = "identity", path = "flavors_plain::Identity" },
      { name = "substring", path = "flavors_plain::Substring" },
      { name = "clap", path = "flavors_clap::Clap" }
    }
    -- Auto-build if you want
    linearf.bridge.try_build_if_not_exist = true
    linearf.bridge.try_build_on_error = true

    -- Define your scenario. flavors provides you with several presets
    local function set(target, context_manager, scenario)
      linearf.context_managers[target] = context_manager
      linearf.scenarios[target] = scenario
    end

    set('line', flavors.context_managers['line'], flavors.merge {
      flavors.scenarios['line'],
      flavors.scenarios.quit,
      flavors.scenarios.no_list_insert,
      flavors.scenarios.no_querier_normal,
      {
        linearf = {
          list_nnoremap = {
            ["<CR>"] = flavors.hide_and(flavors.actions.line.jump)
          },
          querier_inoremap = {
            ["<CR>"] = flavors.normal_and(
              flavors.hide_and(flavors.actions.line.jump))
          }
        },
        view = { querier_on_start = 'insert' }
      }
    })
    local use_rg = false
    set('file', flavors.context_managers[use_rg and 'file_rg' or 'file_find'],
      flavors.merge {
        flavors.scenarios[use_rg and 'file_rg' or 'file_find'],
        flavors.scenarios.quit,
        flavors.scenarios.no_list_insert,
        flavors.scenarios.no_querier_normal,
        {
          linearf = {
            list_nnoremap = {
              ["<CR>"] = flavors.hide_and(flavors.actions.file.open),
              ["<nowait>s"] = flavors.hide_and(flavors.actions.file.split),
              ["t"] = flavors.hide_and(flavors.actions.file.tabopen),
              ["v"] = flavors.hide_and(flavors.actions.file.vsplit)
            },
            querier_inoremap = {
              ["<CR>"] = flavors.normal_and(
                flavors.hide_and(flavors.actions.file.open))
            }
          }
        }
      })
    set('grep', flavors.context_managers[use_rg and 'grep_rg' or 'grep_grep'],
      flavors.merge {
        flavors.scenarios[use_rg and 'grep_rg' or 'grep_grep'],
        flavors.scenarios.quit,
        flavors.scenarios.no_list_insert,
        flavors.scenarios.enter_list,
        {
          linearf = {
            list_nnoremap = {
              ["<CR>"] = flavors.hide_and(flavors.actions.grep.open),
              ["<nowait>s"] = flavors.hide_and(flavors.actions.grep.split),
              ["t"] = flavors.hide_and(flavors.actions.grep.tabopen),
              ["v"] = flavors.hide_and(flavors.actions.grep.vsplit)
            },
            querier_inoremap = {},
            querier_nnoremap = {
              ["<nowait><ESC>"] = flavors.actions.view.goto_list
            }
          }
        }
      })

    -- optional
    linearf.utils.command("nnoremap <silent><space>L/ <cmd>lua linearf.run('line')<CR>")
    linearf.utils.command("nnoremap <silent><space>Lf <cmd>lua linearf.run('file')<CR>")
    linearf.utils.command("nnoremap <silent><space>Lg <cmd>lua linearf.run('grep')<CR>")
    linearf.utils.command("nnoremap <silent><space>Ll <cmd>lua linearf.resume_last()<CR>")
  end,
}
