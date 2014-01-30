  set backspace=indent,eol,start        " more powerful backspacing

" Now we set some defaults for the editor
  set autoindent        " always set autoindenting on
" set linebreak         " Don't wrap words by default
  set textwidth=0       " Don't wrap lines by default
  set nobackup          " Don't keep a backup file
  set viminfo='20,\"50  " read/write a .viminfo file, don't store more than
                        " 50 lines of registers
  set history=50        " keep 50 lines of command line history
  set ruler             " show the cursor position all the time

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
  set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Vim5 and later versions support syntax highlighting.
" Just load the main syntax file when Vim was compiled with "+syntax".
  if has("syntax")
     syntax on
  endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
  set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
" if has("autocmd")
"   au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"     \| exe "normal g'\"" | endif
" endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
" if has("autocmd")
"   filetype indent on
" endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
  set showcmd           " Show (partial) command in status line.
  set showmatch         " Show matching brackets.
" set ignorecase        " Do case insensitive matching
" set smartcase         " Do smart case matching
" set incsearch         " Incremental search
" set autowrite         " Automatically save before commands like :next and :make
" When switching between different buffers you can't use undo without 'set hidden':
  set hidden            " Hide buffers when they are abandoned
  set mouse=a           " Enable mouse usage (all modes) in terminals
  set wildmenu          " command-line completion operates in an enhanced mode

  set pastetoggle=<f11>               " don't change text when copy/pasting
  set dictionary=/usr/share/dict/word " used with CTRL-X CTRL-K

