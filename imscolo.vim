" Vim color file modify from industrial
" Maintainer: ims
" Remark:    "industry" stands for 'industrial' color scheme. In industrial
"        HMI (Human-Machine-Interface) programming, using a standard color
"               scheme is mandatory in many cases (in traffic-lights for example):
"               LIGHT_RED is        'Warning'
"               LIGHT_YELLOW is        'Attention'
"               LIGHT_GREEN is        'Normal'
"               LIGHT_MAGENTA is    'Warning-Attention' (light RED-YELLOW)
"               LIGHT_CYAN is        'Attention-Normal'  (light YELLOW-GREEN).
"               BLACK is        Dark-High-Contrast Background for maximum safety.
"               BLUE is            Shade of BLACK (not supposed to get attention).
"               Industrial color scheme is by nature clear, safe and productive.
"               Yet, depends on the file type's syntax, it might appear incorrect.
" Reset to dark background, then reset everything to defaults:

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "imscolo"

hi Normal    ctermfg=LightGray    ctermbg=234
"minibuf {
" color of filename are changed in mimibuf
" MBENormal         - for buffers that have NOT CHANGED and are NOT VISIBLE.
" MBEChanged        - for buffers that HAVE CHANGED and are NOT VISIBLE
" MBEVisibleNormal  - buffers that have NOT CHANGED and are VISIBLE
" MBEVisibleChanged - buffers that have CHANGED and are VISIBLE

hi MBENormal            ctermfg=40         cterm=NONE
hi MBEChanged           ctermfg=red        cterm=NONE
hi MBEVisibleNormal     ctermfg=208        cterm=bold
hi MBEVisibleChanged    ctermfg=200        cterm=bold

"}
"hi column row{
hi StatusLine           ctermfg=208        ctermbg=237  cterm=NONE
hi StatusLineNC         ctermfg=237        ctermbg=237
hi VertSplit            ctermfg=DarkCyan   ctermbg=234
hi LineNr               ctermfg=DarkCyan   ctermbg=233
hi CursorLine           ctermfg=NONE       ctermbg=238  cterm=NONE
hi CursorColumn         ctermfg=NONE       ctermbg=black
set cursorline
set cursorcolumn
"}

hi IncSearch     ctermfg=Yellow        ctermbg=red
hi Search        ctermfg=9             ctermbg=41
hi Visual                              ctermbg=8     cterm=bold
hi Comment       ctermfg=DarkCyan      ctermbg=234
hi Special       ctermfg=Yellow        ctermbg=234
hi Constant      ctermfg=LightCyan
hi Identifier    ctermfg=LightMagenta
hi PreProc       ctermfg=Yellow
hi Type          ctermfg=LightGreen
hi Delimiter     ctermfg=Yellow
hi Statement     ctermfg=green

hi MatchParen    ctermfg=16            ctermbg=208   cterm=bold
hi ModeMsg       ctermfg=red                         " color of INSERT or VISUAL
hi MoreMsg       ctermfg=229
hi Operator      ctermfg=Yellow

hi Directory     ctermfg=118           cterm=bold
hi Error         ctermfg=219           ctermbg=89
hi ErrorMsg      ctermfg=199           ctermbg=16    cterm=bold
hi Exception     ctermfg=118           cterm=bold
hi FoldColumn    ctermfg=67            ctermbg=16
hi Folded        ctermfg=67            ctermbg=16
hi Function      ctermfg=118
hi Ignore        ctermfg=244           ctermbg=232
hi Keyword       ctermfg=161           cterm=bold
hi Label         ctermfg=229
hi SpecialKey    ctermfg=81
hi Structure     ctermfg=118
hi Macro         ctermfg=161           cterm=bold
hi PreCondit     ctermfg=161           cterm=bold
hi StorageClass  ctermfg=208
hi Tag           ctermfg=161
hi Title         ctermfg=166
hi String        ctermfg=166
"Ycm color"
"For the signs in the Vim gutter, the relevant groups are:
hi SyntasticErrorSign    ctermfg=1      ctermbg=11  cterm=bold
hi SyntasticWarningSign  ctermfg=11     ctermbg=0  cterm=bold
"The syntax groups used to highlight regions of text with errors/warnings:
hi SyntasticError    ctermfg=9      ctermbg=0  cterm=bold
hi SyntasticWarning  ctermfg=11     ctermbg=8  cterm=bold


augroup hightlightFun
    autocmd!
    " hilight function name   :me    Match End
    autocmd BufNewFile,BufRead,BufWrite * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
    hi cfunctions ctermfg=43
    ""autocmd BufNewFile,BufRead,BufWrite * :syntax match operators "[=\*\&\%\-\>\<\+]"
    ""hi operators ctermfg = 39
    autocmd BufNewFile,BufRead,BufWrite  * :syntax match selfType "\<WORD32\>"
    autocmd BufNewFile,BufRead,BufWrite  * :syntax match selfType "\<WORD16\>"
    autocmd BufNewFile,BufRead,BufWrite  * :syntax match selfType "\<WORD\>"
    autocmd BufNewFile,BufRead,BufWrite * :syntax match selfType "\<BYTE\>"
    hi selfType ctermfg = 105
    autocmd BufNewFile,BufRead,BufWrite * :syntax match EVENT "CMU_EVENT[_A-Z0-9]*"
    hi EVENT ctermfg = Red
augroup END


:function! SetLocalStatusLine()
    setlocal statusline =%{expand('%:h')}\/
    setlocal statusline +=%3*%{expand('%:t')}%*
    setlocal statusline +=%{FugitiveStatusline()}
    setlocal statusline +=%1*%m%*
    setlocal statusline +=%2*%r%*
    setlocal statusline +=%=%y
    setlocal statusline +=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"]\"}
    setlocal statusline +=[%{&ff}][a:%03.3b]
    setlocal statusline +=[r:%l/%2*%L%*,c:%c]
    setlocal statusline +=%3*[%p%%]%*
    hi User1 ctermfg=1 ctermbg=237    cterm=bold
    hi User2 ctermfg=11 ctermbg=237     cterm=bold
    hi User3 ctermfg=10 ctermbg=237     cterm=bold
    set laststatus=2
:endfunction

augroup filetype_statusline
    autocmd!
    autocmd FileType  c  call  SetLocalStatusLine()
    autocmd FileType  cpp  call  SetLocalStatusLine()
    autocmd FileType  python  call  SetLocalStatusLine()
    autocmd FileType  vim call  SetLocalStatusLine()
augroup END

set showcmd

"vim -R file 只读
"vim -M 不能修改模式
"Cursor光标
"ErrorMsg命令行中的错误提示
"LineNr行号
"Normal编辑区一般文本的前景和背景色
