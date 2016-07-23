
" vimrc file for following the coding standards specified in PEP 7 & 8.
"
" All setting are protected by 'au' ('autocmd') statements.  Only files
" ending in .py or .pyw will trigger the Python settings while files
" ending in *.c or *.h will trigger the C settings.  This makes the file
" safe in terms of only adjusting settings for Python and C files.
"
" Only basic settings needed to enforce the style guidelines are set.
" Some suggested options are listed but commented out at the end of this
" file.

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.

fu Select_c_style()
    if search('^\t', 'n', 150)
        set shiftwidth=2
        set noexpandtab
    el
        set shiftwidth=2
        set expandtab
    en
endf

set runtimepath+=~/.vim/after/syntax

let currentHour = strftime("%H")
if currentHour < 6 + 0
    let colorScheme = "darkblue"
elseif currentHour < 12 + 0
    let colorScheme = "darkblue"
elseif currentHour < 18 + 0
    let colorScheme = "darkblue"
else
    let colorScheme = "evening"
endif

execute "colorscheme ".colorScheme

set autoindent

" set ts=2 sts=2 sw=2 noexpandtab

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
filetype indent on

" use visual bell instead of beeping
set vb

" incremental search
set incsearch

" syntax highlighting
set bg=light
"set bg=dark
"
set cindent
set cinkeys=0{,0},!^F,o,O,e " default is: 0{,0},0),:,0#,!^F,o,O,e

"""""""""""""""""""""""""""""""""""""""""""""""""""
"
"        Global settings
"
"""""""""""""""""""""""""""""""""""""""""""""""""""

" comment/uncomment blocks of code (in vmode)
vmap _c :s/^/#/gi<Enter>
vmap _C :s/^#//gi<Enter>

map <F8> :'a,.s/^/#/gi^M:nohl^M

" dont use Q for Ex mode
map Q :q

" make tab in v mode ident code
vmap <tab> >gv
vmap <s-tab> <gv

" make tab in normal mode ident code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

"" paste mode - this will avoid unexpected effects when you
"" cut or copy some text from one window and paste it in Vim.
" set paste

set number

"" Jump to the last position
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

"""""""""""""""""""""""""""""""""""""""""""""""""""
"
"        Perl/Python/Ruby related stuff
"
"""""""""""""""""""""""""""""""""""""""""""""""""""

" autoindent
au BufRead,BufNewFile *.pl syntax on | set ai
au FileType perl set autoindent | set smartindent
au FileType perl set showmatch
au FileType perl set number

" check perl code with :make
au FileType perl set makeprg=perl\ -c\ %\ $*
au FileType perl set errorformat=%f:%l:%m
au FileType perl set autowrite

au BufRead *.pl set smartindent cinwords=if,elif,else,for,while
au BufRead *.t set smartindent cinwords=if,elif,else,for,while

" perl includes pod
let perl_include_pod = 1

" syntax color complex things like @{${"foo"}}
let perl_extended_vars = 1

" au BufRead,BufNewFile *.py syntax on | set ai | set filetype=python
" au BufRead,BufNewFile *.py syntax on | set ai

" au BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,print

" autoindent
" au FileType python setl autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4
" au FileType python set smartindent | set autoindent | set showmatch

" For full syntax highlighting:
" let python_highlight_all=1
"syntax on

" Wrap text after a certain number of characters
" Python: 79.
" C: 79
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=80 | set tabstop=4

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" C: tabs (pre-existing files) or 4 spaces (new files)
" au BufRead,BufNewFile *.py,*pyw set shiftwidth=4 | set expandtab

" autoindent
" au FileType ruby set smartindent | set autoindent | set showmatch

" Ruby
"au FileType ruby,eruby,yaml setlocal softtabstop=2 | shiftwidth=2 | tabstop=2
" au FileType ruby,eruby,yaml setlocal softtabstop=2

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
au BufRead,BufNewFile *.c,*.h set tabstop=8
au BufRead,BufNewFile *.c,*.h call Select_c_style()


""""""""""""""""""""""""""""""""""""""""""""""""
"            Makefile
""""""""""""""""""""""""""""""""""""""""""""""""

au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Tidy selected lines (or entire file) with _t:
nnoremap <silent> _t :%!perltidy -q<Enter>
vnoremap <silent> _t :!perltidy -q<Enter>

" Deparse obfuscated code
nnoremap <silent> _d :.!perl -MO=Deparse 2>/dev/null<cr>
vnoremap <silent> _d :!perl -MO=Deparse 2>/dev/null<cr>

" -----------------------------------------------------
"
"            Suggest settings
"
"------------------------------------------------------

" Set the default file encoding to UTF-8: ``set encoding=utf-8``

" Puts a marker at the beginning of the file to differentiate
" between UTF and UCS encoding (WARNING: can trick shells into thinking
" a text file is actually a binary file when executing the text file):
" ``set bomb``

" For full syntax highlighting:
"``let python_highlight_all=1``
"``syntax on``

