" Must-Haves.
set nocompatible
filetype off

" Vundle Stuff
if has("win32") || has("win16")
    call plug#begin('$HOME/vimfiles/bundle/')
else
    call plug#begin('~/.vim/bundle')
endif

" Set mapleader before plugin loads
nnoremap <SPACE> <Nop>
let mapleader=" "
let maplocalleader=" "

" Python3
if has("win64") || has("win32")
    set pythonthreedll="C:\Python36\python36.dll"
endif

" Optional plugins
let ycm_enabled = 0

" Vim Internal Plugins
packadd matchit

" Visual Plugins
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Must-Have
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'Chiel92/vim-autoformat', { 'for': ['js', 'objc'] }
Plug 'cofyc/vim-uncrustify', { 'for': ['cpp', 'c'] }
Plug 'leandros/vim-bufkill'
Plug 'Konfekt/FastFold'
Plug 'ludovicchabant/vim-gutentags'
Plug 'leandros/taglist.vim'
Plug 'vim-scripts/YankRing.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'leandros/zoomwin'
Plug 'leandros/QFEnter'
Plug 'ervandew/supertab'
if ycm_enabled
    Plug 'Valloric/YouCompleteMe', { 'for': ['cpp', 'c', 'python'] }
endif

" I hate plugin interdependencies
Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/EnhancedJumps'

" General
Plug 'Yggdroot/LeaderF'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'mhinz/vim-grepper'
Plug 'thirtythreeforty/lessspace.vim'
Plug 'junegunn/vim-easy-align'

" NERDTree
Plug 'leandros/nerdtree'
if !has("win32") && !has("win16")
    Plug 'Xuyuanp/nerdtree-git-plugin'
endif

" Syntax Plugins
Plug 'jelera/vim-javascript-syntax'
Plug 'elzr/vim-json'
Plug 'dummyunit/vim-fastbuild'
Plug 'leandros/hlsl.vim'
Plug 'wlangstroth/vim-racket'
Plug 'luochen1990/rainbow', { 'for': ['scheme', 'lisp', 'racket'] }

" Lua Plugins. Disable until I work on Lua projects again.
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-notes'
" Plug 'xolox/vim-lua-ftplugin'


call plug#end()
filetype plugin indent on


" General
set langmenu=en_US.UTF-8
let $LANG='en_US'

" Set the default shell
if has("win32") || has("win16")
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    set shell=cmd.exe
    set shellcmdflag=/C
else
    set shell=$SHELL
endif

set fileencoding=utf-8 " Set the encoding written to file
set termencoding=utf-8 " Set the default encodings just in case $LANG isn't set
set encoding=utf-8  " Set the default encodings just in case $LANG isn't set
set cursorline      " Hightlight current selected line.
set ttyfast         " Set that we have a fast terminal
set emoji           " enable emoji's on Vim8
set clipboard+=unnamed " enabled system clipboard

set hidden          " Hide buffer, instead of closing it.
syntax enable
set number          " Always show line numbers.
set hlsearch        " Hightlight found searches.
set incsearch       " Show matched searches as you type.
set showmatch       " Show matching braces.
set ignorecase      " Ignore case when searching.
set smartcase       " Ignore case if search pattern is all lowercase, case-sensitive otherwise.
set nowrapscan      " Do not wrap when searching

set history=1000    " Larger command history.
set undolevels=1000 " Undo ALL the changes.
set visualbell      " Don't beep.
set noerrorbells    " Don't beep.

set nobackup        " Disable backup. set noswapfile can disable the .swp file.
set noswapfile

" Indentation is 4 spaces, and not a tab
set tabstop=4       " A tab is 4 spaces.
set autoindent      " Autoindent.
set copyindent      " Copy the previous indent on autoindenting.
set shiftwidth=4    " Number of spaces used for autoindent.
set expandtab
set smarttab        " Insert 'tabs' on start of line, according to shiftwidth instead of tabstop.

" Set mapping and key timeouts
set timeout
set timeoutlen=1000 " timeout for leader key
set ttimeoutlen=10  " timeout for esc key

