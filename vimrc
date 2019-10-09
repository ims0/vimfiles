let mapleader = " "
let maplocalleader = " "

"Vundle{{{
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'Valloric/YouCompleteMe'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'suan/vim-instant-markdown'
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
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
:nnoremap  <localleader>in :PluginInstall    <cr>
:nnoremap  <localleader>li :PluginList      <cr>
"}}}


"YCMCFG{{{
""swith of symtax diagnost
let g:ycm_show_diagnostics_ui = 1
" ycm 指定 ycm_extra_conf.py
let g:ycm_global_ycm_extra_conf =  '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'

let g:ycm_collect_identifiers_from_tag_files = 1

"let g:ycm_seed_identifiers_with_syntax = 1 " 在接受补全后不分裂出一个窗口显示接受的项
set completeopt=preview
let g:ycm_autoclose_preview_window_after_completion = 1
" 让补全行为与一般的IDE一致 set completeopt=longest,menu " 不显示开启vim时检查ycm_extra_conf文件的信息
let g:ycm_confirm_extra_conf=0
" 每次重新生成匹配项，禁止缓存匹配项 let g:ycm_cache_omnifunc=0 " 在注释中也可以补全
let g:ycm_complete_in_comments=0
" 输入第一个字符就开始补全 let g:ycm_min_num_of_chars_for_completion=1 " 错误标识符
let g:ycm_error_symbol='>>'
" 警告标识符 let g:ycm_warning_symbol='>*' " 不查询ultisnips提供的代码模板补全，如果需要，设置成1即可
" let g:ycm_use_ultisnips_completer=0
let g:ycm_semantic_triggers = { 'c' : ['->', '.']}
"---------------------
"The g:ycm_key_list_select_completion option
"This option controls the key mappings used to select the first completion string. Invoking any of them repeatedly cycles forward through the completion list.


let g:ycm_key_list_select_completion = ['<Down>']

"}}}

"{{{ cscope setting
if has("cscope")
  set csprg=/usr/bin/cscope-C
  ""set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out 
  endif
  set csverb
endif

nnoremap  <localleader>a :cs add cscope.out<cr>
"}}}


if has("syntax")
syntax on
endif
set nocompatible "取消vi 兼容模式

"{{{ paste mode f6,f7
    :map <F6> :set paste<CR>
    :map <F7> :set nopaste<CR>
    :imap <F6> <C-O>:set paste<CR>
    :imap <F7> <nop>
    :set pastetoggle=<F6>
"}}}

"{{{ fold
""    set foldenable " 开始折叠
""    set foldmethod=syntax " 设置语法折叠
    set foldcolumn=0 " 设置折叠区域的宽度
    setlocal foldlevel=0 " 设置折叠层数
    "set foldopen=all     "光标到达折叠快时，自动打开
""    set foldclose=all    " 离开代码块后，自动折叠
    " 用空格键来开关折叠
""    nnoremap <space> zi

""    autocmd BufRead * :
"}}}
set mouse=v "可视模式
set mouse=a     " Enable mouse usage (all modes) 启用鼠标方便翻页，移动光标
set diffopt=filler,context:4
set showmatch           " Show matching brackets.
"set ignorecase     " Do case insensitive matching
"set smartcase      " Do smart case matching

set nobackup        "no backup
set autoread  " 设置当文件被改动时自动载入
set autowrite       " Automatically save before commands like :next and :make
set hidden      " Hide buffers when they are abandoned

set nu           "show line number
set ruler            "show cursor site in right below
set tabstop=4      " 统一缩进为4
set shiftwidth=4
set incsearch " 输入字符串就显示匹配点
set hlsearch " 高亮度搜寻
set autoindent    "自动缩进
set cindent

