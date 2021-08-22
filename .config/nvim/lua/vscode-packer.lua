vim.cmd(
    [[autocmd BufWritePost vscode-packer.lua source <afile> | PackerCompile]])

local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    execute 'silent! packadd packer.nvim'
end

return require('packer').startup(function()
    use {'wbthomason/packer.nvim'}

    use {'andymass/vim-matchup', event = 'VimEnter'}

    -- Visual.
    use {
        'ntpeters/vim-better-whitespace',
        event = {'CursorHold', 'CursorMoved', 'FocusLost'}
    }
    use {
        'itchyny/vim-highlighturl',
        event = {'CursorHold', 'CursorMoved', 'FocusLost'}
    }

    -- Textobj.
    use {'kana/vim-textobj-user'}
    use {'gilligan/textobj-lastpaste', event = 'VimEnter'}
    use {'kana/vim-textobj-entire', event = 'VimEnter'}
    use {'kana/vim-textobj-fold', event = 'VimEnter'}
    use {'kana/vim-textobj-function', event = 'VimEnter'}
    use {'kana/vim-textobj-indent', event = 'VimEnter'}
    use {'kana/vim-textobj-line', event = 'VimEnter'}
    use {'machakann/vim-textobj-delimited', event = 'VimEnter'}
    use {'osyo-manga/vim-textobj-multiblock', event = 'VimEnter'}
    use {'mattn/vim-textobj-url', event = 'VimEnter'}

    --  Operator.
    use {'kana/vim-operator-user'}
    use {
        'kana/vim-operator-replace',
        event = 'VimEnter',
        setup = vim.cmd [[source $VIM_PATH/rc/vim-operator-replace.vim]]
    }
    use {'machakann/vim-sandwich', event = 'VimEnter'}
    use {'machakann/vim-swap', event = 'VimEnter'}
    use {'osyo-manga/vim-operator-search', event = 'VimEnter'}
    use {'osyo-manga/vim-operator-stay-cursor', event = 'VimEnter'}

    -- Search.
    use {
        'haya14busa/vim-asterisk',
        event = 'VimEnter',
        setup = vim.cmd [[source $VIM_PATH/rc/vim-asterisk.vim]]
    }

    -- Util.
    use {'Shougo/junkfile.vim', cmd = 'JunkfileOpen'}
    use {'thinca/vim-ambicmd'}
    use {'thinca/vim-prettyprint', cmd = 'PP'}
    use {'tpope/vim-repeat', event = 'VimEnter'}
    use {'vim-scripts/autodate.vim', event = 'InsertEnter'}
    use {'mattn/vim-sonictemplate', on = 'Template'}

end)

