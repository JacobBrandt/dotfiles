"----------------------- Begun Vundle Setup ------------------------------------
" Vundle allows us to manage plugins with ease
set nocompatible              " Required
filetype off                  " Required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Keep Plugin commands between vundle#begin/end.

" Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" File search Plugin
Plugin 'kien/ctrlp.vim'
" PHP syntax Plugin
Plugin 'scrooloose/syntastic'
" NERDTree Plugin
Plugin 'scrooloose/nerdtree'
" Auto-completion Plugin
Plugin 'Raimondi/delimitMate'

" Snipmate Plugin
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

" PHP Xdebug Plugin
Plugin 'joonty/vdebug'

" Fugtive (Git Wrapper)
Plugin 'tpope/vim-fugitive'

" The following are examples of different formats supported.
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

source variables.vim

"----------------------- Syntasic Plugin ---------------------------------------
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers = ["php"]

"----------------------- CtrlP Plugin ------------------------------------------
"searching by filename (as opposed to full path)
let g:ctrlp_by_filename = 0 "in {0,1}
let g:ctrlp_regexp = 1
let g:ctrlp_mruf_max = 1000
" Make ctrlp only look for source controlled files
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']

"----------------------- NERDTree Plugin ---------------------------------------
" Close NERDTree if it is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeChDirMode=2
"autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif

"----------------------- VIM settings ------------------------------------------

" Keep this as the first setting
set nocompatible        " Do not behave like old VI

"----------------------- General -----------------------------------------------
set visualbell          " Don't beep
set noerrorbells        " Don't beep
set modeline            " Enable modeline
set ttyscroll=0         " Turn off scrolling
set ttyfast             " Set if you have a fast terminal connection
set splitright          " Split vertically using right side of window
set splitbelow          " Split horizontally using the bottom of the window

"----------------------- Visual ------------------------------------------------
set nowrap              " Don't wrap lines
set showcmd             " Show (partial) command in status line
set showmatch           " Show matching parenthesis
set showmode            " Show current mode
set ruler               " Show the line and column numbers of the cursor
set mousehide           " Hide the mouse when typing
set hlsearch            " Highlight search patterns
set hidden              " Hide buffers instead of closing them
set wildignore=*.swp,*.bak,*.pyc,*.class
set wildmenu            " Turn on the wildmenu (for tab completion)
set wildmode=full       " Complete the next full match
set number              " Always show line numbers
set colorcolumn+=81     " Highlight column after 'textwidth'
set listchars=extends:# " Show a '#' if a line is longer than the screen
set laststatus=2        " Always show status line
set cursorline          " Highlight the cursor line
" Custom Statusline
set statusline=         " Clear out
set statusline+=%m%r%w  " Show modified/read-only/preview-window
set statusline+=%t\     " Show file name
"set statusline+=\|\ %{strftime('%Y/%b/%d\ %a\ %I:%M\ %p')}\
set statusline+=\|\%{GetMethodName()}\ \|\ " Show method name
set statusline+=%=%{GetBranchName()}\ \@\ \%{GetRepoName()}\ \|\ %l,%v\ \|\ %p%%\ " Show Line number,Column | Percent in file
set statusline+=%{SyntasticStatuslineFlag()}

"----------------------- No Backup or Swap Files -------------------------------
set nobackup            " Don't create a backup (I'll do it myself)
set nowritebackup       " Don't automatically create a backup
set noswapfile          " Don't create a swap file

"----------------------- Undo --------------------------------------------------
set history=1000        " Remember more commands and search history
set undolevels=1000     " Use many levels of undo

"----------------------- Search/Navigation -------------------------------------
set ignorecase          " Ignore case when searching
set smartcase           " Ignore case if search pattern is all lowercase, case-sensitive otherwise
set incsearch           " Show search matches as you type
set scrolloff=5         " Keep a small context when scrolling
set magic               " Use extended regular expressions
set nostartofline       " Do not jump to first character with page commands
set gdefault            " Search and replace all occurrences by default