""" set the screen hardstatus to vim(filename.ext)
  if ((&term =~ '^screen') && ($VIM_PLEASE_SET_TITLE =~ '^yes$') || has('gui_running'))
    set t_ts=k
    set t_fs=\
    set title
    autocmd BufEnter * let &titlestring = "vim(" . expand("%:t") . ")"
    let &titleold = fnamemodify(&shell, ":t")
  endif

" turn these ON:
  set ek vb
" turn these OFF ("no" prefix):
  set nodigraph noeb noet nosol
" non-toggles:
  set bs=2 fo=cqrt ls=2 shm=at ww=<,>,h,l
" set bs=2 fo=cqrt ls=2 shm=at tw=72 ww=<,>,h,l
  set comments=b:#,:%,fb:-,n:>,n:)
"  set list listchars=tab:»·,trail:·
  set listchars=eol:$,precedes:«,extends:»,tab:»·,trail:·
  set viminfo=%,'50,\"100,:100,n~/.viminfo
  set tags=./tags,./TAGS,tags,TAGS,../tags,../../tags,../../../tags,../../../../tags

" autocommands:
" when the file type is "mail" then set the textwidth to "70":
  if has("autocmd")
     au FileType mail   set tw=70
" When editing a file, always jump to the last cursor position
"  au BufReadPost * if line("'\"") | exe "'\"" | endif
     autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
  endif

  if has("syntax")
     syn on
  endif

" some useful mappings:

" remove/delete trailing whitespace:
  nmap ;tr :%s/\s\+$//
  vmap ;tr  :s/\s\+$//

" execute the command in the current line (minus the first word, which
" is intended to be a shell prompt) and insert the output in the buffer
  map ,e ^wy$:r!"

" update timestamp
  iab YDATE <C-R>=strftime("%a %b %d %T %Z %Y")<CR>
  map ,L  1G/Latest change:\s*/e+1<CR>CYDATE<ESC>

" the shell in a box mode. found in posting by Stefan `Sec` Zehl
" in newsgroup de.alt.sysadmin.recovery, msg­id:  <df7lhe$2hup$1@ice.42.org>
" Requires zsh for "print -P $PS1" / replace if needed.
" Your prompt should end in > (and only contain one)
" so run something like:
"   % export PS1='%n@%m > '
" in your zsh, press ',l' and <enter> for running commands, end mode via <esc>
  map __start :imap <C-V><C-M> <C-O>__cmd<C-V>\|imap <C-V><ESC> <C-V><ESC>__end<C-M>
  noremap __end :iunmap <C-V><CR>\|iunmap <C-V><ESC><C-M>:"Vish ended.<C-M>
  noremap __cmd 0<ESC>f>ly$:r !<C-R>";print -P $PS1<C-M>A
  noremap __scmd :r !print -P $PS1<c-M>A
  map ,l __start__scmd

" Kill quote spaces (when quoting a quote)
  map ,kqs mz:%s/^> >/>>/<cr>

if version >= 700
  " set maximum number of suggestions listed to top 10 items:
  set sps=best,10

  " highlight matching parens:
  " set matchpairs=(:),[:],{:},< :>
  " let loaded_matchparen = 1
  " highlight MatchParen term=reverse   ctermbg=7   guibg=cornsilk

  " highlight the cursor line and column:
  " set cursorline
  " highlight CursorLine   term=reverse   ctermbg=7   guibg=#333333
  " highlight CursorColumn guibg=#333333

  " change inner tag - very useful e.g. within HTML-code!
  " ci" will remove the text between quotes, also works for ' and `
  imap <F10> <C-O>cit

  " use the popup menu also when there is only one match:
  " set completeopt=menuone
  " determine the maximum number of items to show in the popup menu for:
  set pumheight=7
  " set completion highlighting:
  "  highlight Pmenu      ctermbg=13     guifg=Black   guibg=#BDDFFF              " normal item
  "  highlight PmenuSel   ctermbg=7      guifg=Black   guibg=Orange               " selected item
  "  highlight PmenuSbar  ctermbg=7      guifg=#CCCCCC guibg=#CCCCCC              " scrollbar
  "  highlight PmenuThumb cterm=reverse  gui=reverse guifg=Black   guibg=#AAAAAA  " thumb of the scrollbar
endif


" persistent undo
" The undo files will be stored in $HOME/.cache/vim
if version >= 703
 " enable persistent-undo
 set undofile

 " store the persistent undo file in ~/.cache/vim
 set undodir=~/.cache/vim/

 " create undodir directory if possible and does not exist yet
 let targetdir=$HOME . "/.cache/vim"
 if isdirectory(targetdir) != 1 && getftype(targetdir) == "" && exists("*mkdir")
  call mkdir(targetdir, "p", 0700)
 endif
endif

set tabstop=4
set shiftwidth=4
set expandtab

" Automatisches einfügen von tabs nach einrückenung vorheriger Zeile
set smarttab
set colorcolumn=80

function InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
     return "\<tab>"     
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" --------- Split windows
" Easy split window navigation
" use ALT+navigation key to switch split windows
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>


call pathogen#infect()

"colorscheme solarized
colorscheme Tomorrow-Night

call togglebg#map("<F5>")

if has('gui_running')
    set guioptions-=T
    set guioptions-=r
    set guioptions-=m

    set guioptions-=L
    set guioptions-=l
    set guioptions-=R

    "set guifont=DejaVu\ Sans\ Mono\ 10
    set guifont=PragmataPro\ 11
endif

" Markdown Conversion
map <F11> :silent !m %  &<CR> :redraw! <CR>

" CommandT
nnoremap <silent> <C-p> :CommandT<CR>

"NerdTree
noremap <silent> <F10> :NERDTreeToggle<CR>
set wildignore+=*.pyc

nmap <F9> :TagbarToggle<CR>


" Save & restore folding state
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

set wildignore+=*.o,*.obj,.git,*.aux,*.nav,*.out,*.snm,*.toc,*.pdf

" When saving call make
au BufWritePost        *.c make

let g:languagetool_jar='/usr/share/java/languagetool/LanguageTool.jar'
let g:languagetool_lang='de'

let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:headings'
        \ ],
    \ 'sort' : 0,
    \ }

" Save on focus lost
au FocusLost * silent! wa

" setup gx
let g:netrw_browsex_viewer= "firefox"

" set conceal color
hi Conceal guibg=Black guifg=White

" enable autosave when :make
set autowrite

map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" highlight hits, when searching
set hlsearch


" enable markdown2ctags
" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/.vim/bundle/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
let g:tagbar_type_mark = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/.vim/bundle/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }


set linebreak
set showbreak=↪

" always show 2 lines at the edges of the screen
set scrolloff=2
