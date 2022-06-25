let g:autodate_debug = v:false
let g:autodate_config = {
      \ "xml": {
      \   "replace": [
      \     ['/^(.*key="version">)[^<]*(<.*)/i', '$1${format(now, "yyyyMMdd_HHmmss")}$2'],
      \     ['/^(.*key="%{task_file}%_version">)[^<]*(<.*)/i', '$1${format(now, "yyyyMMdd_HHmmss")}$2'],
      \     ['/^(.*key="autobot_version">)[^<]*(<.*)/i', '$1${format(now, "yyyyMMdd_HHmmss")}$2']
      \   ],
      \   "event": "BufWritePre",
      \   "pat": ["*.xml", "*.xaml"],
      \   "head": 30,
      \   "tail": 5,
      \ },
      \ "ps1": {
      \   "replace": [
      \     ['/^(.*"version", ")[0-9_]+(".*)/i', '$1${format(now, "yyyyMMdd_HHmmss")}$2'],
      \   ],
      \   "event": "BufWritePre",
      \   "pat": ["*.ps1"],
      \   "head": 50,
      \   "tail": 5,
      \ },
      \ }