" Show if leader key is pressed
set showcmd

" Correct backspace
set backspace=indent,eol,start

" Improve breaks
set showbreak=>>>
set breakindent

" Disable mouse
set mouse=c
set guioptions+=lrbmTLce
set guioptions-=lrbmTLce
set guioptions+=c

" Improve performance
"set ttyfast
"set lazyredraw

" Improve :b switch menu
set wildchar=<Tab> wildmenu wildmode=full

" Buffer switching
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

" Jump to buffers with Ngb
let c = 1
while c <= 99
  execute "nnoremap " . c . "gb :" . c . "b\<CR>"
  let c += 1
endwhile

" Cygwin cursor fix.
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Write undo tree to a file to resume from next time the file is opened.
if has("persistent_undo")
  set undolevels=2000            " The number of undo items to remember
  set undofile                   " Save undo history to files locally
  set undodir=$HOME/.vimundo     " Set the directory of the undofile
  if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
  endif
endif

" When running as diff.
if &diff
  set modifiable
  set noreadonly
  if tabpagenr('$') == 1
    nnoremap ZZ :wqall<cr>
  endif
endif

" Theme
set background=dark
colorscheme solarized

" Custom Filetypes
au BufRead,BufNewFile *.ds set filetype=rgbds
au BufRead,BufNewFile *.fl,*.flex,*.l,*.lm setlocal ft=lex      " Flex
au BufRead,BufNewFile *.y,*.ypp,*.ym setlocal ft=yacc           " Bison


" Compile and Run code. The primitive way.
command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
function! CompileC()
:   w
:   exec '!clang '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')
:   exec 'Silent rm '.shellescape('%:r')
endfunction
function! CompileCC()
:   w
:   exec '!clang++ -std=c++14 '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')
:   exec 'Silent rm '.shellescape('%:r')
endfunction
autocmd filetype c nnoremap <F5> :call CompileC()<CR>
autocmd filetype cpp nnoremap <F5> :call CompileCC()<CR>

" C-r is mapped to move one buffer up -_-
" autocmd filetype c nnoremap <C-r> :call CompileC()<CR>
" autocmd filetype cpp nnoremap <C-r> :call CompileCC()<CR>

" Warn about doing the wrong undo (U instead of u).
nnoremap U :echo " < < ===== C H E C K C A P S L O C K ===== > > "<CR>

" Map redo to r instead of C-r
nnoremap j <C-r>

" Map Vim Expression valuation
inoremap <c-a> <c-r>

" Convenient pasting.
set pastetoggle=<F2>

" Removed due to blocking super awesome multiline edit mode.
" Convenient copy to clipboard.
" vnoremap <C-c> :w !pbcopy<CR><CR>
" noremap <C-v> :r !pbpaste<CR><CR>

" Unhighlight searches
" using <esc> for this, behaves weird
nnoremap <C-d> :noh<return>

" Reselect visual blocks after movement
vnoremap < <gv
vnoremap > >gv

" Keep search matches in the middle of the window.
nnoremap ? nzzzv
nnoremap - Nzzzv

" Move by words
" nnoremap B B
" nnoremap S W
nnoremap <S-b> b
nnoremap <S-s> w
vnoremap <S-b> b
vnoremap <S-s> w

" Key map optimizations for Bone 2 Layout
" Normal Mode remaps.
nnoremap b <Left>
nnoremap r <Up>
nnoremap n <Down>
nnoremap s <Right>
nnoremap gn gj
nnoremap gr gk

" Visual and Select Mode remaps.
vnoremap b <Left>
vnoremap r <Up>
vnoremap n <Down>
vnoremap s <Right>
vnoremap gn gj
vnoremap gr gk

" No clue???
" nnoremap <C-B> <C-W><C-H>
" nnoremap <C-N> <C-W><C-J>
" nnoremap <C-R> <C-W><C-K>
" nnoremap <C-S> <C-W><C-L>

" Move page up / down
"nnoremap ( <PageDown>
"nnoremap ) <PageUp>
"vnoremap ( <PageDown>
"vnoremap ) <PageUp>

