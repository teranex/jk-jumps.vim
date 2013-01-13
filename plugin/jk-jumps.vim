if exists('did_jk_jumps_vim') || &cp || version < 700
    finish
endif
let did_jk_jumps_vim = 1

if !exists('g:jk_jumps_minimum_lines')
    let g:jk_jumps_minimum_lines = 7
endif

function! JkJumps(key) range
    if v:count1 < g:jk_jumps_minimum_lines
        exec "normal! ".v:count1.a:key
    else
        let current = line('.')
        let target = current + ((a:key == 'k' ? -1 : 1) * v:count1)
        if a:key == 'k' && foldclosed(target) != -1
            " handle a movement up to a closed fold. This should jump to the 
            " beginning of the fold
            let target = foldclosed(target)
        endif
        echom 'target is: '.target
        exec "normal! ".target."G"
    endif
endfunction

nnoremap <silent> j :<C-U>call JkJumps('j')<CR>
nnoremap <silent> k :<C-U>call JkJumps('k')<CR>
