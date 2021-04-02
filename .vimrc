"     __                      __           __           
"    / /_  ____ _____ _____ _/ /___ ______/ /____  _____
"   / __ \/ __ `/ __ `/ __ `/ / __ `/ ___/ __/ _ \/ ___/
"  / /_/ / /_/ / /_/ / /_/ / / /_/ (__  ) /_/  __/ /    
" /_.___/\__,_/\__, /\__,_/_/\__,_/____/\__/\___/_/     
"           _ /____/                                    
"    _   __(_)___ ___  __________                       
"   | | / / / __ `__ \/ ___/ ___/                       
"  _| |/ / / / / / / / /  / /__                         
" (_)___/_/_/ /_/ /_/_/   \___/                         
"                                 

" Basic settings ------------------ {{{

" Set leaders
let mapleader=" "
let maplocalleader=","

" Line numbers
set relativenumber

" No line wrapping
set nowrap

" Set tabwidth
set tabstop=4
set shiftwidth=4
set expandtab

" }}}

" Navigation ----------------- {{{

" Open this file
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Move between windows
nnoremap <leader><c-j> <c-w>j
nnoremap <leader><c-k> <c-w>k
nnoremap <leader><c-h> <c-w>h
nnoremap <leader><c-l> <c-w>l

" Better escape
inoremap jk <esc>
inoremap <esc> <nop>
vnoremap jk <esc>
vnoremap <esc> <nop>

" }}}

" Misc. Editing ----------------- {{{

" Move lines up/down
nnoremap <c-k> kddpk
nnoremap <c-j> ddp
vnoremap <c-k> :m '<-2<cr>gv=gv
vnoremap <c-j> :m '>+1<cr>gv=gv

" Delete lines in insert mode
inoremap <c-d> <esc>ddi

" Add lines without going into insert mode
nnoremap <leader><cr> o<esc>

" Uppercase in other modes
nnoremap <c-u> viwU<esc>
inoremap <c-u> <esc>viwUi

" Begin/end line 
nnoremap H ^
nnoremap L $

" }}}

" Quotation and bracket behavior ------------- {{{

" Quotations ----------- {{{
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
vnoremap <leader>" <esc>`<i"<esc>`>la"<esc>
vnoremap <leader>' <esc>`<i'<esc>`>la'<esc>
iabbrev ' ''<left>
iabbrev " ""<left>
" }}}

" Parenthesis ---------- {{{
nnoremap <leader>( viw<esc>a)<esc>bi(<esc>lel
nnoremap <leader>) viw<esc>a)<esc>bi(<esc>lel
vnoremap <leader>( <esc>`<i(<esc>`>la)<esc>
vnoremap <leader>) <esc>`<i(<esc>`>la)<esc>
inoreabbrev ( ()<left>
" }}}

" Brackets ---------- {{{
nnoremap <leader>[ viw<esc>a]<esc>bi[<esc>lel
nnoremap <leader>] viw<esc>a]<esc>bi[<esc>lel
vnoremap <leader>[ <esc>`<i[<esc>`>la]<esc>
vnoremap <leader>] <esc>`<i[<esc>`>la]<esc>
inoreabbrev [ []<left>
" }}}

" }}}

" Pending operator mappings -------------------{{{

" Select contents of parenthesis -------- {{{
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F(vi(<cr>
onoremap an( :<c-u>normal! f(va(<cr>
onoremap al( :<c-u>normal! F(va(<cr>
" }}}

" Select contents of curly braces -------- {{{
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F{vi{<cr>
onoremap an{ :<c-u>normal! f{va{<cr>
onoremap al{ :<c-u>normal! F{va{<cr>
" }}}

" }}}

" Auto-commands --------------------------- {{{

" Vimscript file settings ------------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldlevelstart=0
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Javascript file settings ------------------------ {{{
augroup filetype_javascript
	autocmd!
	" Commenting
	autocmd FileType javascript nnoremap <buffer> <localleader>c I// <esc>
	" If statements
	autocmd FileType javascript inoreabbrev <buffer> iff if ()<left>
	" For statements
	autocmd FileType javascript inoreabbrev <buffer> forr for ()<left>
augroup END
" }}}

" Python file settings ---------------------------- {{{
augroup filetype_python
	autocmd!
	" Commenting
	autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>
	" If statements
	autocmd FileType python inoreabbrev <buffer> iff if :<left>
	" For statements
	autocmd FileType python inoreabbrev <buffer> forr for :<left>
augroup END
" }}}

" }}}

" Powerline for Vim ---------------------- {{{
set rtp+=$VIM_POWERLINE_DIR
set laststatus=2
set t_Co=256
" }}}