set completeopt=longest,menu
set completeopt=preview,menu "代码补全
"{{{start----- 自动补全  -----------------
    :inoremap ( ()<ESC>i
    :inoremap ) <c-r>=ClosePair(')')<CR>
    :inoremap { {<CR>}<ESC>O
    :inoremap } <c-r>=ClosePair('}')<CR>
    :inoremap [ []<ESC>i
    :inoremap ] <c-r>=ClosePair(']')<CR>
    :inoremap " ""<ESC>i
    :inoremap ' ''<ESC>i
    function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
       return "\<Right>"
    else
       return a:char
    endif
    endfunction
"}}} "end--------------------------------



"----- 打开文件类型检测-----------------
filetype plugin indent on

au BufNewFile,BufRead *.h set filetype=h
"start---------- definition  SetTitle() ------------------------------------

autocmd BufNewFile *.cpp,*.c,*.h,*.sh,*.java  exec ":call SetTitle()"
func! SetTitle()
    if &filetype == 'sh'
        call setline(1,"\#########################################################################")
        call append(line("."), "\# File Name: ".expand("%"))
        call append(line(".")+1, "\# Author: ims")
        call append(line(".")+2, "\# Created Time: ".strftime("%c"))
        call append(line(".")+3, "\#########################################################################")
        call append(line(".")+4, "\#!/bin/bash")
        call append(line(".")+5, "")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name: ".expand("%"))
        call append(line(".")+1, "    > Author: ims")
        call append(line(".")+2, "    > Created Time: ".strftime("%c"))
        call append(line(".")+3, " ************************************************************************/")
        call append(line(".")+4, "")
    endif

    if &filetype == 'cpp'
        call append(line(".")+5, "#include<iostream>")
        call append(line(".")+6, "using namespace std;")
        call append(line(".")+7, "")
        call append(line(".")+8, "int main()")
        call append(line(".")+9, "{")
        call append(line(".")+10, "\t")
        call append(line(".")+11, "\treturn 0;")
        call append(line(".")+12, "}")
    endif

    if &filetype == 'h'
        let tem= expand("%")
        let lens= strlen(tem)
        let substr = strpart(tem,0,lens-2)
        let headstr = toupper(substr).'_H'
        call append(line(".")+5, '#ifndef '.headstr)
        call append(line(".")+6, '#define '.headstr)
        call append(line(".")+7, "")
        call append(line(".")+8, " ")
        call append(line(".")+9, "#endif")
        set filetype=cpp
    endif

    if &filetype == 'c'
        call append(line(".")+5, "#include<stdio.h>")
        call append(line(".")+6, "")
        call append(line(".")+7, "")
        call append(line(".")+8, "int main()")
        call append(line(".")+9, "{")
        call append(line(".")+10, "\t")
        call append(line(".")+11, "\treturn 0;")
        call append(line(".")+12, "}")
    endif

    normal 12G"
endfunc
au  BufRead *.h set filetype=cpp

"end----------- SetTitle() --------------------------------

"show run result{{{
function! ExecProm()
    bufdo if expand("%")=="runResult" |bd runResult|endif
    exec "w"
    let headtitle = system("echo -e '------------compile result--------------'")
    let runResLine = system("echo -e '--------------run result----------------'")
    if &filetype == 'c'
        let compileResu = system('gcc '.expand('%').' -o '.expand('%<'))
        let runResu=headtitle.compileResu.runResLine .system('./'.expand('%<'))
        bot 9sp runResult
        setlocal buftype=nofile bufhidden=hide noswapfile
        1s/^/\=runResu/
        1
    endif
    if &filetype == 'cpp'
        let compileResu = system('g++ -std=c++11 '.expand('%').' -lpthread -o '.expand('%<'))
        let runResu=headtitle.compileResu.runResLine .system('./'.expand('%<'))
        bot 9sp runResult
        setlocal buftype=nofile bufhidden=hide noswapfile
        1s/^/\=runResu/
    endif
    if &filetype == 'python'
        let runResu=runResLine .system('python3 '.expand('%'))
        bot 9sp runResult
        setlocal buftype=nofile bufhidden=hide noswapfile
        1s/^/\=runResu/
    endif
    if &filetype == 'sh'
        let runResu=runResLine .system('sh '.expand('%'))
        bot 9sp runResult
        setlocal buftype=nofile bufhidden=hide noswapfile
        1s/^/\=runResu/
    endif

