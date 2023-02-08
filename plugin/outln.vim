if exists('g:outln_loaded')
    finish
endif

let g:outln_loaded = 1

command! -nargs=0 Outln lua require('outln').open_outln()
