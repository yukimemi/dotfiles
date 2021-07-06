" Use around source.
call ddc#custom#global({
      \ 'sources': { '_': ['around'] },
      \ 'auto_complete_delay': 200,
      \ 'smart_case': v:true,
      \ })

" Enable default matcher.
call ddc#custom#source('_', 'matchers', ['matcher_head'])

" Use ddc.
call ddc#enable()