"----------------------- Editing (Indent, Tabs, Replace, etc.) -----------------
set backspace=indent,eol,start "Allow backspacing over everything in insert mode
set autoindent          " Auto indent file
set smartindent         " Smart indents
set shiftwidth=2        " Number of spaces to use for auto indenting
set tabstop=2           " A tab is 2 spaces
set expandtab           " Use spaces instead of tabs
set smarttab            " Insert tabs on the start of a line according to shiftwidth, not tabstop
set title               " Change the terminal's title
" set list                " Highlight whitespace
"set pastetoggle=<F3>    " Easily switch to paste mode so that we can paste large buffers without cascading indents
"set switchbuf+=newtab   " Quickfix in new tab

set completeopt=menu,preview
" Remove any trailing whitespace or empty lines with whitespace on save
"autocmd BufWritePre <buffer> :call StripTrailingWhitespace()
" strips trailing whitespace from file.
function! StripTrailingWhitespace()
  " save last search and cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")
  " e suppresses any errors
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

"---------------------- Syntax & Filetypes -------------------------------------
if has("autocmd")
  filetype on
  filetype indent on
  filetype plugin on
  syntax on
  "filetype plugin indent on
endif

" Don't show tabs for .snippets
autocmd FileType snippets setlocal listchars-=tab:>.

" Comments used for filetypes
au FileType c,cpp,java,php,drupal setlocal comments-=:// comments+=f://

" Automatically set the current directory to this files location
autocmd BufEnter * silent! lcd %:p:h

" Map enter onto itself in quickfix window so we can open the file under
" cursor
:autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Automatically save folds
"au BufWinLeave ?* mkview
"au BufWinEnter ?* silent loadview

" Set drupal file extensions
autocmd BufRead,BufNewFile *.module  set filetype=drupal
autocmd BufRead,BufNewFile *.profile set filetype=drupal
autocmd BufRead,BufNewFile *.theme   set filetype=drupal
autocmd BufRead,BufNewFile *.install set filetype=drupal

"----------------------- Colors / Font -----------------------------------------
"set term=xterm-256color
colorscheme custom      " Colorscheme
" NOTE: All other color deviations must come after setting the colorscheme
set guifont=monaco:h12
hi ColorColumn ctermbg=black guibg=black

"----------------------- Functions ---------------------------------------------
function! GetMethodName()
  let filename = expand("%:t:r")
  let lnum = line(".")
  let col = col(".")
  let searchPattern = "^function"
  if(&filetype == "cpp")
    let searchPattern = filename . "::"
  elseif(&filetype == "php")
    let searchPattern = ".*function"
  endif

  let found = getline(search(searchPattern, 'nbW'))
  let method = substitute(found, searchPattern, '', '')
  let method = substitute(method, '\(.*\)(.*', '\1', '')
  "echo "Method: " . method
  return method
endfunction

"-------------------------------------------------------------------------------
function! CommentCode()
  let c = '// '
  if(&filetype =~ 'vim\|_gvimrc')
    let c = '" '
  elseif(&filetype =~ 'ruby')
    let c = '# '
  endif
  let line = getline('.')
  execute ':s,^\(\s*\)[^' . c . ' \t]\@=,\1' . c . ',e'
  execute ':nohls'
endfunction

"-------------------------------------------------------------------------------
function! UncommentCode()
  let c = '// '
  if(&filetype =~ 'vim\|_gvimrc')
    let c = '" '
  elseif(&filetype =~ 'ruby')
    let c = '# '
  endif
  let line = getline('.')
  execute ':s,^\(\s*\)' . c . '\s\@!,\1,e'
  execute ':nohls'
endfunction

"-------------------------------------------------------------------------------
function! GetBranchName()
  "let branchName = system('parse_git_branch')
  "let command = "git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\[\1\]/'"
  let command = "git branch --no-color 2> /dev/null | grep \"^*\""
  "let command = "git symbolic-ref --short HEAD 2> /dev/null"
  let branchName = system(command)
  let branchName = substitute(branchName, '\* \(.*\)\n', '\1', '')
  return branchName
endfunction

