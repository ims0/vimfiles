let maplocalleader = " "
set nocompatible

"Vundle{{{
"Set up Vundle:
"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/cscope.vim'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'mbbill/code_complete'
Plugin 'tpope/vim-fugitive'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'godlygeek/tabular'
Plugin 'zivyangll/git-blame.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
nnoremap  <localleader>in :PluginInstall    <cr>
nnoremap  <localleader>li :PluginList      <cr>
"}}}
"YcmCfg{{{
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
"This option controls the key mappings used to select the first completion string. 
"Invoking any of them repeatedly cycles forward through the completion list.

let g:ycm_key_list_select_completion = ['<Down>']
"}}}

"cscope setting{{{ 
if has("cscope")
    set csprg=cscope
    set cscopetag
    set nocscopeverbose
    if filereadable("cscope.out")
        cs add cscope.out ./ -C
    endif
    set cscopeverbose
endif
"{{{ cscope cs find
    :nnoremap  <c-@> :cs f  
    :nnoremap  <localleader>2c :cs find s <C-R>=expand("<cword>")<CR><CR>
    :nnoremap  <localleader>2s :cs find s <C-R>=expand("<cword>")<CR><CR>
    :nnoremap  <localleader>2t :cs find s <C-R>=expand("<cword>")<CR><CR>
    :nnoremap  <localleader>2g :cs find s <C-R>=expand("<cword>")<CR><CR>
    :nnoremap  <localleader>2f :cs find s <C-R>=expand("<cfile>")<CR><CR>
    :nnoremap  <localleader>2i :cs find s <C-R>=expand("<cfile>")<CR><CR>
    ""ctrl+g 调用*
    :nnoremap  <localleader>g  :cs f s  <c-r>*<cr>
"}}}
"}}}

if filereadable(glob("$VIMRUNTIME/colors/imscolo.vim"))
    nnoremap <localleader>ms :vsplit $VIMRUNTIME/colors/imscolo.vim<cr>
    colorscheme imscolo
endif

if has("syntax")
    syntax on
endif

"paste mode{{{
    :map <F6> :set paste<CR>
    :map <F7> :set nopaste<CR>
    :imap <F6> <C-O>:set paste<CR>
    :imap <F7> <nop>
    :set pastetoggle=<F6>
"}}}

"fold{{{ 
    set foldcolumn=0
    setlocal foldlevel=0
"}}}
set mouse=a     " Enable mouse usage (all modes)
"diff setting{{{
set diffopt=vertical,context:4
nnoremap  <localleader>df :bufdo diffs<cr>
"}}}

set showmatch           " Show matching brackets.
"set ignorecase     " Do case insensitive matching
"set smartcase      " Do smart case matching

set t_Co=256 "number of colors"
set noswapfile
set nobackup        "no backup
set autoread 
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned

set number
set ruler           "show cursor site in right below
set tabstop=4      
set shiftwidth=4
set incsearch       " The screen will be updated often,with typing pattern
set hlsearch        " highlight all its matches.
set autoindent 
set cindent
set completeopt=longest,menu
set wildmode=list:longest "命令行文件路径补全


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

au BufNewFile,BufRead *.h set filetype=h

autocmd BufNewFile *.cpp,*.c,*.h,*.sh,  exec ":call SetTitle()"
func! SetTitle()
    if &filetype == 'sh'
        call setline(1,          "\##########################################################")
        call append(line("."),   "\# File Name: ".expand("%"))
        call append(line(".")+1, "\# Author: ims")
        call append(line(".")+2, "\# Created Time: ".strftime("%c"))
        call append(line(".")+3, "\##########################################################")
        call append(line(".")+4, "\#!/bin/bash")
        call append(line(".")+5, "")
    else
        call setline(1,          "/*********************************************************")
        call append(line("."),   "    > File Name: ".expand("%"))
        call append(line(".")+1, "    > Author: ims")
        call append(line(".")+2, "    > Created Time: ".strftime("%c"))
        call append(line(".")+3, " *********************************************************/")
        call append(line(".")+4, "")
    endif

    if &filetype == 'c'
        call append(line(".")+5, "#include<stdio.h>")
        call append(line(".")+6, "#include<string.h>")
        call append(line(".")+7, "")
    endif

    if &filetype == 'cpp'
        call append(line(".")+5, "#include<iostream>")
        call append(line(".")+6, "using namespace std;")
        call append(line(".")+7, "")
    endif

    if &filetype == 'cpp' || &filetype == 'c'
        call append(line(".")+8, "int main()")
        call append(line(".")+9, "{")
        call append(line(".")+10, "\t")
        call append(line(".")+11, "\treturn 0;")
        call append(line(".")+12, "}")
    endif
    if &filetype == 'h'
        let fileName = strpart(expand("%"),0,strlen(expand("%"))-2)
        let headFileMacro = toupper(fileName).'_H'
        call append(line(".")+5, '#ifndef '.headFileMacro)
        call append(line(".")+6, '#define '.headFileMacro)
        call append(line(".")+7, "")
        call append(line(".")+8, " ")
        call append(line(".")+9, "#endif")
        set filetype=cpp
    endif

    normal 12G"
