if exists('g:outln_loaded')
    finish
endif

let g:outln_loaded = 1

command! -nargs=0 SayHello lua require('outln').say_hello()
