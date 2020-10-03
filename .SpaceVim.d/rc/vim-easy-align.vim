vmap <Enter> <Plug>(EasyAlign)

let g:easy_align_delimiters = {
      \ '>': {
      \       'pattern': '>>\|=>\|>.\+',
      \       'right_margin': 0,
      \       'delimiter_align': 'l'
      \   },
      \ '/': {
      \       'pattern': '//\+\|/\*\|\*/',
      \       'delimiter_align': 'l',
      \       'ignore_groups': ['!Comment']
      \   },
      \ '.': {
      \       'pattern': '/',
      \       'left_margin': 1,
      \       'right_margin': 1,
      \       'stick_to_left': 0,
      \       'ignore_groups': []
      \   },
      \ ']': {
      \       'pattern': '[[\]]',
      \       'left_margin': 0,
      \       'right_margin': 0,
      \       'stick_to_left': 0
      \   },
      \ ')': {
      \       'pattern': '[()]',
      \       'left_margin': 0,
      \       'right_margin': 0,
      \       'stick_to_left': 0
      \   },
      \ 'd': {
      \       'pattern': ' \(\S\+\s*[;=]\)\@=',
      \       'left_margin': 0,
      \       'right_margin': 0
      \   },
      \ 'p': {
      \       'pattern': 'pos=\|size=',
      \       'right_margin': 0
      \   },
      \ 's': {
      \       'pattern': 'sys=\|Trns=',
      \       'right_margin': 0
      \   },
      \ 'k': {
      \       'pattern': 'key=\|cmt=',
      \       'right_margin': 0
      \   },
      \ 'c': {
      \       'pattern': 'cmt=',
      \       'right_margin': 0
      \   },
      \ ':': {
      \       'pattern': ':',
      \       'left_margin': 0,
      \       'right_margin': 1,
      \       'stick_to_left': 0,
      \       'ignore_groups': []
      \   },
      \ 't': {
      \       'pattern': "\<tab>",
      \       'left_margin': 0,
      \       'right_margin': 0
      \   },
      \ ';': {
      \       'pattern': ';',
      \       'left_margin': 1,
      \       'right_margin': 1,
      \       'stick_to_left': 0,
      \       'ignore_groups': []
      \   }
      \ }