" Automatically indent based on file type: ``filetype indent on``
" Keep indentation level from previous line: ``set autoindent``

" Folding based on indentation: ``set foldmethod=indent``

"set nohlsearch
"set ai
"set showmatch
"highlight SpecialKey ctermfg=DarkGray
"set listchars=tab:>-,trail:~
"set list
"autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
"set tabstop=4
"set shiftwidth=4
"set expandtab
"set autoindent
"set smartindent
"syntax on
"set listchars=tab:>-
"set listchars+=trail:.
"set ignorecase
"set smartcase
"

"
" vimrc file from Tavis Ormandy, security expert from Google
"

"" abbreviations for c programming
"func LoadCAbbrevs()
"    iabbr do do {<CR>} while ();<C-O>3h<C-O>
"    iabbr for for (;;) {<CR>}<C-O>k<C-O>3l<C-O>
"    iabbr switch switch () {<CR>}<C-O>k<C-O>6l<C-O>
"    iabbr while while () {<CR>}<C-O>k<C-O>5l<C-O>
"    iabbr if if () {<CR>}<C-O>k<C-O>2l<C-O>
"    iabbr #d #define
"    iabbr #i #include
"endfunc
"
"set ci sc wmnu et nosol si bs=2 ls=2
"set shm=IatA ww=<,>,[,] ts=4 sw=4
"set lcs=eol:$,tab:>-,trail:.,extends:>
"set pt=<F5> nomore modelines=5 modeline hls!
"syn on
"
"ino <Down> <C-O>gj
"ino <Up> <C-O>gk
"nno <Down> gj
"nno <Up> gk
"
"nno <F2> :set hls!<bar>set hls?<CR>
"nno <F3> :set nu!<bar>set nu?<CR>
"
"colo torte
"
"" language dependent options
"let asmsyntax="nasm"
"let c_comment_strings=1
"let c_space_errors=0
"let rgb_file="/usr/lib/X11/rgb.txt"
"let bash_is_sh=1
"let highlight_function_name=1
"
"" autocommands
"au FileType c,cpp call LoadCAbbrevs()
"


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" add this line to your .vimrc file
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-sensible'
Plugin 'kien/ctrlp.vim'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'elzr/vim-json'
Plugin 'groenewege/vim-less'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'hynek/vim-python-pep8-indent'
" The official vim-bash-support
"Plugin 'bash-support.vim'
Plugin 'tieli/bash-support.vim'


" My personal vim file
Plugin 'tieli/vim-misc'

" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add 
" this if you want them:
Plugin 'honza/vim-snippets'

Bundle 'vim-ruby/vim-ruby'

call vundle#end()


":setlocal foldmethod=indent
"augroup vimrc
"  au BufReadPre * setlocal foldmethod=indent
"  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
"augroup END
"
let mapleader=','
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
	let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
	endif
endfunction

set formatprg=par
"set paste
"


" Disable stupid backup and swap file
set nobackup
set nowritebackup
set noswapfile

set nofoldenable

" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git

let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

"autocmd VimEnter * NERDTree

let g:NERDTreeDirArrows = 0
let g:NERDTreeWinSize=20
let g:NERDTreeWinPos = "left"
map <C-n> :NERDTreeToggle<CR>

"let g:nerdtree_tabs_open_on_console_startup=1

set encoding=utf-8

"set mouse=a

"set paste toggle
set pastetoggle=<F12>

"allow mouse change curse position
"set mouse=a

set nocompatible              " be iMproved, required

syntax on
filetype detect

if has("autocmd")
  filetype plugin indent on
endif

"filetype off                  " required
"
"filetype on

"filetype off

"call pathogen#infect()
"call pathogen#helptags()
"
"filetype plugin indent on
syntax on

"filetype detect
"filetype plugin on
"syntax on

filetype off                  " required
filetype plugin on
filetype indent on

"set fdm=indent
"set fdc=4
"set fdl=1
"set fen

" tabs will be shown as > for the start position 
" and - through the rest of the tab.
"set list
"set listchars=tab:>-
 
" vim bash-support

let g:BASH_AuthorName   = 'Tiejun Li'
let g:BASH_Email        = 'tiejli@yahoo.com'
let g:BASH_Company      = 'SilkStudio Inc'
let g:BASH_InsertFileHeader = 'no'

"The same effect as -X option
"  -X
"  Do not try connecting to the X server to get the current
"  window title and copy/paste using the X clipboard.  This
"  avoids a long startup time when running Vim in a terminal
"  emulator and the connection to the X server is slow.
"  See --startuptime to find out if affects you.
"  Only makes a difference on Unix or VMS, when compiled with 
"  the +X11 feature.  Otherwise it's ignored.  To disable the 
"  connection only for specific terminals, see the 'clipboard' 
"  option. When the X11 Session Management Protocol (XSMP) 
"  handler has been built in, the -X option also disables that 
"  connection as it, too, may have undesirable delays.
set clipboard=exclude:.*

