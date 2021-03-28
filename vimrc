:if version >100
let maplocalleader = " "
set nocompatible
let g:vundle_default_github_url="github.com.cnpmjs.org"
"Vundle{{{
"Set up Vundle:
"git clone https://github.com/ims0/Vundle.vim.git ~/.vim/bundle/Vundle.vim
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'ims0/Vundle.vim'
Plugin 'Yggdroot/LeaderF'
Plugin 'vim-scripts/cscope.vim'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'mbbill/code_complete'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'inkarkat/vim-ingo-library'
Plugin 'inkarkat/vim-mark'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
"{lua
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-lua-ftplugin'
Plugin 'vim-scripts/luainspect.vim'
"}
Plugin 'Valloric/YouCompleteMe'
"Plugin 'mattn/emmet-vim'

call vundle#end()            " required
filetype plugin indent on    " required
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
nnoremap  <localleader>in :PluginInstall    <cr>
nnoremap  <localleader>li :PluginList      <cr>
"}}}

"sysdiff"{
""let sys_type = system("uname")
""if sys_type =~? "Darwin*"
""endif
if has("clipboard")
    if has("macunix")
        nnoremap  yy "*yy
        nnoremap  yw "*yw
        nnoremap  yf :let @*=expand("%:t")<CR>
        nnoremap  yp :let @*=expand("%:p")<CR>
        vnoremap  y  "*y
        vnoremap  p  "*p
    elseif has('unix')
        nnoremap  yy "+yy
        nnoremap  yw "+yw
        nnoremap  yf :let @+=expand("%:t")<CR>
        nnoremap  yp :let @+=expand("%:p")<CR>
        vnoremap  y  "+y
        vnoremap  p  "+p
    endif
endif
"}"

"my shortcut key{{{
inoremap  jk <esc>
nnoremap  <c-s>  :update<cr>:%s/\t/    /g<cr>
inoremap  <c-s>  <esc>:update<cr>:%s/\t/    /g<cr>
vnoremap  <c-s>  <esc>:update<cr>:%s/\t/    /g<cr>
nnoremap  <localleader>q  :q<cr>
nnoremap  <localleader>qq :q!<cr>
nnoremap  <localleader>wq :wq<cr>
nnoremap  <localleader>wa :wa<cr>
nnoremap  <localleader>qa :qa<cr>
nnoremap  <localleader>s  :%s/
nnoremap  <localleader>sw :%s/<c-r><c-w>/
nnoremap  <localleader><Space> :%s/ *$//g<cr>
nnoremap  <localleader>sh  :bot term ++rows=8 bash<cr>
nnoremap  <localleader>b :<C-u>call gitblame#echo()<CR>
nnoremap  <localleader>y  byw
nnoremap  <localleader>/ :/\<\>
nnoremap  <localleader>? :?\<\>
nnoremap  <localleader>ev :vsplit$MYVIMRC<cr>
nnoremap  <localleader>sv :source$MYVIMRC<cr>
nnoremap  <localleader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap  <localleader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap  <localleader>e :!echo <c-r>"
nnoremap  <localleader>*  bi*<esc>ea*<esc>
autocmd FileType cpp nnoremap <buffer> <localleader>/ I//<esc>
autocmd FileType c nnoremap <buffer> <localleader>/ I//<esc>
autocmd FileType sh nnoremap <buffer> <localleader>/ I#<esc>
"}}}
"设置切换Buffer快捷键"
nnoremap <C-left> :bp<CR>
nnoremap <C-right> :bn<CR>
"选择当前行，不包含前置空格"
nnoremap vv ^vg_

function! Leader_r()
    if &filetype == 'sh'
        :set noautochdir<cr>
        :!bash %
    elseif &filetype == 'vim'
        :%y"
        :@"
    else
        Leaderf rg 
    endif
endfunction

nnoremap  <localleader>r :call Leader_r()<cr>

"LeaderF cfg"{
nnoremap  <localleader>f :LeaderfFile<cr>
nnoremap  <localleader>bu :LeaderfBuffer<cr>
let g:Lf_WildIgnore = {
        \ 'dir': ['.svn','.git','CMakeFiles','tools'],
        \ 'file': ['*.sw?','~$*','*.ba*','*.exe','*.o','*.a','*.so','*.py[co]']
        \}
"}
"Ycm Config{
" install
" git clone https://github.com/ycm-core/YouCompleteMe.git  ~/.vim/bundle/
" 初始化本地配置文件
" git submodule init
" 检出父仓库列出的commit
" git submodule update



let g:ycm_show_diagnostics_ui = 1  "switch of symtax diagnostic
"default close ycm hover
let g:ycm_auto_hover = "" 
"manually trigger ycm hover
nmap <localleader>y <plug>(YCMHover)
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_collect_identifiers_from_tag_files = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf=0
let g:ycm_complete_in_comments=0
let g:ycm_error_symbol='>>'
let g:ycm_semantic_triggers = { 'c' : ['->', '.']}
let g:ycm_key_list_select_completion = ['<Down>']
set completeopt=preview
"YcmCompleter cmd
"https://github.com/ycm-core/YouCompleteMe#goto-commands"
nnoremap  gf :YcmCompleter GoToDefinitionElseDeclaration<cr>
nnoremap  <localleader>dc :YcmCompleter GoToDeclaration<cr>
nnoremap  <localleader>df :YcmCompleter GoToDefinition<cr>
nnoremap  <localleader>go :YcmCompleter GoTo<cr>
nnoremap  <localleader>gp :YcmCompleter GetParent<cr>
nnoremap  <localleader>ix :YcmCompleter FixIt<cr>
nnoremap  <localleader>= :YcmC Format<cr>
vnoremap  <localleader>=  ggvG=
"}
"NERDtree{
    nnoremap  <localleader>nf :NERDTreeFind<cr>
    " 改变nerdtree的箭头
    ""let g:NERDTreeDirArrowExpandable = '▸'
    ""let g:NERDTreeDirArrowCollapsible = '▾'
    " 设置宽度
    let NERDTreeWinSize=30
    " 在终端启动vim时，共享NERDTree
    let g:nerdtree_tabs_open_on_console_startup=1
    " 忽略文件
    let NERDTreeIgnore=['\.pyc','\~$','\.swp']
    " 显示书签列表
    let NERDTreeShowBookmarks=1
"}

"cscope setting{
if has("cscope")
    set csprg=cscope
    set cscopetag
    set nocscopeverbose
    if filereadable("cscope.out")
        cs add cscope.out ./ -C
    endif
    set cscopeverbose
    "The default value is "" (don't use quickfix anyway)
    set cscopequickfix=""
    nnoremap  <c-@> :cs f 
    nnoremap  <localleader>2c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nnoremap  <localleader>2s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nnoremap  <localleader>2t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nnoremap  <localleader>2g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nnoremap  <localleader>2f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nnoremap  <localleader>2i :cs find i <C-R>=expand("<cfile>")<CR><CR>
endif
"}


"设置文件的代码形式
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,cp936

if has("gui_running")
    "vim的菜单乱码解决：
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    "vim提示信息乱码的解决
    language messages zh_CN.utf-8
    set guioptions-=T
    set guioptions-=m
    set guioptions-=L
    set guioptions-=r
    set guioptions-=b
    if filereadable(glob("$VIMRUNTIME/colors/Tomorrow-Night.vim"))
        nnoremap <localleader>ms :vsplit $VIMRUNTIME/colors/Tomorrow-Night.vim<cr>
        set guifont=Consolas:h13:cANSI
        colorscheme Tomorrow-Night
    endif
else
    if filereadable(glob("$VIMRUNTIME/colors/imscolo.vim"))
        nnoremap <localleader>ms :vsplit $VIMRUNTIME/colors/imscolo.vim<cr>
        colorscheme imscolo
    endif
endif

if has("syntax")
    syntax on
endif

"paste mode{
    :map <F6> :set paste<CR>
    :map <F7> :set nopaste<CR>
    :imap <F6> <C-O>:set paste<CR>
    :imap <F7> <nop>
    :set pastetoggle=<F6>
"}

"fold{
    set foldcolumn=0
    setlocal foldlevel=0
"}
"diff setting{
set diffopt=vertical,context:4
nnoremap  <localleader>df :bufdo diffthis<cr>
"}

set showmatch           " Show matching brackets.
"set ignorecase     " Do case insensitive matching
"set smartcase      " Do smart case matching
set mouse=a
set t_Co=256        "number of colors"
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
set wildmode=list:longest
set laststatus=2

"{
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
       return "\<Right>"
    else
       return a:char
    endif
endfunction

inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { {}<ESC>i
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
"}



"{{{ map ctags,srcExpl,NerdTree:F9,F10,F12
    " Open and close the taglist.vim separately
    nnoremap <F9>  :TrinityToggleTagList<CR>
    " Open and close the srcexpl.vim separately
    nnoremap <F10> :TrinityToggleSourceExplorer<CR>
    " Open and close the NERD_tree.vim separately
    nnoremap <F12>  :TrinityToggleNERDTree<CR>
"}}}

"
"term gdb debug{
function! TermdebugAdd()
    exe "packadd termdebug"
    :Termdebug
endfunction
nnoremap  <localleader>d :call TermdebugAdd()<cr>
"}

"{
    nnoremap > V>
    nnoremap <s-tab> V<
    vnoremap > >gv
    vnoremap <s-tab> <gv
"}

"minibufexplore settings{
    let g:miniBufExplMapWindowNavVim = 1
    let g:miniBufExplMapWindowNavArrows = 2
    let g:miniBufExplMapCTabSwitchBufs = 1
    let g:miniBufExplModSelTarget = 1
    let g:bufExplorerMaxHeight=3
    ""let g:miniBufExplUseSingleClick = 1
"}
"sdvc{
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
"}
"
"sys ls{
function! Sysls()
    let retstr=system('ls')
    bufdo if expand("%")=="_sys_ls" |bd _sys_ls|endif
    30vsp _sys_ls
    setlocal buftype=nofile bufhidden=hide noswapfile
    1s/^/\=retstr/
    1
endfunction
    :nnoremap  <localleader>ls :call Sysls()<cr>
"}

"create job{
func! BuildcsEcho(channel, msg)
    echo a:msg
endfunc

func! RefreshCscope()
    call job_start([ './buildcs.sh'], {'callback': 'BuildcsEcho'})
endfunc
nnoremap <F3> :call RefreshCscope()<cr>
"}

"show run result{
function! ExecProm()
    bufdo if expand("%")=="runResult" |bd runResult|endif
    exec "w"
    let headtitle  = system("echo -e '------------compile result--------------'")
    let runResLine = system("echo -e '--------------run result----------------'")
    if &filetype == 'c'
        let compileResu = system('gcc '.expand('%').' -o '.expand('%<'))
        let runResu=headtitle.compileResu.runResLine .system('./'.expand('%<'))
    endif
    if &filetype == 'cpp'
        let compileResu = system('g++ -std=c++11 '.expand('%').' -lpthread -o '.expand('%<'))
        let runResu=headtitle.compileResu.runResLine .system('./'.expand('%<'))
    endif
    if &filetype == 'python'
        let runResu=runResLine .system('python3 '.expand('%'))
    endif
    if &filetype == 'sh'
        let runResu=runResLine .system('sh '.expand('%'))
    endif

    bot 9sp runResult
    setlocal buftype=nofile bufhidden=hide noswapfile
    1s/^/\=runResu/
    1
endfunction
nnoremap  <localleader>ll :call ExecProm()<cr>
autocmd BufNewFile,BufWrite * :syntax match operators "\<compile result\>"
autocmd BufNewFile,BufWrite * :syntax match operators "\<run result\>"
hi operators ctermfg = DarkCyan
"}

"{
au BufNewFile,BufRead *.h set filetype=h
autocmd BufNewFile *.cpp,*.c,*.h,*.sh,  exec ":call SetTitle()"
func! SetTitle()
    if &filetype == 'sh'
        call setline(1,          "\#!/bin/bash")
        call append(line("."),   "\##########################################################")
        call append(line(".")+1, "\# File Name: ".expand("%"))
        call append(line(".")+2, "\# Author: ims")
        call append(line(".")+3, "\# Created Time: ".strftime("%c"))
        call append(line(".")+4, "\##########################################################")
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
"}

:endif
