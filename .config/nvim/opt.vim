Pac 'k-takata/minpac', {'type': 'opt'}

function! Markdown_preview_do(hooktype, name) abort
  echom a:hooktype
  packadd markdown-preview.nvim
  call mkdp#util#install()
endfunction

" Pac 'NLKNguyen/papercolor-theme', {'type': 'opt'}
" Pac 'OmniSharp/Omnisharp-vim', {'type': 'opt', 'ft': 'cs'}
" Pac 'Shougo/defx.nvim', {'type': 'opt', 'on': 'Defx', 'do': 'silent! UpdateRemotePlugins', 'if': !g:is_windows}
" Pac 'Shougo/denite.nvim', {'type': 'opt', 'on': 'Denite', 'do': 'silent! UpdateRemotePlugins', 'if': has('python3')}
" Pac 'Shougo/neco-vim', {'type': 'opt', 'ft': 'vim'}
" Pac 'Vimjas/vim-python-pep8-indent', {'type': 'opt', 'ft': 'python'}
" Pac 'aklt/plantuml-syntax', {'type': 'opt', 'ft': 'plantuml'}
" Pac 'basyura/TweetVim', {'type': 'opt', 'on': ['TweetVimHomeTimeline', 'TweetVimUserStream','TweetVimSay']}
" Pac 'basyura/bitly.vim', {'type': 'opt'}
" Pac 'basyura/twibill.vim', {'type': 'opt'}
" Pac 'cespare/vim-toml', {'type': 'opt', 'ft': 'toml'}
" Pac 'cocopon/iceberg.vim', {'type': 'opt'}
" Pac 'dag/vim-fish', {'type': 'opt', 'ft': 'fish'}
" Pac 'davidhalter/jedi-vim', {'type': 'opt', 'ft': ['python']}
" Pac 'eagletmt/ghcmod-vim', {'type': 'opt', 'do': 'silent! !stack install ghc-mod', 'if': executable('stack'), 'ft': 'haskell'}
" Pac 'eagletmt/neco-ghc', {'type': 'opt', 'ft': 'haskell'}
" Pac 'ekalinin/Dockerfile.vim', {'type': 'opt', 'ft': 'dockerfile'}
" Pac 'fatih/vim-go', {'type': 'opt', 'ft': 'go'}
" Pac 'joshdick/onedark.vim', {'type': 'opt'}
" Pac 'jremmen/vim-ripgrep', {'type': 'opt', 'on': 'Rg'}
" Pac 'kannokanno/previm', {'type': 'opt', 'ft': 'markdown'}
" Pac 'kchmck/vim-coffee-script', {'type': 'opt', 'ft': 'coffee'}
" Pac 'keremc/asyncomplete-racer.vim', {'type': 'opt', 'ft': 'rust', 'if': !executable('rls')}
" Pac 'kristijanhusak/vim-hybrid-material', {'type': 'opt'}
" Pac 'kylef/apiblueprint.vim', {'type': 'opt', 'ft': 'apiblueprint'}
" Pac 'lambdalisue/fila.vim', {'type': 'opt', 'on': 'Fila'}
" Pac 'leafgarland/typescript-vim', {'type': 'opt', 'ft': ['typescript', 'typescript.tsx']}
" Pac 'lifepillar/vim-solarized8', {'type': 'opt'}
" Pac 'mattn/favstar-vim', {'type': 'opt'}
" Pac 'mattn/gist-vim', {'type': 'opt', 'on': 'Gist'}
" Pac 'mattn/qiita-vim', {'type': 'opt', 'on': 'Qiita'}
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
" Pac 'stephpy/vim-yaml', {'type': 'opt', 'ft': ['yml', 'yaml']}
Pac 'PProvost/vim-ps1', {'type': 'opt', 'ft': 'ps1'}
Pac 'Shougo/junkfile.vim', {'type': 'opt', 'on': 'JunkfileOpen'}
Pac 'airblade/vim-rooter', {'type': 'opt', 'on': 'Rooter'}
Pac 'alx741/vim-hindent', {'type': 'opt', 'do': 'silent! !stack install hindent', 'if': executable('stack'), 'ft': 'haskell'}
Pac 'b4b4r07/vim-sqlfmt', {'type': 'opt', 'do': 'silent! !go get github.com/jackc/sqlfmt', 'ft': 'sql'}
Pac 'dhruvasagar/vim-table-mode', {'type': 'opt', 'ft': 'markdown'}
Pac 'dzeban/vim-log-syntax', {'type': 'opt', 'ft': 'log'}
Pac 'glidenote/memolist.vim', {'type': 'opt', 'on': ['MemoNew', 'MemoList', 'MemoGrep']}
Pac 'iamcco/markdown-preview.nvim', {'type': 'opt', 'ft': 'markdown', 'on': 'MarkdownPreview', 'do': function('Markdown_preview_do')}
Pac 'itchyny/vim-haskell-indent', {'type': 'opt', 'ft': 'haskell'}
Pac 'itchyny/vim-haskell-sort-import', {'type': 'opt', 'ft': 'haskell'}
Pac 'junegunn/vim-easy-align', {'type': 'opt', 'on': '<Plug>(EasyAlign)'}
Pac 'lambdalisue/gina.vim', {'type': 'opt', 'on': 'Gina'}
Pac 'liuchengxu/vim-clap', {'type': 'opt', 'on': 'Clap'}
Pac 'majutsushi/tagbar', {'type': 'opt', 'on': 'TagbarToggle'}
Pac 'mattn/sonictemplate-vim', {'type': 'opt', 'on': 'Template'}
Pac 'mbbill/undotree', {'type': 'opt', 'on': 'UndotreeToggle'}
Pac 'mechatroner/rainbow_csv', {'type': 'opt', 'ft': 'csv'}
Pac 'mhinz/vim-grepper', {'type': 'opt', 'on': ['Grepper', '<Plug>(GrepperOperator)']}
Pac 'qpkorr/vim-renamer', {'type': 'opt', 'on': 'Renamer'}
Pac 'rbtnn/vim-coloredit', {'type': 'opt', 'on': 'ColorEdit'}
Pac 'rhysd/git-messenger.vim', {'type': 'opt', 'on': 'GitMessenger'}
Pac 'rhysd/reply.vim', {'type': 'opt', 'on': 'Repl'}
Pac 'rhysd/rust-doc.vim', {'type': 'opt', 'if': executable('cargo'), 'ft': 'rust'}
Pac 'rhysd/vim-color-spring-night', {'type': 'opt'}
Pac 'rhysd/vim-healthcheck', {'type': 'opt', 'on': 'CheckHealth'}
Pac 'scrooloose/nerdtree', {'type': 'opt', 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Pac 'scrooloose/vim-slumlord', {'type': 'opt', 'ft': 'plantuml'}
Pac 'skanehira/translate.vim', {'type': 'opt', 'on': ['AutoTranslateModeToggle', '<Plug>(VTranslate)', '<Plug>(VTranslateBang)'], 'if': executable('gtran') && !has('nvim')}
Pac 'thinca/vim-qfreplace', {'type': 'opt', 'ft': ['quickfix', 'qf']}
Pac 'twitvim/twitvim', {'type': 'opt', 'on': ['PosttoTwitter', 'CPosttoTwitter', 'BPosttoTwitter', 'FriendsTwitter', 'UserTwitter', 'MentionsTwitter', 'PublicTwitter', 'DMTwitter', 'SearchTwitter']}
Pac 'tyru/capture.vim', {'type': 'opt', 'on': 'Capture'}
Pac 'tyru/caw.vim', {'type': 'opt', 'on': ['<Plug>(caw:prefix)', '<Plug>(caw:prefix)', '<Plug>(caw:hatpos:toggle)', '<Plug>(caw:hatpos:toggle)']}