" Move half page up / down
nnoremap ( <C-D>
nnoremap ) <C-U>
vnoremap ( <C-D>
vnoremap ) <C-U>


" Move line up down
nnoremap <S-n> <C-e>
nnoremap <S-r> <C-y>
vnoremap <S-n> <C-e>
vnoremap <S-r> <C-y>

" Insert newline
" nnoremap <CR> o<Esc>
" inoremap <C-O> <Esc>o

" Split switching
nnoremap <C-n> <C-W>j
nnoremap <C-r> <C-W>k
nnoremap <C-b> <C-W>h
nnoremap <C-s> <C-W>l

" Split resizing
nnoremap ! 5<C-W>-
nnoremap = 5<C-W>+
nnoremap < 5<C-W><
nnoremap > 5<C-W>>

" Even out splits
nnoremap <C-y>w <C-W>=
nnoremap <C-y>m <C-W>_
nnoremap <C-y>t <C-W>T
nnoremap <C-y>l :ZoomWin<CR>

" Split Creating
nnoremap <C-i> :vsplit<CR>
nnoremap <C-t> :split<CR>

" Split killing
command! Bd bp\|bd \#
nnoremap <C-q> :BD<CR>
nnoremap <C-w> :bd<CR>

" Close / Open quickfix
nnoremap <Leader>qq :cclose<CR>
nnoremap <Leader>qc :cclose<CR>
nnoremap <Leader>qo :copen<CR>

" Tag navigation keys
nnoremap <Leader>d <C-]>
nnoremap <Leader>. <C-t>
" nnoremap <Leader>t :CtrlPTag<CR>
nnoremap <Leader>c :TlistToggle<CR>

" Tab navigation
nnoremap <C-u>b :tabprevious<CR>
nnoremap <C-u>s :tabnext<CR>
nnoremap <C-u>n :tabedit<CR>
nnoremap <C-u>c :tabclose<CR>
nnoremap <C-u>1 1gt
nnoremap <C-u>2 2gt
nnoremap <C-u>3 3gt
nnoremap <C-u>4 4gt
nnoremap <C-u>5 5gt
nnoremap <C-u>6 6gt
cabbrev tabv tab sview +setlocal\ nomodifiable

" ReMap NERDTree Keys.
let g:NERDTreeMapRefresh='<C-a>'
let g:NERDTreeMapRefreshRoot='<C-u>'
let g:NERDTreeMapOpenSplit='t'
let g:NERDTreeMapOpenVSplit='i'
let g:NERDTreeMenuDown='n'
let g:NERDTreeMenuUp='r'

let g:NERDTreeMapChdir='C'
let g:NERDTreeMapUpdir='u'
" let g:NERDTreeMapActivateNode='<CR>'
" let NERDTreeMapNextSibling='N'
" let NERDTreeMapPrevSibling='R'

" Custom bindings
augroup nerdtreebuf
    autocmd!
    autocmd FileType nerdtree nnoremap <buffer> <silent> <CR> :call nerdtree#ui_glue#invokeKeyMap("o")<CR>
augroup END

" Open NERDTree
map <Leader>e :NERDTreeToggle<CR>

" NERDTree options
let g:NERDTreeChDirMode = 2
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeIgnore = ['\.meta$','^\.DS_Store$']

" Open NERDTree when no files specified.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close VIM if only tab left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Hide Line Numbers
augroup nerdtree
    autocmd!
    autocmd FileType nerdtree set nonumber
    autocmd FileType nerdtree set norelativenumber
augroup END

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, regex, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^.*\('. a:regex .'\)$#'
endfunction

