function! Markdown_preview_do(hooktype, name) abort
  echom a:hooktype
  packadd markdown-preview.nvim
  call mkdp#util#install()
endfunction

" Pac 'NLKNguyen/papercolor-theme', {'type': 'opt'}
" Pac 'OmniSharp/Omnisharp-vim', {'type': 'opt', 'ft': 'cs'}
" Pac 'Shougo/defx.nvim', {'type': 'opt', 'cmd': 'Defx', 'do': 'silent! UpdateRemotePlugins', 'if': !g:is_windows}
" Pac 'Shougo/denite.nvim', {'type': 'opt', 'cmd': 'Denite', 'do': 'silent! UpdateRemotePlugins', 'if': has('python3')}
" Pac 'Shougo/neco-vim', {'type': 'opt', 'ft': 'vim'}
" Pac 'Vimjas/vim-python-pep8-indent', {'type': 'opt', 'ft': 'python'}
" Pac 'aklt/plantuml-syntax', {'type': 'opt', 'ft': 'plantuml'}
" Pac 'basyura/TweetVim', {'type': 'opt', 'cmd': ['TweetVimHomeTimeline', 'TweetVimUserStream','TweetVimSay']}
" Pac 'basyura/bitly.vim', {'type': 'opt'}
" Pac 'basyura/twibill.vim', {'type': 'opt'}
" Pac 'cespare/vim-toml', {'type': 'opt', 'ft': 'toml'}
" Pac 'cocopon/iceberg.vim', {'type': 'opt'}
" Pac 'cohama/agit.vim', {'type': 'opt', 'cmd': 'Agit*'}
" Pac 'dag/vim-fish', {'type': 'opt', 'ft': 'fish'}
" Pac 'davidhalter/jedi-vim', {'type': 'opt', 'ft': ['python']}
" Pac 'eagletmt/ghcmod-vim', {'type': 'opt', 'do': 'silent! !stack install ghc-mod', 'if': executable('stack'), 'ft': 'haskell'}
" Pac 'eagletmt/neco-ghc', {'type': 'opt', 'ft': 'haskell'}
" Pac 'ekalinin/Dockerfile.vim', {'type': 'opt', 'ft': 'dockerfile'}
" Pac 'fatih/vim-go', {'type': 'opt', 'ft': 'go'}
" Pac 'joshdick/onedark.vim', {'type': 'opt'}
" Pac 'jremmen/vim-ripgrep', {'type': 'opt', 'cmd': 'Rg'}
" Pac 'justinmk/vim-dirvish', {'type': 'opt', 'cmd': 'Dirvish*'}
" Pac 'kannokanno/previm', {'type': 'opt', 'ft': 'markdown'}
" Pac 'kchmck/vim-coffee-script', {'type': 'opt', 'ft': 'coffee'}
" Pac 'keremc/asyncomplete-racer.vim', {'type': 'opt', 'ft': 'rust', 'if': !executable('rls')}
" Pac 'kristijanhusak/vim-hybrid-material', {'type': 'opt'}
" Pac 'kylef/apiblueprint.vim', {'type': 'opt', 'ft': 'apiblueprint'}
" Pac 'lambdalisue/fila.vim', {'type': 'opt', 'cmd': 'Fila'}
" Pac 'leafgarland/typescript-vim', {'type': 'opt', 'ft': ['typescript', 'typescript.tsx']}
" Pac 'lifepillar/vim-solarized8', {'type': 'opt'}
" Pac 'mattn/favstar-vim', {'type': 'opt'}
" Pac 'mattn/gist-vim', {'type': 'opt', 'cmd': 'Gist'}
" Pac 'mattn/qiita-vim', {'type': 'opt', 'cmd': 'Qiita'}
" Pac 'morhetz/gruvbox', {'type': 'opt'}
" Pac 'nelstrom/vim-markdown-folding', {'type': 'opt', 'ft': 'markdown'}
" Pac 'neovimhaskell/haskell-vim', {'type': 'opt', 'ft': ['haskell', 'cabal']}
" Pac 'othree/es.next.syntax.vim', {'type': 'opt', 'ft': ['javascript', 'javascript.jsx']}
" Pac 'othree/javascript-libraries-syntax.vim', {'type': 'opt', 'ft': ['javascript', 'javascript.jsx']}
" Pac 'pangloss/vim-javascript', {'type': 'opt', 'ft': ['javascript', 'javascript.jsx']}
" Pac 'posva/vim-vue', {'type': 'opt', 'ft': 'vue'}
" Pac 'prabirshrestha/asyncomplete-necovim.vim', {'type': 'opt', 'ft': 'vim'}
" Pac 'rhysd/vim-gfm-syntax', {'type': 'opt', 'ft': 'markdown'}
" Pac 'rust-lang/rust.vim', {'type': 'opt', 'ft': 'rust'}
" Pac 'simnalamburt/vim-mundo', {'type': 'opt', 'cmd': 'MundoToggle*'}
" Pac 'stephpy/vim-yaml', {'type': 'opt', 'ft': ['yml', 'yaml']}
" Pac 'y0za/vim-reading-vimrc', {'type': 'opt', 'cmd': 'ReadingVimrc*'}
Pac 'PProvost/vim-ps1', {'type': 'opt', 'ft': 'ps1'}
Pac 'Shougo/junkfile.vim', {'type': 'opt', 'cmd': 'JunkfileOpen'}
Pac 'airblade/vim-rooter', {'type': 'opt', 'cmd': 'Rooter'}
Pac 'alx741/vim-hindent', {'type': 'opt', 'do': 'silent! !stack install hindent', 'if': executable('stack'), 'ft': 'haskell'}
Pac 'b4b4r07/vim-sqlfmt', {'type': 'opt', 'do': 'silent! !go get github.com/jackc/sqlfmt', 'ft': 'sql'}
Pac 'dhruvasagar/vim-table-mode', {'type': 'opt', 'ft': 'markdown'}
Pac 'dzeban/vim-log-syntax', {'type': 'opt', 'ft': 'log'}
Pac 'glidenote/memolist.vim', {'type': 'opt', 'cmd': 'Memo*'}
Pac 'iamcco/markdown-preview.nvim', {'type': 'opt', 'ft': 'markdown', 'cmd': 'MarkdownPreview', 'do': function('Markdown_preview_do')}
Pac 'itchyny/vim-haskell-indent', {'type': 'opt', 'ft': 'haskell'}
Pac 'itchyny/vim-haskell-sort-import', {'type': 'opt', 'ft': 'haskell'}
Pac 'liuchengxu/vim-clap', {'type': 'opt', 'cmd': 'Clap'}
Pac 'majutsushi/tagbar', {'type': 'opt', 'cmd': 'Tagbar*'}
Pac 'mattn/sonictemplate-vim', {'type': 'opt', 'cmd': 'Template*'}
Pac 'mbbill/undotree', {'type': 'opt', 'cmd': 'UndotreeToggle'}
Pac 'mechatroner/rainbow_csv', {'type': 'opt', 'ft': 'csv'}
Pac 'qpkorr/vim-renamer', {'type': 'opt', 'cmd': 'Renamer*'}
Pac 'rbtnn/vim-coloredit', {'type': 'opt', 'cmd': 'ColorEdit'}
Pac 'rhysd/git-messenger.vim', {'type': 'opt', 'cmd': 'GitMessenger'}
Pac 'rhysd/reply.vim', {'type': 'opt', 'cmd': 'Repl*'}
Pac 'rhysd/rust-doc.vim', {'type': 'opt', 'if': executable('cargo'), 'ft': 'rust'}
Pac 'rhysd/vim-color-spring-night', {'type': 'opt'}
Pac 'rhysd/vim-healthcheck', {'type': 'opt', 'cmd': 'CheckHealth'}
Pac 'scrooloose/nerdtree', {'type': 'opt', 'cmd': ['NERDTreeToggle', 'NERDTreeFind']}
Pac 'scrooloose/vim-slumlord', {'type': 'opt', 'ft': 'plantuml'}
Pac 'thinca/vim-qfreplace', {'type': 'opt', 'ft': ['quickfix', 'qf']}
Pac 'twitvim/twitvim', {'type': 'opt', 'cmd': '*Twitter'}
Pac 'tyru/capture.vim', {'type': 'opt', 'cmd': 'Capture'}
