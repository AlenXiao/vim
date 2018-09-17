set autochdir
set autoindent

"autocmd BufEnter * :syntax sync fromstart
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"set wrap
"---------------
" set for ctags
set tags=./tags;/,~/.vimtags
"---------------
" set for cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-
nmap <C-n> :cnext<CR>
nmap <C-p> :cprev<CR>
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
"    set csverb
    set cspc=3
    "add any database in current dir
    if filereadable("cscope.out")
        cs add cscope.out
    "else search cscope.out elsewhere
    else
        let cscope_file=findfile("cscope.out", ".;")
        let cscope_pre=matchstr(cscope_file, ".*/")
        if !empty(cscope_file) && filereadable(cscope_file)
            exe "cs add" cscope_file cscope_pre
        endif
    endif
endif
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"--------------
set nu
" 把空格键映射成:
nmap <space> :

" Use vim features - ignore vi compatibility
set nocompatible    " 关闭兼容模式
syntax enable       " 语法高亮
filetype plugin on  " 文件类型插件
filetype indent on
set whichwrap+=<,>,h,l " 退格键和方向键可以换行

" Make sure vim checks for 'set commands' in opened files
set modeline
set modelines=1

" Make the window title reflect the file being edited
set title
set titlestring=VIM:\ %F

" At command line, complete longest common string, then list alternatives.
set wildmode=longest,list

" Automatically insert the current comment leader
" after hitting 'o' or 'O' in Normal mode.
set fo+=o

" Do not automatically insert a comment leader after an enter
set fo-=r

" Do no auto-wrap text using textwidth (does not apply to comments)
set fo-=t

" Turn off the bell
set vb t_vb=

" Enable the mouse
"set mouse=v
"set mouse+=n
"set mouse+=c
"behave xterm
"set selectmode=
"set mouse=a      " 在所有模式下都允许使用鼠标，还可以是n,v,i,c等
set mouse+=v

" 状态栏
set laststatus=2      " 总是显示状态栏
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
" 获取当前路径，将$HOME转化为~
function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction
set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\

" 判断是终端还是gvim
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif
"在gvim中高亮当前行
if (g:isGUI)
    set cursorline
    hi cursorline guibg=#333333
    hi CursorColumn guibg=#333333
    set guifont=Consolas\ 14
    set guifontwide=Consolas\ 14
endif

" Set list Chars - for showing characters that are not
" normally displayed i.e. whitespace, tabs, EOL
set listchars=trail:.,tab:>-,eol:$
set nolist

" Show incomplete paragraphs
"set display+=lastline

" Turn ruler on
set ruler

" Set horizontal scrolling jump to 10
set sidescroll=10

" Turn off end of line wrapping
set nowrap

" Make sure status line is always visible
set laststatus=2

" Make command line two lines high
set ch=2

" Make the Tab spacing 3 characters wide
"set ts=4

" tab转化为4个字符
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
" Make the shift width 3 characters wide
"set sw=4

" Allow backspace to delete
set bs=2

set history=400  " vim记住的历史操作的数量，默认的是20
set autoread     " 当文件在外部被修改时，自动重新读取


" Make window height VERY large so they always maximise on window switch
set winheight=9999

" Switch off search pattern highlighting.
"set nohlsearch
set incsearch       " 增量式搜索
set hlsearch        " 高亮搜索

" Turn Brace/Bracket match showing off
"set noshowmatch
set showmatch

" Setup backup location and enable
"set backupdir=~/backup/vim
"set backup
set nobackup
set nowb

set ai              " 自动缩进
set si              " 智能缩进
set cindent         " C/C++风格缩进
set wildmenu        
set nofen
set fdl=10
" Set Swap directory

" Show/Hide hidden Chars
map <silent> <F2> :set invlist<CR>

" Show/Hide found pattern (After search)
map <silent> <F3> :set invhlsearch<CR>

" Remove whitespace from end of lines
map <silent> <F4> :%s/\s\+$//g<CR>

" Make F5 reload .vimrc
map <silent> <F5> :source ~/.vimrc<CR>

" Do a word count
map <silent> <F7> g<C-G>

" Format paragraph
map <silent> <F8> gwap

" Set html creation to use style sheets
let html_use_css = 1

" Mapping for creating HTML of current buffer
map <silent> <F9> :runtime! syntax/2html.vim<CR>

" Set up Printer options
set printoptions=left:15mm,right:15mm,top:15mm,bottom:15mm,paper:A4,header:2,syntax:n
set printfont=courier_new:h7

" Set Printer up
set printexpr=PrintFile(v:fname_in)

if !exists("*PrintFile")
   function PrintFile(fname)
      call system("lpr -r -PLaserjet " . a:fname)
      return v:shell_error
endfunc
endif

" Enable 'in-column' up and down motion in INSERT mode on wrapped lines
imap <silent> <Up>   <C-o>gk
imap <silent> <Down> <C-o>gj

" Enable 'in-column' up and down motion on wrapped lines
map <silent> <Up>   gk
map <silent> <Down> gj

" Map shift up and down to page scrolling
map <S-Up>   <C-E>
map <S-Down> <C-Y>

" Folding options
set foldmethod=marker
set foldcolumn=2
set foldtext=MyFoldText()

if !exists("*MyFoldText")
   function MyFoldText()
      let line = getline(v:foldstart)
      let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
      return "FOLD (" . (v:foldend - v:foldstart) . ")" . sub
   endfunction
" /* }}} - End folding on this function declaration */
endif

" Switch on syntax highlighting.
syntax on

" color scheme
"colorscheme elflord
"colorscheme darkblue 
"colorscheme evening 
"colorscheme murphy 
"colorscheme torte
"colorscheme desert
"colorscheme default
"colorscheme blue
"colorscheme koehler
"colorscheme peachpuff
colorscheme ron
"colorscheme slate
"colorscheme zellner
"colorscheme delek
"colorscheme industry
"colorscheme morning
"colorscheme pablo
"colorscheme shine

" Use colours that work well on a dark background
"set background=dark

" Set some nice highlighting colours
hi Normal      guifg=white    guibg=black
hi Comment     ctermfg=brown
hi Folded      ctermfg=red
hi FoldColumn  ctermbg=grey   ctermfg=red
hi NonText     ctermbg=black  ctermfg=blue
hi SpecialKey  ctermbg=black  ctermfg=grey
hi Search      ctermbg=red    ctermfg=white
hi Todo        ctermbg=yellow ctermfg=white
"hi CRepeat     Ctermbg=white    ctermfg=red
"hi cConditional Ctermbg=white		ctermfg=red