" source files
" For some reason, VIM doesn't like C files :(
" C
call NERDTreeHighlightFile('cfile', '\.c',          '11', 'NONE', 'NONE', 'NONE')
call NERDTreeHighlightFile('cheader', '\.h',        '9',  'NONE', 'NONE', 'NONE')
" C++
call NERDTreeHighlightFile('cc', '\.cc',            '5',  'NONE', 'NONE', 'NONE')
call NERDTreeHighlightFile('hh', '\.hh',            '9',  'NONE', 'NONE', 'NONE')
call NERDTreeHighlightFile('cpp', '\.cpp',          '5',  'NONE', 'NONE', 'NONE')
call NERDTreeHighlightFile('hpp', '\.hpp',          '9',  'NONE', 'NONE', 'NONE')
" Objective-C
call NERDTreeHighlightFile('mm', '\.mm',            '4',  'NONE', 'NONE', 'NONE')
call NERDTreeHighlightFile('m', '\.m',              '4',  'NONE', 'NONE', 'NONE')
" shell scripts
call NERDTreeHighlightFile('sh', '\.sh',            '2',  'NONE', 'NONE', 'NONE')
call NERDTreeHighlightFile('bash', '\.bash',        '2',  'NONE', 'NONE', 'NONE')
call NERDTreeHighlightFile('zsh', '\.zsh',          '2',  'NONE', 'NONE', 'NONE')
" makefiles
call NERDTreeHighlightFile('mk', '\.mk',            '28', 'NONE', 'NONE', 'NONE')
call NERDTreeHighlightFile('makefile', '\makefile', '28', 'NONE', 'NONE', 'NONE')
call NERDTreeHighlightFile('Makefile', '\Makefile', '28', 'NONE', 'NONE', 'NONE')
" JavaScript
call NERDTreeHighlightFile('js', '\.js',            '3',  'NONE', 'NONE', 'NONE')


" Never mess when file opened without sudo.
cmap w!! w !sudo tee % >/dev/null

" Use Tabs in Makefiles
autocmd FileType make setlocal noexpandtab


" Folding Config
nnoremap z( zj
nnoremap z) zk
augroup vimrc
    autocmd!

    " Set foldmethod indent AND manual
    autocmd BufReadPre * setlocal foldmethod=indent
    autocmd BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif

    " Open all folds at startup
    autocmd BufRead * normal zR
augroup END

augroup filetype_cs
    autocmd!

    " Set folding by syntax for C# (Unity) files
    autocmd FileType cs setlocal foldmethod=syntax
    autocmd FileType cs let b:match_words = '\s*#\s*region.*$:\s*#\s*endregion'

    " Close all folds
    autocmd BufRead *.cs normal zM
augroup END

" Set 80 column limit.
if exists('+colorcolumn')
  set colorcolumn=80
  highlight ColorColumn guibg=#004653

  " except for mail
  autocmd FileType mail set colorcolumn=72
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Airline Settings
set laststatus=2
let g:airline_highlighting_cache = 1
let g:airline_inactive_collapse = 1
let g:airline_extensions = ['whitespace']
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 0

" Setup Airline font
if has('gui_running')
    set guifont=Input:h9
    set lsp=0
endif
let g:airline_powerline_fonts = 1

" Easy Motion Settings
map <Leader> <Plug>(easymotion-prefix)
map <Leader>s <Plug>(easymotion-lineforward)
map <Leader>n <Plug>(easymotion-j)
map <Leader>r <Plug>(easymotion-k)
map <Leader>b <Plug>(easymotion-linebackward)
nmap e <Plug>(easymotion-s2)

let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" ag.vim Settings.
let g:ag_working_path_mode="r"

" vim-autoformat Settings.
if has_key(g:plugs, 'vim-autoformat')
    noremap <C-f> :Autoformat<CR>
    let g:formatdef_astyle_objc = '"astyle --mode=c"'
    let g:formatdef_jsbeautify = '"js-beautify -f -"'
    let g:formatters_objc = ['astyle_objc']
    let g:formatters_javascript = ['jsbeautify']
endif

if has_key(g:plugs, 'vim-uncrustify')
    function! GetUncrustifyCfg()
python3 <<EOF
    import vim
    import os

    file_name = ".uncrustify.cfg"
    cur_dir = os.getcwd()

    while True:
        file_list = os.listdir(cur_dir)
        parent_dir = os.path.dirname(cur_dir)
        if file_name in file_list:
            vim.command("let sUncPath = '%s'" % cur_dir)
            break
        else:
            if cur_dir == parent_dir:
                vim.command("let sUncPath = '%s'" % "__non__")
                break
            else:
                cur_dir = parent_dir