"-------------------------------------------------------------------------------
function! GetRepoName()
  let command = "basename `git rev-parse --show-toplevel`"
  let reponame = system(command)
  let reponame = substitute(reponame, '\n', '', '')
  if(reponame =~ "fatal")
    return "Not source controlled!"
  else
    return reponame
  endif

  return reponame
endfunction

"-------------------------------------------------------------------------------
function! GoToTag(tagWord)
  :tabe
  execute ':silent tjump ' . a:tagWord

  let l:tagFilename = expand('%:t')

  if l:tagFilename == ''
      :tabclose
      :tabprevious
  endif
endfunction

"----------------------- Mappings ----------------------------------------------
" Set leader to ,
let mapleader=","

" Tabularize
if exists(":Tabularize")
  nmap <leader>g= :Tabularize /=<CR>
  vmap <leader>g= :Tabularize /=<CR>
  nmap <leader>g\ :Tabularize / <CR>
  vmap <leader>g\ :Tabularize / <CR>
  nmap <leader>g/ :Tabularize /\/\/<CR>
  vmap <leader>g/ :Tabularize /\/\/<CR>
  nmap <leader>g: :Tabularize /:\zs<CR>
  vmap <leader>g: :Tabularize /:\zs<CR>
endif

"----------------------- Mappings (Normal Mode) --------------------------------
" Quickly get into execute mode
nnoremap ; :

" Commenting code.
noremap   <buffer> K      :call CommentCode()<CR>
noremap   <buffer> <C-K>  :call UncommentCode()<CR>

" Ctags navigation
nnoremap <C-\> :tabnew %<CR>g<C-]>
"nnoremap <C-]> :call GoToTag("<c-r><c-w>")<CR>
:nnoremap <silent><leader>g <C-w><C-]><C-w>T

" Insert new line above/below line
map <S-Enter> O<Esc>
map <CR> o<Esc>

" Switch between two split windows
map <C-N> <c-w>w

" Save file with Ctrl-S
map <C-S> :w<CR>

" Generate ctags for the current directory
map <C-F12> :!ctags -f ~/.vim/tags/cpp -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ .<CR>
map <C-F11> :call CreatePhpTags()<CR>

" git mappings
" Bring up visual log display of file
nmap <silent><leader>vt :!gitk <c-r>% &<CR><CR>

" Autoindent entire block
nmap <Tab> =%

" Autoindent entire file
"nmap <F2> gg=G''

" Quickly edit/reload the preference files
nmap <silent> <leader>ev :tabnew ~/.vimrc<CR>
nmap <silent> <leader>sv :so ~/.vimrc<CR> :nohls<CR>
nmap <silent> <leader>ea :tabnew ~/.bashrc<CR>

" Edit todo list
nmap <silent> <leader>et :tabnew ~/temp/todo.txt<CR>

" Unhighlight search pattern
nmap <silent> <leader>/ :nohls<CR>

" Place text on cursor on new line
nnoremap <C-J> i<CR><Esc>

" Go to next/previous tab
nnoremap <silent> ( :tabprevious<CR>
nnoremap <silent> ) :tabnext<CR>

" List occurrences of word under cursor
nnoremap <leader>i [I

" Start search and replace for word under cursor.  Entire file.
nnoremap <leader>s :%s/\<<c-r><c-w>\>/
" Start search and replace for partial match of word under cursor.  Entire file.
nnoremap <leader>si :%s/<c-r><c-w>/
" Start search and replace for word under cursor.  Current line to end of file
nnoremap <leader>se :,$s/\<<c-r><c-w>\>/

" Replace word under cursor with current copy register
nnoremap S "_diwP

"----------------------- Mappings (Insert Mode) --------------------------------
" jj will exit insert mode
inoremap jj <Esc>
"
" Automatically create mathching bracket and place cursor inbetween
au Filetype java,cpp,php inoremap { {<CR>}<Esc>ko

" Insert the file name
au Filetype java,cpp,drupal inoremap /c <c-r>=expand("%:t:r")<CR>
" Insert the method name
au Filetype java,cpp,php inoremap /f <c-r>=GetMethodName()<CR>

"----------------------- Project Settings --------------------------------------
source project.vim
