syntax on           " turn syntax highlightning on
set number          " show line number
set cursorline      " highlight cursor line
set tabstop=4 expandtab shiftwidth=4 smarttab
set autoindent cindent
colo desert         " colourscheme.
set nowrap
autocmd GUIEnter * simalt ~x " start fullscreen in windows.
set nowrap          " switch off wrapping

" --- Clipboard ---
set clipboard=unnamed 	" use Windows Clipboard for 'yank', 'delete'...
" noremap <Leader>p "*p   " paste from Windows Clipboard

" --- Sessions ---
set wildmenu        " for convenient session handling
set wildmode=full
" let g:sessions_dir = '~\vimfiles\session'
" exec 'nnoremap <Leader>ss :mks! ' . g:session_dir . '\*.vim<C-D><BS><BS><BS><BS><BS>'
" exec 'nnoremap <Leader>sr :so ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

" --- Search highlighting ---
set hlsearch        " higlight search result (reset via: noh)
set incsearch       " incremental immediate highligtning
map <esc> :noh<cr>  " exit via ESC


set cursorline      " highlight cursor line
" Active Window visibility
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" enforce usage of ext. grep
" set grepprg=grep\ " --nogroup\ --nocolor
" cd D:\PROJECTS\External\MQB19\MQB19SVN\SW\mc_sw\appl

" ###  Plugin-Manager 'Vim-Plug' (':PlugInstall')
if has('win32') || has('win64')
let &shell='cmd.exe'
endif
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/plugged')
" Plugin e.g:
" eg1: " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" eg2: Plug 'junegunn/vim-easy-align'
" Additonal Text-Object:
Plug 'https://github.com/kana/vim-textobj-user'       " 'user' is basis for text-objects below   
Plug 'https://github.com/kana/vim-textobj-function'   "  if / af - function 
Plug 'https://github.com/sgur/vim-textobj-parameter'    "  i, a, - function parameter
Plug 'https://github.com/vim-scripts/argtextobj.vim'    "  ia aa - function argument
Plug 'https://github.com/itchyny/lightline.vim'
Plug 'https://github.com/machakann/vim-highlightedyank'
" Initialize plugin system
call plug#end()

" -- Setup Plugin: Lightline
set laststatus=2 " auto-start plugin
set noshowmode   " plugin lightline: disable vim-default status at bottom --- INSERT ---  

" -- Setup Plugin: Higlightedyank 
if !exists('##TextYankPost')     " mandatory for vim
  map y <Plug>(highlightedyank)
endif
highlight HighlightedyankRegion cterm=reverse gui=reverse   " improve higlight visibility
let g:highlightedyank_highlight_duration = 300             " highlight time in 'ms'

" ### Windows
nnoremap <C-h> <C-w>h " Navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set winheight=5                 " Min Width and height
set winminwidth=10

nmap <C-Left>  <C-W><<C-W><10   " resize horizontal split window
nmap <C-Right> <C-W>><C-W>>10   
nmap <C-Up>    <C-W>-<C-W>-10   " resize vertical split window
nmap <C-Down>  <C-W>+<C-W>+10

" ### Menus (gvim)
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar

nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>


" ### Move lines 
" Normal, Insert: <n>Alt-up / <n>Alt-down  default=1, number of lines (optional)
" Visual,:           Alt-up /    Alt-down
function! MoveLines(offset) range
    let l:col = virtcol('.')
    let l:offset = str2nr(a:offset)
    exe 'silent! :' . a:firstline . ',' . a:lastline . 'm'
        \ . (l:offset > 0 ? a:lastline + l:offset : a:firstline + l:offset)
    exe 'normal ' . l:col . '|'
endf

imap <silent> <M-up> <C-O>:call MoveLines('-2')<CR>
imap <silent> <M-down> <C-O>:call MoveLines('+1')<CR>
nmap <silent> <M-up> :call MoveLines('-2')<CR>
nmap <silent> <M-down> :call MoveLines('+1')<CR>
vmap <silent> <M-up> :call MoveLines('-2')<CR>gv
vmap <silent> <M-down> :call MoveLines('+1')<CR>gv


" ====================================
"           HELP
" ====================================
" Replace all occurences of selected word in file : 
"    Select with: *
"    :%s//<new word>/g
"
" Change $HOME: specify env. variable in windows
"    HOME Z:\Admin\Vim
" Change Font (on Windows)
" set guifont=*   // will show availble fonts on system
" set guifont=Monaco\ 14
" set guifont=Arial monospaced for SAP\ 10
" ====================================
" Sessions:
" so   ~/sessions/std.vim
" mks! ~/sessions/std.vim
" ====================================
" Remote access to Synology
" scp://admin@192.168.178.20//var/services/homes/admin/.viminfo