EOF

        if sUncPath ==# "__non__"
            return 0
        else
            let g:uncrustify_cfg_file_path = sUncPath . "/.uncrustify.cfg"
            return 1
        endif
    endfunction

    function! UncrustifyWrapper(lang)
        call GetUncrustifyCfg()
        return call Uncrustify(lang)
    endfunction
    function! RangeUncrustifyWrapper(lang)
        call GetUncrustifyCfg()
        return call RangeUncrustify(lang)
    endfunction

    autocmd FileType c noremap <buffer> <c-f> :call UncrustifyWrapper('c')<CR>
    autocmd FileType c vnoremap <buffer> <c-f> :call RangeUncrustifyWrapper('c')<CR>
    autocmd FileType cpp noremap <buffer> <c-f> :call UncrustifyWrapper('cpp')<CR>
    autocmd FileType cpp vnoremap <buffer> <c-f> :call RangeUncrustifyWrapper('cpp')<CR>
endif


" Strip trailing whitespace
fun! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

command! StripWhitespace call StripTrailingWhitespaces()

" Profiling
fun! ProfileStart()
:   profile start profile.log
:   profile func *
:   profile file *
endfun
command! ProfileStart call ProfileStart()

fun! ProfileEnd()
:   profile pause
:   noautocmd qall!
endfun
command! ProfileEnd call ProfileEnd()

" Minifier functions
fun! MinifyJson()
  %s/\ //g
  %s/\n//g
endfunction

command! JsonMinify call MinifyJson()

" Highlight whitespace
if version >= 704 && has('patch712')
    set listchars=tab:--,trail:~,extends:>,precedes:<,space:·
    set nolist

    " Highlight whitespace color config
    hi Conceal ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
endif

" vim-ftplugin config
let g:lua_compiler_name = '/usr/local/bin/luac'

" SuperTab config
imap <C-r> <Plug>SuperTabForward
imap <C-n> <Plug>SuperTabBackward
let g:SuperTabClosePreviewOnPopupClose = 1
let g:SuperTabCrMapping = 1

" au BufNewFile,BufRead,BufEnter *.c, *.h filetype plugin on
" au BufNewFile,BufRead,BufEnter *.c, *.h set omnifunc=syntaxcomplete#Complete

runtime! plugin/supertab.vim
inoremap <s-tab> <tab>

