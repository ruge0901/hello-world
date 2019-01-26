set number          " show line number
set cursorline      " highlight cursor line
set tabstop=4 expandtab shiftwidth=4 smarttab
set autoindent cindent
syntax on
colo desert         " colourscheme.
set nowrap
autocmd GUIEnter * simalt ~x " start fullscreen in windows.
" map <C-C> "+y       " simulates Ctrl-C
" map <C-V> "+p       " simulates Ctrl-V
set clipboard=unnamed         " use Windows Clipboard for 'yanking' (simpler data exchange with windows clipboard

" TEST BEGIN 
" Plug 'https://github.com/kana/vim-textobj-function' 
" set runtimepath^=~/Vim/plugged/vim-textobj-user/autoload/textobj/user.vim

" Plug 'https://github.com/kana/vim-textobj-user'
" set runtimepath^=~/Vim/plugged/vim-textobj-function/plugin/textobj/function.vim
" TEST END

" -- Plugin-Manager: 'Vim-Plug' manager setup --
if has('win32') || has('win64')
let &shell='cmd.exe'
endif
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/Vim/plugged')
" Register plugins
Plug 'https://github.com/kana/vim-textobj-user'
Plug 'https://github.com/kana/vim-textobj-function'
Plug 'https://github.com/itchyny/lightline.vim'
Plug 'https://github.com/machakann/vim-highlightedyank'
" Initialize plugin system
call plug#end()

" Setup Plugin: Lightline
set laststatus=2 " auto-start plugin
set noshowmode   " plugin lightline: disable vim-default status at bottom --- INSERT ---  

" Setup Plugin: Higlightedyank 
if !exists('##TextYankPost')     " mandatory for vim
  map y <Plug>(highlightedyank)
endif
highlight HighlightedyankRegion cterm=reverse gui=reverse   " improve higlight visibility
let g:highlightedyank_highlight_duration = 300             " highlight time in 'ms'

" Windows
nnoremap <C-h> <C-w>h " Navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" resize horzontal split window
nmap <C-Left>  <C-W><<C-W><10
nmap <C-Right> <C-W>><C-W>>10
" resize vertical split window
nmap <C-Up>    <C-W>-<C-W>-10
nmap <C-Down>  <C-W>+<C-W>+10

:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
