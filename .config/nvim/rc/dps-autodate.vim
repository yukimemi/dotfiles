let g:autodate_debug = v:false
let g:autodate_config = {
\ "xml": {
\   "replace": [
\     ['/^(.*key="version">)[^<]*(<.*)/i', '$1${format(now, "yyyyMMdd_HHmmss")}$2']
\   ],
\   "event": "BufWritePre",
\   "pat": ["*.xml", "*.xaml"],
\   "head": 30,
\   "tail": 5,
\ }
\ }