" YouCompleteMe
if ycm_enabled
    let g:ycm_key_list_select_completion  = ['<TAB>', '<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion  = ['<S-TAB>', '<C-r>', '<Up>']
    let g:ycm_key_list_stop_completion = ['<Enter>']
    let g:ycm_key_invoke_completion = '<C-Space>'
    let g:ycm_add_preview_to_completeopt = 0
    let g:ycm_error_symbol = 'E>'
    let g:ycm_warning_symbol = 'W>'
    let g:ycm_complete_in_comments = 1
    let g:ycm_min_num_of_chars_for_completion = 2
    let g:ycm_echo_current_diagnostic = 0
    set completeopt-=preview
endif

" vim-multiple-cursors Setup {{{
" function! Multiple_cursors_before()
"     if &ft =~ '\(cpp\|c\|python\)'
"         call youcompleteme#DisableCursorMovedAutocommands()
"     endif
" endfunction

" function! Multiple_cursors_after()
"     if &ft =~ '\(cpp\|c\|python\)'
"         call youcompleteme#EnableCursorMovedAutocommands()
"     endif
" endfunction
" }}}

" NumberToggle config
set relativenumber
let g:NumberToggleTrigger = "<C-o>"

" Fix JSON conceal level Yggdroot/indentLine#140
let g:vim_json_syntax_conceal = 0

" hexmanager
let g:hex_movetab = 0

" FastFold
let g:fastfold_fold_command_suffixes = []

" Vim Notes
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.txt'
let g:notes_smart_quotes = 0

" LeaderF
let g:Lf_ShortcutF = '<Leader>o'
nnoremap <Leader>o :LeaderfFile<CR>
nnoremap <Leader>b :LeaderfBuffer<CR>
nnoremap <Leader>z :LeaderfMruCwd<CR>
nnoremap <Leader>f :LeaderfBufTag<CR>
nnoremap <Leader>v :LeaderfTag<CR>
let g:Lf_ShowRelativePath = 0
let g:Lf_WindowHeight = 0.2
let g:Lf_StlSeparator = {
    \ 'left': '',
    \ 'right': ''
    \ }
let g:Lf_WildIgnore = {
    \ 'dir': ['.svn','.git','.p4','.perforce','.plastic','node_modules','temp','Temp','out','_out','_build'],
    \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.pyco','*.dll','*.meta','AssemblyU2DCSharp*']
    \ }
let g:Lf_CommandMap = {
    \ '<C-R>': ['<C-E>'],
    \ '<Down>': ['<C-N>'],
    \ '<Up>': ['<C-R>'],
    \ '<C-C>': ['<ESC>'],
    \ '<C-X>': ['<C-T>'],
    \ '<C-]>': ['<C-I>'],
    \ '<C-T>': ['<C-X>'],
    \ '<C-L>': ['<C-D>']
    \ }


" Shell command
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  execute '$read !'. expanded_cmdline
  execute 1 'delete _'
  setlocal nomodifiable
  1
endfunction

" Focus Mode
function! ToggleFocusMode()
  if (&foldcolumn != 12)
    set laststatus=0
    set numberwidth=10
    set foldcolumn=12
    set noruler
    hi FoldColumn ctermbg=none
    hi LineNr ctermfg=0 ctermbg=none
    hi NonText ctermfg=0
  else
    set laststatus=2
    set numberwidth=4
    set foldcolumn=0
    set ruler
    execute 'colorscheme ' . g:colors_name
  endif
endfunc
nnoremap <F1> :call ToggleFocusMode()<cr>

" Buffer Moving
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction

nnoremap <silent> <Leader>m :call MarkWindowSwap()<CR>
nnoremap <silent> <Leader>p :call DoWindowSwap()<CR>

" Vim Grep
nnoremap <Leader>ag :Grepper<CR>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
nmap g* gsiw
xmap g* gsiw
let g:grepper = {
    \ 'tools': ['ag1', 'git', 'grep'],
    \ 'ag1': {
    \   'grepprg': 'ag --vimgrep "$*"',
    \   'grepformat': '%f:%l:%c:%m,%f:%l:%m',
    \   'escape': '\^$.*+?()[]%# ',
    \ },
    \ 'open': 1,
    \ 'jump': 0,
    \ }

" Fix Grepper's quickfix window
augroup quickfix
    autocmd!
    autocmd FileType qf setlocal nowrap
    autocmd FileType qf setlocal norelativenumber
    autocmd FileType qf setlocal nonumber
    autocmd FileType qf set nobuflisted
    autocmd FileType qf nnoremap <buffer> q :cclose<CR>
augroup END

" Improve Quickfix through QFEnter
let g:qfenter_open_map = ['<CR>']
let g:qfenter_vopen_map = ['i']
let g:qfenter_hopen_map = ['t']
let g:qfenter_topen_map = ['<Tab>']
let g:qfenter_keep_quickfixfocus = {
            \ 'open': 0,
            \ 'cnext': 0,
            \ 'cprev': 0,
            \ }
nnoremap <Leader>qf :copen<CR>

" Quick if quickfix is last window
augroup QFClose
    autocmd!
    autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix" | q | endif
augroup END

" Generate CTags manually
function! GenerateTags()
:   w
:   exec '!ctags -R -f tags .'
endfunction
command! -nargs=* GenTagsManual call GenerateTags()

" Gutentags
set statusline+=%{gutentags#statusline('[Generating...]')}
function! GenTags()
:   w
:   GutentagsUpdate
:   redraw!
endfunction
function! GenTagsAll()
:   w
:   GutentagsUpdate!
:   redraw!
endfunction
command! -nargs=* GenTags call GenTags()
command! -nargs=* GenTagsAll call GenTagsAll()

let g:gutentags_project_root = [ '.git', '.p4project', '.plastic' ]
"let g:gutentags_ctags_exclude_wildignore = [ '*.meta' ]

" TagList
let g:Tlist_Inc_Winwidth=0
let g:Tlist_WinWidth=40
let g:Tlist_Use_Right_Window=1
let g:Tlist_Enable_Fold_Column=0
let g:Tlist_Compact_Format=1
let g:Tlist_Exit_OnlyWindow=1
let g:Tlist_GainFocus_On_ToggleOpen=1
let g:Tlist_File_Fold_Auto_Close=1
let g:Tlist_Process_File_Always=1
let g:tlist_c_settings = 'c;d:macro;f:function;g:enums;p:prototype;s:struct;t:typedef;x:external'
let g:tlist_cpp_settings = 'c++;d:macro;f:function;g:enums;p:prototype;s:struct;t:typedef;x:external'
autocmd FileType taglist set nonumber
autocmd FileType taglist set norelativenumber
autocmd FileType taglist nnoremap <buffer> <C-a> :TlistUpdate<CR>

" Show only current buffer?
" let g:Tlist_Show_One_File=1

" WankRing
" p for paste
" <C-P> maps to next paste
" <C-N> maps to previous paste
nnoremap <Leader>y :YRShow<CR>
let g:yankring_replace_n_pkey = '<C-H>'
let g:yankring_replace_n_nkey = '<C-L>'

" Set EnhancedJumps mappings
nmap <Leader>h  <Plug>EnhancedJumpsOlder
nmap <Leader>l  <Plug>EnhancedJumpsNewer
nmap <Leader>gh <Plug>EnhancedJumpsLocalOlder
nmap <Leader>gl <Plug>EnhancedJumpsLocalNewer

" MultipleCursor
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-g>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<C-g>'
nnoremap <silent> <C-j> :MultipleCursorsFind <C-R>/<CR>
vnoremap <silent> <C-j> :MultipleCursorsFind <C-R>/<CR>

" Vim Easy Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'guifgs': ['firebrick', 'seagreen3', 'darkorange3', 'yellow', 'magenta1'],
\   'ctermfgs': [9, 2, 4, 3, 5],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\   }
\}

