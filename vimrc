" ================== Vundle Start ==========================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
"
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
"
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
"
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
"
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
"
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
"

" >>>>> Plugins Start >>>>>>
" - BufExplorer
Bundle 'jlanzarotta/bufexplorer'
" - Ctrl-P
Bundle 'ctrlpvim/ctrlp.vim'
" - Ack
Bundle 'mileszs/ack.vim'
" - Ag
Bundle 'rking/ag.vim'
" - NerdTree
Bundle 'scrooloose/nerdtree'
" - Fugitive
Bundle 'tpope/vim-fugitive'
" - Unimpaired
Bundle 'tpope/vim-unimpaired'
" - Taglist
Bundle 'vim-scripts/taglist.vim'
" - vim-gitgutter
Bundle 'airblade/vim-gitgutter'
" - YouCompleteMe
"Plugin 'valloric/youcompleteme'
" --- Test Plugins
" Plugin 'godlygeek/csapprox'
Plugin 'tpope/vim-endwise'
Plugin 'henrik/vim-indexed-search'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-dispatch'
Plugin 'chriskempson/base16-vim'
"Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/ifdef-highlighting'

"Plugin 'm42e/trace32-practice.vim'
" >>>>> Plugins End   >>>>>>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" ================== Vundle End ==========================


" ================= Vim-Airline Start ===================
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='papercolor'
" ================= Vim-Airline End   ===================

" Line numbers
set number
set hlsearch
set ignorecase
set smartcase
set incsearch
set laststatus=2
set backspace=2
set relativenumber

"see whitespace
"set list

" ----------- HOTKEYS -------------
nmap <silent> <C-D> :NERDTreeToggle<CR>


" ----------- COMMANDS -------------
"command CSgen !cscope -bR -P $(pwd)

" ----------- CODE FORMATTING -------------
" - bcm 

" - linux
set listchars=tab:\|\ 
set cscopequickfix=s-,c-,d-,i-,t-,e-


" ----------- GUI OPTIONS -------------
"  guioptions no toolbar
set guioptions=aegirLt
set mousemodel=popup
set guifont=Inconsolata-g\ for\ Powerline\ Medium\ 14
set cursorline
syntax on

" ----------- CTRL-P Options -------------
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g \"\"'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files'] 

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 1
endif
"let g:ctrlp_regexp = 1
" ----------- AG Options -------------
let g:ag_prg="ag --ignore=*.out"
let g:ag_format="%f:%l:%m"

" ----------- Theme -------------
"colorscheme solarized

if has ("gui_running")
  set background=dark
  colorscheme PaperColor 
else
endif
