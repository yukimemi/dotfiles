let g:random_disabled = 0

if has('nvim')
  let g:available_colorschemes = ['iceberg', 'palenight', 'tokyonight', 'onedark', 'quantum', 'spring-night', 'gruvbox-material', 'dracula', 'vadelma', 'hydrangea', 'zephyr', 'oceanicnext', 'edge', 'tokyodark', 'nvcode', 'neon', 'pinkmare', 'srcery', 'material', 'falcon', 'hybrid']
else
  let g:available_colorschemes = ['iceberg', 'palenight', 'onedark', 'quantum', 'spring-night', 'dracula', 'vadelma', 'hydrangea', 'oceanicnext', 'edge', 'nvcode', 'pinkmare', 'srcery', 'falcon']
endif
