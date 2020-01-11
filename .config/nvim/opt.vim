Pack 'k-takata/minpac', {'type': 'opt'}

function! Markdown_preview_do(hooktype, name) abort
  echom a:hooktype
  packadd markdown-preview.nvim
  call mkdp#util#install()
endfunction

" Pack 'NLKNguyen/papercolor-theme', {'type': 'opt'}
" Pack 'OmniSharp/Omnisharp-vim', {'type': 'opt', 'for': 'cs'}
" Pack 'PProvost/vim-ps1', {'type': 'opt', 'for': 'ps1'}
" Pack 'Shougo/defx.nvim', {'type': 'opt', 'on': 'Defx', 'do': 'silent! UpdateRemotePlugins', 'if': !g:is_windows}
" Pack 'Shougo/denite.nvim', {'type': 'opt', 'on': 'Denite', 'do': 'silent! UpdateRemotePlugins', 'if': has('python3')}
" Pack 'Shougo/neco-vim', {'type': 'opt', 'for': 'vim'}
" Pack 'Vimjas/vim-python-pep8-indent', {'type': 'opt', 'for': 'python'}
" Pack 'aklt/plantuml-syntax', {'type': 'opt', 'for': 'plantuml'}
" Pack 'basyura/TweetVim', {'type': 'opt', 'on': ['TweetVimHomeTimeline', 'TweetVimUserStream','TweetVimSay']}
" Pack 'basyura/bitly.vim', {'type': 'opt'}
" Pack 'basyura/twibill.vim', {'type': 'opt'}
" Pack 'cespare/vim-toml', {'type': 'opt', 'for': 'toml'}
" Pack 'cocopon/iceberg.vim', {'type': 'opt'}
" Pack 'dag/vim-fish', {'type': 'opt', 'for': 'fish'}
" Pack 'davidhalter/jedi-vim', {'type': 'opt', 'for': ['python']}
" Pack 'eagletmt/ghcmod-vim', {'type': 'opt', 'do': 'silent! !stack install ghc-mod', 'if': executable('stack'), 'for': 'haskell'}
" Pack 'eagletmt/neco-ghc', {'type': 'opt', 'for': 'haskell'}
" Pack 'ekalinin/Dockerfile.vim', {'type': 'opt', 'for': 'dockerfile'}
" Pack 'fatih/vim-go', {'type': 'opt', 'for': 'go'}
" Pack 'joshdick/onedark.vim', {'type': 'opt'}
" Pack 'jremmen/vim-ripgrep', {'type': 'opt', 'on': 'Rg'}
" Pack 'kannokanno/previm', {'type': 'opt', 'for': 'markdown'}
" Pack 'kchmck/vim-coffee-script', {'type': 'opt', 'for': 'coffee'}
" Pack 'keremc/asyncomplete-racer.vim', {'type': 'opt', 'for': 'rust', 'if': !executable('rls')}
" Pack 'kristijanhusak/vim-hybrid-material', {'type': 'opt'}
" Pack 'kylef/apiblueprint.vim', {'type': 'opt', 'for': 'apiblueprint'}
" Pack 'lambdalisue/fila.vim', {'type': 'opt', 'on': 'Fila'}
" Pack 'leafgarland/typescript-vim', {'type': 'opt', 'for': ['typescript', 'typescript.tsx']}
" Pack 'mattn/favstar-vim', {'type': 'opt'}
" Pack 'mattn/gist-vim', {'type': 'opt', 'on': 'Gist'}
" Pack 'mattn/qiita-vim', {'type': 'opt', 'on': 'Qiita'}
" Pack 'nelstrom/vim-markdown-folding', {'type': 'opt', 'for': 'markdown'}
" Pack 'neovimhaskell/haskell-vim', {'type': 'opt', 'for': ['haskell', 'cabal']}
" Pack 'othree/es.next.syntax.vim', {'type': 'opt', 'for': ['javascript', 'javascript.jsx']}
" Pack 'othree/javascript-libraries-syntax.vim', {'type': 'opt', 'for': ['javascript', 'javascript.jsx']}
" Pack 'pangloss/vim-javascript', {'type': 'opt', 'for': ['javascript', 'javascript.jsx']}
" Pack 'posva/vim-vue', {'type': 'opt', 'for': 'vue'}
" Pack 'prabirshrestha/asyncomplete-necovim.vim', {'type': 'opt', 'for': 'vim'}
" Pack 'rhysd/vim-gfm-syntax', {'type': 'opt', 'for': 'markdown'}
" Pack 'rust-lang/rust.vim', {'type': 'opt', 'for': 'rust'}
" Pack 'stephpy/vim-yaml', {'type': 'opt', 'for': ['yml', 'yaml']}
Pack 'Shougo/junkfile.vim', {'type': 'opt', 'on': 'JunkfileOpen'}
Pack 'alx741/vim-hindent', {'type': 'opt', 'do': 'silent! !stack install hindent', 'if': executable('stack'), 'for': 'haskell'}
Pack 'b4b4r07/vim-sqlfmt', {'type': 'opt', 'do': 'silent! !go get github.com/jackc/sqlfmt', 'for': 'sql'}
Pack 'dhruvasagar/vim-table-mode', {'type': 'opt', 'for': 'markdown'}
Pack 'dzeban/vim-log-syntax', {'type': 'opt', 'for': 'log'}
Pack 'glidenote/memolist.vim', {'type': 'opt', 'on': ['MemoNew', 'MemoList', 'MemoGrep']}
Pack 'kana/vim-altr', {'type': 'opt', 'on': ['<Plug>(altr-forward)', '<Plug>(altr-back)']}
Pack 'iamcco/markdown-preview.nvim', {'type': 'opt', 'for': 'markdown', 'on': 'MarkdownPreview', 'do': function('Markdown_preview_do')}
Pack 'itchyny/vim-haskell-indent', {'type': 'opt', 'for': 'haskell'}
Pack 'itchyny/vim-haskell-sort-import', {'type': 'opt', 'for': 'haskell'}
Pack 'junegunn/vim-easy-align', {'type': 'opt', 'on': '<Plug>(EasyAlign)'}
Pack 'lambdalisue/gina.vim', {'type': 'opt', 'on': 'Gina'}
Pack 'lifepillar/vim-solarized8', {'type': 'opt'}
Pack 'liuchengxu/vim-clap', {'type': 'opt', 'on': 'Clap'}
Pack 'majutsushi/tagbar', {'type': 'opt', 'on': 'TagbarToggle'}
Pack 'mattn/sonictemplate-vim', {'type': 'opt', 'on': 'Template'}
Pack 'mbbill/undotree', {'type': 'opt', 'on': 'UndotreeToggle'}
Pack 'mechatroner/rainbow_csv', {'type': 'opt', 'for': 'csv'}
Pack 'mhinz/vim-grepper', {'type': 'opt', 'on': ['Grepper', '<Plug>(GrepperOperator)']}
Pack 'morhetz/gruvbox', {'type': 'opt'}
Pack 'qpkorr/vim-renamer', {'type': 'opt', 'on': 'Renamer'}
Pack 'rbtnn/vim-coloredit', {'type': 'opt', 'on': 'ColorEdit'}
Pack 'rhysd/git-messenger.vim', {'type': 'opt', 'on': 'GitMessenger'}
Pack 'rhysd/reply.vim', {'type': 'opt', 'on': 'Repl'}
Pack 'rhysd/rust-doc.vim', {'type': 'opt', 'if': executable('cargo'), 'for': 'rust'}
Pack 'rhysd/vim-color-spring-night', {'type': 'opt'}
Pack 'rhysd/vim-healthcheck', {'type': 'opt', 'on': 'CheckHealth'}
Pack 'scrooloose/nerdtree', {'type': 'opt', 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Pack 'scrooloose/vim-slumlord', {'type': 'opt', 'for': 'plantuml'}
Pack 'skanehira/translate.vim', {'type': 'opt', 'on': ['AutoTranslateModeToggle', '<Plug>(VTranslate)', '<Plug>(VTranslateBang)'], 'if': executable('gtran') && !has('nvim')}
Pack 't9md/vim-choosewin', {'type': 'opt', 'on': ['<Plug>(choosewin)']}
Pack 'thinca/vim-qfreplace', {'type': 'opt', 'for': ['quickfix', 'qf']}
Pack 'twitvim/twitvim', {'type': 'opt', 'on': ['PosttoTwitter', 'CPosttoTwitter', 'BPosttoTwitter', 'FriendsTwitter', 'UserTwitter', 'MentionsTwitter', 'PublicTwitter', 'DMTwitter', 'SearchTwitter']}
Pack 'tyru/capture.vim', {'type': 'opt', 'on': 'Capture'}
Pack 'tyru/caw.vim', {'type': 'opt', 'on': ['<Plug>(caw:prefix)', '<Plug>(caw:prefix)', '<Plug>(caw:hatpos:toggle)', '<Plug>(caw:hatpos:toggle)']}
