command! -range=% JY call denops#request('jsonyaml', 'jsonYAML', [<line1>, <line2>])
command! -range=% YJ call denops#request('jsonyaml', 'yamlJSON', [<line1>, <line2>])