endfunction
nnoremap  <localleader>ll :call ExecProm()<cr>
"}}}

autocmd BufNewFile,BufRead,BufWrite * :syntax match operators "\<compile result\>"
autocmd BufNewFile,BufRead,BufWrite * :syntax match operators "\<run result\>"
hi operators ctermfg = DarkCyan



"{{{ CtrlP Settings
    " two setting can prevent change of ctrlp_working_path
    set noautochdir
    let g:ctrlp_working_path_mode = 0
"}}}

"{{{ map ctags,srcExpl,NerdTree:F8,F9,F10,F12
    " Open and close the taglist.vim separately
    nnoremap <F9>  :TrinityToggleTagList<CR>
    " Open and close the srcexpl.vim separately
    nnoremap <F10> :TrinityToggleSourceExplorer<CR>
    " Open and close the NERD_tree.vim separately
    nnoremap <F12>  :TrinityToggleNERDTree<CR>
    " Open and close all the three plugins on the same time
    "nnoremap <F12> :TrinityToggleAll<CR>
"}}}
"NERDtree{{{
    " 改变nerdtree的箭头
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
    "adDTreeShowHidden=1
    " 设置宽度
    let NERDTreeWinSize=30
    " 在终端启动vim时，共享NERDTree
    let g:nerdtree_tabs_open_on_console_startup=1
    " 忽略一下文件的显示
    let NERDTreeIgnore=['\.pyc','\~$','\.swp','\.a','\.o']
    " 显示书签列表
    "let NERDTreeShowBookmarks=1
"}}}
"Sys clipboard{
vnoremap  y    "+y 
vnoremap  p    "+p
"}

"termdebug{{{
function! TermdebugAdd()
    exe "packadd termdebug"
    :Termdebug 
