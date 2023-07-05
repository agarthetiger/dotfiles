syntax on

" Indenting for yaml files, from
" <https://stackoverflow.com/questions/26962999/wrong-indentation-when-editing-yaml-in-vim>
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Another attempt at yaml indenting, from
"<https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim>
filetype plugin indent on

" Show existing tab with 2 spaces width
set tabstop=2

" When indenting with '>', use 2 spaces width
set shiftwidth=2

" On pressing tab, insert 2 spaces
set expandtab

" Move the cursor to where the mouse clicks, if your terminal supports it
set mouse=a

:color desert

" Syntax colouring for yaml, from <https://www.vim.org/scripts/script.php?script_id=739>
au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim

" Code from:
" <http://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x>
" then <https://coderwall.com/p/if9mda>
" and then <https://github.com/aaronjensen/vimfiles/blob/59a7019b1f2d08c70c28a41ef4e2612470ea0549/plugin/terminaltweaks.vim>
" to fix the escape time problem with insert mode.
"
" Docs on bracketed paste mode:
" <http://www.xfree86.org/current/ctlseqs.html>
" Docs on mapping fast escape codes in vim
" <http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim>

if exists("g:loaded_bracketed_paste")
  finish
endif
let g:loaded_bracketed_paste = 1

let &t_ti .= "\<Esc>[?2004h"
let &t_te .= "\<Esc>[?2004l"

function! XTermPasteBegin(ret)
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction

execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"
map <expr> <f28> XTermPasteBegin("i")
imap <expr> <f28> XTermPasteBegin("")
vmap <expr> <f28> XTermPasteBegin("c")
cmap <f28> <nop>
cmap <f29> <nop>
" End bracketed paste mode code

" Save file opened as read-only. Shortcut requires you have sudo rights.
" From <https://superuser.com/questions/694450/using-vim-to-force-edit-a-file-when-you-opened-without-permissions>
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Syntax highlighting for markdown files
au BufRead,BufNewFile *.md set filetype=markdown

augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
