command! -range=% JT call denops#request('jsontoml', 'jsonTOML', [<line1>, <line2>])
command! -range=% TJ call denops#request('jsontoml', 'tomlJSON', [<line1>, <line2>])