endfunction
nnoremap  <localleader>d :call TermdebugAdd()<cr>
"}}}
"
""gdb {{{
function! Iconv()
    let s=system('iconv -f gbk -t utf-8 '.expand('%').' -o '.expand('%'))
endfunction
nnoremap  <localleader>gbk :call Iconv()<cr>
"}}}
"
"run shell{
function! RunShell()
    :set noautochdir<cr>
    :!sh %
endfunction
nnoremap  <localleader>r :call RunShell()<cr>
"}

"Update Cscope{
function! UpdateCscope()
    :echo system('sh bcsu')
    3sleep
    let i = 1
    while i < 20
        if filereadable("cscope.out")
            cs reset
            break
        endif
        1sleep
    endwhile
endfunction
nnoremap  <unique><localleader>u :call UpdateCscope()<cr>
"}


"my shortcut key{{{
"map reg 9"
    :nnoremap  <localleader>9  bve"9y
    :nnoremap  <localleader>99  bdw"9[p
    :vnoremap  <localleader>1  "1y
    :vnoremap  <localleader>=  ggvG=

    :nnoremap  qa :qa<cr>
    :nnoremap  <c-s>  :update<cr>:%s/\t/    /g<cr>
    :inoremap  <c-s>  <esc>:update<cr>
    :nnoremap  <localleader>q :q<cr>
    :nnoremap  <localleader>qq :q!<cr>
    :nnoremap  <localleader>wq :wq<cr>
    :nnoremap  <localleader>wa :wa<cr>
    :nnoremap  <localleader>qa :qa<cr>
    :nnoremap  <localleader>s  :%s/
    :nnoremap  <Leader>b :<C-u>call gitblame#echo()<CR> 
    :nnoremap  <localleader>sw  :%s/<c-r><c-w>/
    :nnoremap  <localleader>sh  :bot term ++rows=8 bash<cr>
    :nnoremap  <localleader>sc :ConqueTerm bash<cr>
    :nnoremap  <localleader>shs :ConqueTermSplit bash<cr>
    :nnoremap  <localleader>shv :ConqueTermVSplit bash<cr>
    :nnoremap  <localleader>sht :ConqueTermTab bash<cr>
    :nnoremap  <localleader>t :%s/\t/    /g<cr>
    :nnoremap  <localleader><Space> :%s/ *$//g<cr>
    
    :nnoremap  <localleader>y  byw
    :nnoremap  <localleader>yy "+yy<cr>
    :nnoremap  <localleader>yw "+yw<cr>
    :nnoremap  <localleader>/ :/\<\>
    :nnoremap  <localleader>? :?\<\>
    :inoremap <c-d> <esc>ddo
    :nnoremap <localleader>ev :vsplit$MYVIMRC<cr>
    :nnoremap <localleader>ms :vsplit $VIMRUNTIME/colors/imscolo.vim<cr>
    :nnoremap <localleader>sv :source$MYVIMRC<cr>
    :inoremap jk <esc>
    :nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
    :nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
    :nnoremap <leader>\ : , s/^/\/\//g
    :autocmd FileType cpp nnoremap <buffer> <localleader>/ I//<esc>
    :autocmd FileType c nnoremap <buffer> <localleader>/ I//<esc>
"}}}
"reset win size {{{ 
    vnoremap , <c-w>3< 
    vnoremap . <c-w>3> 
"}}}

"{{{ cscope cs find
    :nnoremap  <c-@> :cs f 
    :nnoremap  <localleader>2c byw:cs f c <c-r>0
    :nnoremap  <localleader>2s byw:cs f s <c-r>0
    :nnoremap  <localleader>2t byw:cs f t <c-r>0
    :nnoremap  <localleader>2g byw:cs f g <c-r>0
    :nnoremap  <localleader>2f byw:cs f f <c-r>0
    :nnoremap  <localleader>2i byw:cs f i <c-r>0
    ""ctrl+g 调用*
    :nnoremap  <localleader>g  :cs f s  <c-r>*<cr>
"}}}

"{{{ format text
    nnoremap > V>
    nnoremap <s-tab> V<
    vnoremap > >gv
    vnoremap <s-tab> <gv
"}}}

"sdvc{{{
set keywordprg=sdcv\ -u\ 朗道英汉字典5.0
function! Mydict()
    let retstr=system('sdcv '.expand("<cword>"))
    windo if expand("%")=="dict-win" |q!|endif
    30vsp dict-win
    setlocal buftype=nofile bufhidden=hide noswapfile
    1s/^/\=retstr/
    1
endfunction
nnoremap F :call Mydict()<CR>
"use sdcv instead man
set keywordprg=sdcv
"}}}
"
"sys ls{{{
function! Sysls()
    let retstr=system('ls')
    bufdo if expand("%")=="_sys_ls" |bd _sys_ls|endif
    30vsp _sys_ls
    setlocal buftype=nofile bufhidden=hide noswapfile
    1s/^/\=retstr/
    1
endfunction
    :nnoremap  <localleader>ls :call Sysls()<cr>
"}}}

"{{{ minibufexplore settings
    let g:miniBufExplMapWindowNavVim = 1
    let g:miniBufExplMapWindowNavArrows = 2
    let g:miniBufExplMapCTabSwitchBufs = 1
    let g:miniBufExplModSelTarget = 1
    let g:bufExplorerMaxHeight=3
    ""let g:miniBufExplUseSingleClick = 1
"}}}

"{{{ Colors Settings
    colorscheme imscolo
    set guifont=Consolas:h13:cANSI
"}}}

let g:indentLine_color_term = 24
set clipboard+=unnamedplus
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = 1

"当前文件名
nnoremap yf : let @f=expand("%:t")<CR>
nnoremap yp : let @p=expand("%:p")<CR>

set laststatus=2
"bot ter bash
"命令行文件路径补全
set wildmode=list:longest
"diff setting{{{
set diffopt=vertical,context:4
nnoremap  <localleader>df :bufdo diffs<cr>
"}}}




""augroup update_cscope
""    autocmd!
""    autocmd BufWrite * :
""augroup END
set noswapfile