" Close all buffers
function! CloseBuffers()
    let curr = bufnr("%")
    let last = bufnr("$")
    if curr > 1     | silent! execute "1,".(curr-1)."bd"        | endif
    if curr < last  | silent! execute (curr+1).",".last."bd"    | endif
endfunction
nmap <Leader>w :call CloseBuffers()<CR>

" Increment numbers in rows
function! Incr()
    let a = line('.') - line("'<")
    let c = virtcol("'<")
    if a > 0
        execute 'normal! '.c.'|'.a."\<C-a>"
    endif
    normal `<
endfunction
vnoremap <C-a> :call Incr()<CR>

" Change current working directory
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Uncrustify command
" function! Uncrustify()
" python3 <<EOF
" import vim
" import os

" file_name = ".uncrustify.cfg"
" cur_dir = os.getcwd()

" while True:
"     file_list = os.listdir(cur_dir)
"     parent_dir = os.path.dirname(cur_dir)
"     if file_name in file_list:
"         vim.command("let sPath = '%s'" % cur_dir)
"         break
"     else:
"         if cur_dir == parent_dir:
"             vim.command("let sPath = '%s'" % "__non__")
"             break
"         else:
"             cur_dir = parent_dir

" EOF

"     if sPath ==# "__non__"
"         return 0
"     else
"         let sPath = sPath . "/.uncrustify.cfg"
"         :w
"         :silent exec "!uncrustify -c ".sPath." --replace %"
"         :e!
"         return 1
"     endif
" endfunction
" command! -nargs=* Uncrustify call Uncrustify() | execute ':redraw!'

