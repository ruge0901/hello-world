set guifont=Consolas:h11
set number          " show line number
set cursorline      " highlight cursor line
set tabstop=4 expandtab shiftwidth=4 smarttab
set autoindent cindent
colo desert         " colourscheme.
set nowrap
autocmd GUIEnter * simalt ~x " start fullscreen in windows.
set nowrap          " switch off wrapping
set ignorecase
set smartcase       " sensitive after >= 2 uppercase

" --- Clipboard ---
set clipboard=unnamed 	" use Windows Clipboard for 'yank', 'delete'...

" --- Sessions ---
set wildmenu        " for convenient session handling
set wildmode=full

" --- Search highlighting ---
set hlsearch        " higlight search result (reset via: noh)
set incsearch       " incremental immediate highligtning
map <esc> :noh<cr>  " exit via ESC

" Active Window visibility
set cursorline      " highlight cursor line
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" ### Backspace enable in insert mode ... smelly since not fully VIM like..but " simpler for now
set backspace=indent,eol,start

" ### Grep: Open quickfix window automatically after grep
augroup myvimrc
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END


" enforce usage of ext. grep
" set grepprg=grep\ " --nogroup\ --nocolor
" cd D:\PROJECTS\External\MQB19\MQB19SVN\SW\mc_sw\appl

" --------- ###  Plugin BEGIN --------------------------------
" ###  Plugin-Manager 'Vim-Plug' (':PlugInstall')
if has('win32') || has('win64')
let &shell='cmd.exe'
endif
" Plugin directory (Don't use standard vim dir. names like 'plugin')
call plug#begin('~/plugged')
" 1. Text-Objects:
Plug 'https://github.com/kana/vim-textobj-user'         " 'user' is base plugin for text-objects below   
Plug 'https://github.com/kana/vim-textobj-function'     "  if / af - function :
Plug 'https://github.com/sgur/vim-textobj-parameter'    "  i, a, - function parameter
Plug 'https://github.com/vim-scripts/argtextobj.vim'    "  ia aa - function argument
" 2. Others plugins:
Plug 'https://github.com/itchyny/lightline.vim'         " status bar
Plug 'https://github.com/machakann/vim-highlightedyank' " highlight yanked text
Plug 'https://github.com/tpope/vim-surround'            " surround text 
Plug 'https://github.com/tpope/vim-unimpaired'          " e.g for grep next/prev ]q [q 
Plug 'https://github.com/tpope/vim-repeat'              " repeat e.g. 'surround' changes 
Plug '~/fzf'                                            " Fuzzy find... NOT working yet !!
Plug 'https://github.com/tpope/fzf.vim'                
Plug 'https://github.com/craigemery/vim-autotag'        " NOT working yet
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown', 'on': 'MarkdownPreview' }
"
" Initialize plugin system
call plug#end()

" -- Setup Plugin: 'lightline'
set laststatus=2 " auto-start plugin
set noshowmode   " plugin lightline: disable vim-default status at bottom --- INSERT ---  
let g:lightline = {
      \ 'colorscheme': 'Tomorrow',
      \ }

" -- Setup Plugin: 'higlightedyank' 
if !exists('##TextYankPost')     " mandatory for vim
  map y <Plug>(highlightedyank)
endif
highlight HighlightedyankRegion cterm=reverse gui=reverse   " improve higlight visibility
let g:highlightedyank_highlight_duration = 200      " highlight time in 'ms'
"
" -- Setup Plugin: 'repeat' 
" List "repeatable" plugins (vor vim-repeat plugin)
silent! call repeat#set("\<Plug>vim-surround", v:count)
silent! call repeat#set("\<Plug>vim-unimpaired", v:count)
" --------- ###  Plugin END --------------------------------

" ### Windows
nnoremap <C-h> <C-w>h           " Window Navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set winheight=5                 " Window Min Width and height
set winminwidth=10

nmap <C-Left>  <C-W><<C-W><10   " resize horizontal split window
nmap <C-Right> <C-W>><C-W>>10   
nmap <C-Up>    <C-W>-<C-W>-10   " resize vertical split window
nmap <C-Down>  <C-W>+<C-W>+10

" ### gvim Menus
set guioptions-=m  "default: remove menu bar
set guioptions-=T  "default: remove toolbar
" toggle gvim menu support
nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>


" ### Move lines 
" Normal, Insert: <n>Alt-k/ <n>Alt-j default=1, number of lines (optional)
" Visual,:           Alt-k/    Alt-j 
function! MoveLines(offset) range
    let l:col = virtcol('.')
    let l:offset = str2nr(a:offset)
    exe 'silent! :' . a:firstline . ',' . a:lastline . 'm'
        \ . (l:offset > 0 ? a:lastline + l:offset : a:firstline + l:offset)
    exe 'normal ' . l:col . '|'
endf

imap <silent> <M-k> <C-O>:call MoveLines('-2')<CR>
imap <silent> <M-j> <C-O>:call MoveLines('+1')<CR>
nmap <silent> <M-k> :call MoveLines('-2')<CR>
nmap <silent> <M-j> :call MoveLines('+1')<CR>
vmap <silent> <M-k> :call MoveLines('-2')<CR>gv
vmap <silent> <M-j> :call MoveLines('+1')<CR>gv

" HardMode : disable arrow keys in Normal mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
"
" ctags: search for tags file in pwd
set tags=./tags,tags;
"    (see:   http://rc3.org/2013/01/05/vim-and-ctags/ )
"   Create tags for 'C' in pwd: ctags --languages=C -R .

" ====================================
"           HELP
" ====================================
" Replace:
" Replace all occurences of selected word (via '*') in file : 
"    :%s//<new word>/g
"
" Change $HOME: specify env. variable in windows
"    HOME Z:\Admin\Vim
"
" Change Font (on Windows):
" set guifont=*   // will show availble fonts on system
" set guifont=Monaco\ 14
" set guifont=Arial monospaced for SAP\ 10
"
" ====================================
" Session:
" so   ~/sessions/std.vim
" mks! ~/sessions/std.vim
"
" ====================================
" Remote Access To Synology:
" scp://admin@192.168.178.20//var/services/homes/admin/.viminfo
"
" ====================================
" Grep examples (for windows findstr):
" grep /s /i  DsDlStdInterface *.c    // search string in all subfolders
" Workflow:
" 1. :tabnew
" 2. :grep
" 3. :cn, :cp or :cN to navigate
