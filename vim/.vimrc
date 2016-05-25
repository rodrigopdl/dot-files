""
"" Vundle
""
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugins')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/syntastic'
Plugin 'Tpope/vim-commentary'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-unimpaired'
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'skammer/vim-css-color'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-git'
Plugin 'thoughtbot/vim-rspec'
Plugin 'pangloss/vim-javascript'
Plugin 'mustache/vim-mustache-handlebars'

call vundle#end()
filetype plugin indent on

colorscheme railscasts

""
"" Disable arrow keys
""
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

""
"" Basic Setup
""
syntax on                         " turn on syntax highlighting allowing local overrides
set history=50                    " keep 50 commands and 50 search patterns in the history
set ruler                         " show line and column number
set encoding=utf-8                " set default encoding to UTF-8
set showcmd                       " display incomplete commands
set number                        " show line numbers

set clipboard=unnamed

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

""
"" Whitespace
""
set wrap                          " wrap lines, use set nowrap to avoid wrapping
set softtabstop=2                 " use mix of spaces and tabs
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set backspace=indent,eol,start    " backspace through everything in insert mode
let ruby_space_errors=1
let c_space_errors=1

""
"" Searching
""
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter
set incsearch   " incremental searching
set hlsearch    " highlight matches with the last used search pattern
nnoremap <CR> :noh<CR><CR>

set lazyredraw " Don't redraw screen when running macros.

""
"" File types
""

" Some file types should wrap their text
function! s:setupWrapping()
  set wrap
  set linebreak
  set textwidth=72
  set nolist
endfunction

" use the indent of the previous line for a newly created line
set autoindent

" turn on filetype plugins (:help filetype-plugin)
filetype plugin indent on

" use real tabs ...
autocmd FileType make set noexpandtab
autocmd FileType python set noexpandtab
autocmd FileType c setl tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab
autocmd FileType ruby setl nowrap tabstop=8 shiftwidth=2 textwidth=0 expandtab
autocmd FileType cpp set noexpandtab

" Set the Ruby filetype for a number of common Ruby files without .rb
autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,config.ru,*.rake} set filetype=ruby

" Make sure all markdown files have the correct filetype set and setup wrapping
autocmd BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

" Treat JSON files like JavaScript
autocmd BufNewFile,BufRead *.json set filetype=javascript

autocmd BufNewFile,BufRead *.flex set filetype=lex

" Remember last location in file, but not for commit messages.
" see :help last-position-jump
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Turn on spell checking for git commits
autocmd FileType gitcommit setlocal spell

""
"" Wild settings
""
" list all matches and complete till longest common string
set wildmode=list:longest

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" Ignore bundler and sass cache
set wildignore+=*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
" Disable temp and backup files
set wildignore+=*.swp,*~,._*

""
"" Backup and swap files
""
set backupdir=~/.vim/tmp/backup/    " where to put backup files.
set directory=~/.vim/tmp/swap/      " where to put swap files.

""
"" Persistent Undo
""
set undofile
set undodir=~/.vim/tmp/undo

""
"" Status line
""
set laststatus=2
set statusline=
set statusline+=\ \[%n]\                     "Buffer number
set statusline+=%<%f\                        "File
set statusline+=%m%r%h%q%w\                  "Modified? Readonly? Help? Quickfix? Preview?
set statusline+=%{SyntasticStatuslineFlag()} "Add syntastic if enabled
set statusline+=%{fugitive#statusline()}\    "Add fugitive if enabled
set statusline+=%y\                          "FileType
set statusline+=[%{&fenc!=''?&fenc:&enc}     "Encoding
set statusline+=%{(&bomb?',bom':'')}]\       "Encoding2
set statusline+=[%{&ff}]\                    "FileFormat
set statusline+=%=\ Line:%l/%L\ (%p%%)\ \    "Line/total (%)
set statusline+=Column:%c\                   "Column

""
"" Layout
""
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

""
"" GitGutter
""
let g:gitgutter_eager = 0

""
"" CtrlP
""
map <C-b> :CtrlPBuffer<CR>

""
"" Populate the g:airline_symbols dictionary with the powerline symbols
""
let g:airline_powerline_fonts = 1

""
"" Set red column marker at 80 characters length
""
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

map <leader>y "0y
map <leader>p "0p

""
"" The Silver Searcher
""
set grepprg=ag

" Make CtrlP use ag for listing the files. Way faster and no useless files.
" Without --hidden, it never finds .travis.yml since it starts with a dot
let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
let g:ctrlp_use_caching = 0

""
"" bind K to grep word under cursor
""
" nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap K :call SearchForCallSitesCursor()<CR>

function! SearchForCallSitesCursor()
  let searchTerm = expand("<cword>")
  call SearchForCallSites(searchTerm)
endfunction

" Search for call sites for term (excluding its definition) and
" load into the quickfix list.
function! SearchForCallSites(term)
  cexpr system('ag ' . shellescape(a:term) . '\| grep -v def')
endfunction

""
"" Open quickfix window after any grep invocation
""
autocmd QuickFixCmdPost *grep* cwindow

""
"" RSpec.vim mappings
""
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>n :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

""
"" Edit another file in the same directory as the current file
"" uses expression to extract path from current file's path
""
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>

""
"" Mustache-Handlebars
""
let g:mustache_operators = 0

""
"" Open Netrw
""
command! -nargs=* -bar -bang -count=0 -complete=dir E Explore <args>
command! -nargs=* -bar -bang -count=0 -complete=dir VE Vexplore <args>
