" Use around source.
call ddc#custom#global('sources', {
			\ '_': ['around'],
			\ })

" Pass a dictionary to set multiple options
call ddc#custom#global({
			\ 'auto_complete_delay': 200,
			\ 'smart_case': v:true,
			\ })

" Enable default matcher.
call ddc#custom#source('_', 'matchers', ['matcher_head'])

" Use ddc.
call ddc#enable()
