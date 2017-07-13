""
"" Plug
""
call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'scrooloose/syntastic'
Plug 'Tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ap/vim-css-color'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-git'
Plug 'thoughtbot/vim-rspec'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'morhetz/gruvbox'

call plug#end()

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
set nocompatible
syntax on                         " turn on syntax highlighting allowing local overrides
filetype plugin indent on
set formatoptions-=t
set history=50                    " keep 50 commands and 50 search patterns in the history
set ruler                         " show line and column number
set encoding=utf-8                " set default encoding to UTF-8
set showcmd                       " display incomplete commands
set number                        " show line numbers
set relativenumber                " relative numbering
set guioptions=
set noshowmode

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

set ttyfast
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

colorscheme gruvbox
hi LineNr ctermfg=238
hi CursorLineNR ctermfg=239 ctermbg=234
hi StatusLine ctermfg=234 ctermbg=15
hi StatusLineNC ctermfg=234 ctermbg=238
hi VertSplit ctermbg=234
hi Search ctermbg=58 ctermfg=15
hi Default ctermfg=1
hi clear SignColumn
hi SignColumn ctermbg=233
hi GitGutterAdd ctermbg=233 ctermfg=245
hi GitGutterChange ctermbg=233 ctermfg=245
hi GitGutterDelete ctermbg=233 ctermfg=245
hi GitGutterChangeDelete ctermbg=233 ctermfg=245
hi EndOfBuffer ctermfg=245 ctermbg=233
hi ColorColumn ctermbg=234

set statusline=%=%f\ %m\ %P
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
set laststatus=2

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
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

" =====================================
"  FZF
" =====================================
" set fzf's default input to AG instead of find. This also removes gitignore etc
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
let g:fzf_files_options =
  \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'

""
"" FZF
""
nnoremap <C-b> :Buffers<CR>
nnoremap <C-p> :Files<CR>

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
"" Overwrite the g:rspec_command variable to execute a custom command.
""
let g:rspec_command = "!bundle exec rspec {spec}"

""
"" Edit another file in the same directory as the current file
"" uses expression to extract path from current file's path
""
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>

""
"" Open Netrw
""
command! -nargs=* -bar -bang -count=0 -complete=dir E Explore <args>
command! -nargs=* -bar -bang -count=0 -complete=dir VE Vexplore <args>

""
"" Remap H and L (top, bottom of screen to left and right end of line)
""
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

""
"" Easier window switching
""
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

""
"" When jump to next match also center screen
"" Note: Use :norm! to make it count as one command. (i.e. for i_CTRL-o)
""
nnoremap <silent> n :norm! nzz<CR>
nnoremap <silent> N :norm! Nzz<CR>
vnoremap <silent> n :norm! nzz<CR>
vnoremap <silent> N :norm! Nzz<CR>

""
"" Same when moving up and down
""
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
vnoremap <C-u> <C-u>zz
vnoremap <C-d> <C-d>zz

""
"" Setting 'scrolloff' to a large value causes the cursor to stay in the middle
"" line when possible. To restore normal behavior, enter: 'set so=0'
""
set so=999

""
"" Remap H and L (top, bottom of screen to left and right end of line)
""
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

""
"" Bubble multiple lines
""
vmap <C-k> [egv
vmap <C-j> ]egv

""
"" Remap q to avoid accidentally triggering recording
""
noremap <Leader>q q
noremap q <Nop>

""
"" Ctags
""
map <Leader>rt :!ctags --tag-relative --extra=+f -Rf.git/tags --exclude=.git,pkg --languages=-javascript,sql<CR><CR>
set tags+=.git/tags

""
"" GBrowse
""
map <leader>b :Gbrowse<CR>