endfunc
autocmd BufRead *.h set filetype=cpp


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
        1
    endif
    if &filetype == 'python'
        let runResu=runResLine .system('python3 '.expand('%'))
        bot 9sp runResult
        setlocal buftype=nofile bufhidden=hide noswapfile
        1s/^/\=runResu/
        1
    endif
    if &filetype == 'sh'
        let runResu=runResLine .system('sh '.expand('%'))
        bot 9sp runResult
        setlocal buftype=nofile bufhidden=hide noswapfile
        1s/^/\=runResu/
        1
    endif

endfunction
nnoremap  <localleader>ll :call ExecProm()<cr>
autocmd BufNewFile,BufWrite * :syntax match operators "\<compile result\>"
autocmd BufNewFile,BufWrite * :syntax match operators "\<run result\>"
hi operators ctermfg = DarkCyan
"}}}

"exit run shell for long time{
function! RunShell()
    :set noautochdir<cr>
    :!sh %
endfunction
nnoremap  <localleader>r :call RunShell()<cr>
"}


"{{{ map ctags,srcExpl,NerdTree:F9,F10,F12
    " Open and close the taglist.vim separately
    nnoremap <F9>  :TrinityToggleTagList<CR>
    " Open and close the srcexpl.vim separately
    nnoremap <F10> :TrinityToggleSourceExplorer<CR>
    " Open and close the NERD_tree.vim separately
    nnoremap <F12>  :TrinityToggleNERDTree<CR>
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
"map sys clipboard{
if has("clipboard")
    vnoremap  y    "+y 
    vnoremap  p    "+p
endif
"}
"
nnoremap yf : let @f=expand("%:t")<CR>
nnoremap yp : let @p=expand("%:p")<CR>
set clipboard+=unnamedplus
"term debug{{{
function! TermdebugAdd()
    exe "packadd termdebug"
    :Termdebug 
endfunction
nnoremap  <localleader>d :call TermdebugAdd()<cr>
"}}}
"
"iconv{{{
function! Iconv()
    let s=system('iconv -f gbk -t utf-8 '.expand('%').' -o '.expand('%'))
endfunction
nnoremap  <localleader>gbk :call Iconv()<cr>
"}}}
"



"my shortcut key{{{
"map reg 9"
nnoremap  <localleader>9  bve"9y
nnoremap  <localleader>99  bdw"9[p
vnoremap  <localleader>1  "1y
vnoremap  <localleader>=  ggvG=

nnoremap  qa :qa<cr>
nnoremap  <c-s>  :update<cr>:%s/\t/    /g<cr>
inoremap  <c-s>  <esc>:update<cr>
nnoremap  <localleader>q :q<cr>
nnoremap  <localleader>qq :q!<cr>
nnoremap  <localleader>wq :wq<cr>
nnoremap  <localleader>wa :wa<cr>
nnoremap  <localleader>qa :qa<cr>
nnoremap  <localleader>s  :%s/
nnoremap  <localleader>b :<C-u>call gitblame#echo()<CR> 
nnoremap  <localleader>sw  :%s/<c-r><c-w>/
nnoremap  <localleader>sh  :bot term ++rows=8 bash<cr>
nnoremap  <localleader>t :%s/\t/    /g<cr>
nnoremap  <localleader><Space> :%s/ *$//g<cr>

nnoremap  <localleader>y  byw
nnoremap  <localleader>yy "+yy<cr>
nnoremap  <localleader>yw "+yw<cr>
nnoremap  <localleader>/ :/\<\>
nnoremap  <localleader>? :?\<\>
inoremap <c-d> <esc>ddo
nnoremap <localleader>ev :vsplit$MYVIMRC<cr>
nnoremap <localleader>sv :source$MYVIMRC<cr>
inoremap jk <esc>
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader>\ : , s/^/\/\//g
autocmd FileType cpp nnoremap <buffer> <localleader>/ I//<esc>
autocmd FileType c nnoremap <buffer> <localleader>/ I//<esc>
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

func! Handler(channel, msg)
    echo a:msg
endfunc

func! RefreshCscope()
    call job_start([ './buildcs.sh'], {'callback': 'Handler'})
endfunc

nnoremap <F3> :call RefreshCscope()<cr>
nnoremap <localleader>e :!echo <c-r>"

set laststatus=2
