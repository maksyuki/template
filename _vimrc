"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim7.1在windows下的编码设置。By Huadong.Liu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
set fileencoding=chinese
else
set fileencoding=utf-8
endif
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"解决consle输出乱码
language messages zh_CN.utf-8


"Set the status line options. Make it show more information.
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\[POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

"Set Color Scheme and Font Options
colorscheme monokai
"colorscheme solarized
syntax on 					"语法高亮
syntax enable
set guifont=Consolas:h13
"set gfw=幼圆:h10.5:cGB2312
"set guifont=Monospace\ 11
"set line no, buffer, search, highlight, autoindent and more.
set nu              		"显示行号
set go= 			 		"不显示工具栏
"set lines=50 columns=160
set ai!
set hidden
set cursorline
set nobackup
set ignorecase 				"查找时忽略大小写
set incsearch 				"设置快速搜索(输入待查找内容的同时，就开始匹配内容)

"------缩进------
"在这种缩进形式中，新增加的行和前一行使用相同的缩进形式。可以使用以下命令，启用autoindent缩进形式
set autoindent

"在这种缩进模式中，每一行都和前一行有相同的缩进量，同时这种缩进形式能正确的识别出花括号，当遇到右花括号（}），则取消缩进形式。此外还增加了识别C语言关键字的功能。如果一行是以#开头的，那么这种格式将会被特殊对待而不采用缩进格式。可以使用以下命令，启用smartindent缩进结构
set smartindent 			"智能的选择对起方式

"Vim可以很好的识别出C和Java等结构化程序设计语言，并且能用C语言的缩进格式来处理程序的缩进结构。可以使用以下命令，启用cindent缩进结构
set cindent shiftwidth=4

"set smarttab "
set tabstop=4 				"设置tab键为4个空格
set shiftwidth=4 			"将换行自动缩进设置成4个空格
set backspace=2
"if &filetype == "python"
"    set expandtab
"endif
"set expandtab 				"插入tab之后会将tab变成4个空格(按backspace会察觉)
"imap { {}<ESC>i<CR><ESC>V<O

set smartcase
set showmatch 				"括号匹配
set ruler 					"右下角显示光标状态行
set vb
set viminfo+=n$VIM/_viminfo
set noerrorbells
set showcmd					"在底部显示输入的命令
set mouse=a 				"使用鼠标
set history=1000 			"命令或者是查找记录的历史个数
set undolevels=1000
"set t_Co=256

"set the Default Code

map <F2> :call TitleDet()<CR>
func SetTitle()
if &filetype == "cpp"
    let l = 0
    let l = l + 1 | call setline(l,'/**************************************************')
    let l = l + 1 | call setline(l,'filename       :'.expand('%:t'))
    let l = l + 1 | call setline(l,'author         :supermaker')
    let l = l + 1 | call setline(l,'created time   :'.strftime('%c'))
    let l = l + 1 | call setline(l,'last modified  :'.strftime('%c'))
    let l = l + 1 | call setline(l,'file location  :'.getcwd())
    let l = l + 1 | call setline(l,'***************************************************/')
    let l = l + 1 | call setline(l,'') 
    let l = l + 1 | call setline(l,'#pragma comment(linker, "/STACK:102400000,102400000")')
    let l = l + 1 | call setline(l,'#include <set>')
    let l = l + 1 | call setline(l,'#include <bitset>')
    let l = l + 1 | call setline(l,'#include <list>')
    let l = l + 1 | call setline(l,'#include <map>')
    let l = l + 1 | call setline(l,'#include <stack>')
    let l = l + 1 | call setline(l,'#include <queue>')
    let l = l + 1 | call setline(l,'#include <deque>')
    let l = l + 1 | call setline(l,'#include <string>')
    let l = l + 1 | call setline(l,'#include <vector>')
    let l = l + 1 | call setline(l,'#include <ios>')
    let l = l + 1 | call setline(l,'#include <iostream>')
    let l = l + 1 | call setline(l,'#include <fstream>')
    let l = l + 1 | call setline(l,'#include <sstream>')
    let l = l + 1 | call setline(l,'#include <iomanip>')
    let l = l + 1 | call setline(l,'#include <algorithm>')
    let l = l + 1 | call setline(l,'#include <utility>')
    let l = l + 1 | call setline(l,'#include <complex>')
    let l = l + 1 | call setline(l,'#include <numeric>')
    let l = l + 1 | call setline(l,'#include <functional>')
    let l = l + 1 | call setline(l,'#include <cmath>')
    let l = l + 1 | call setline(l,'#include <ctime>')
    let l = l + 1 | call setline(l,'#include <climits>')
    let l = l + 1 | call setline(l,'#include <cstdarg>')
    let l = l + 1 | call setline(l,'#include <cstdio>')
    let l = l + 1 | call setline(l,'#include <cstdlib>')
    let l = l + 1 | call setline(l,'#include <cstring>')
    let l = l + 1 | call setline(l,'#include <cctype>')
    let l = l + 1 | call setline(l,'#include <cassert>')
    let l = l + 1 | call setline(l,'using namespace std;')
    let l = l + 1 | call setline(l,'')
    let l = l + 1 | call setline(l,'#define CFF freopen ("aaa.txt", "r", stdin)')
    let l = l + 1 | call setline(l,'#define CPPFF ifstream cin ("aaa.txt")')
    let l = l + 1 | call setline(l,'#define	DB(ccc)	cout << #ccc << " = " << ccc << endl')
    let l = l + 1 | call setline(l,'#define PB push_back')
    let l = l + 1 | call setline(l,'#define MP(A, B) make_pair(A, B)')
    let l = l + 1 | call setline(l,'')
    let l = l + 1 | call setline(l,'typedef long long LL;')
    let l = l + 1 | call setline(l,'typedef unsigned long long ULL;')
    let l = l + 1 | call setline(l,'typedef double DB;')
    let l = l + 1 | call setline(l,'typedef pair <int, int> PII;')
    let l = l + 1 | call setline(l,'typedef pair <int, bool> PIB;')
    let l = l + 1 | call setline(l,'')
    let l = l + 1 | call setline(l,'const int INF = 0x7F7F7F7F;')
    let l = l + 1 | call setline(l,'const int MOD = 1e9 + 7;')
    let l = l + 1 | call setline(l,'const double EPS = 1e-10;')
    let l = l + 1 | call setline(l,'const double PI = 2 * acos (0.0);')
    let l = l + 1 | call setline(l,'const int maxn = 1e5 + 6666;')
    let l = l + 1 | call setline(l,'')
    let l = l + 1 | call setline(l,'int main()')
    let l = l + 1 | call setline(l,'{')
    let l = l + 1 | call setline(l,'    //CFF;')
    let l = l + 1 | call setline(l,'    //CPPFF;')
    let l = l + 1 | call setline(l,'    ')
    let l = l + 1 | call setline(l,'    return 0;')
    let l = l + 1 | call setline(l,'}')
elseif &filetype == "python"
    let l = 0
    let l = l + 1 | call setline(l,'#!/usr/bin/python')
    let l = l + 1 | call setline(l,'#filename       :'.expand('%:t'))
    let l = l + 1 | call setline(l,'#author         :Yuchi Miao')
    let l = l + 1 | call setline(l,'#created time   :'.strftime('%c'))
    let l = l + 1 | call setline(l,'#last modified  :'.strftime('%c'))
    let l = l + 1 | call setline(l,'#python_version :2.7.6')
    let l = l + 1 | call setline(l,'#version        :')
    let l = l + 1 | call setline(l,'#description    :')
    let l = l + 1 | call setline(l,'#notes          :')
    let l = l + 1 | call setline(l,'#==============================================================================')

endif
endfunc

autocmd BufWritePre,FileWritePre *.py ks|call UpdateTitle()|'s 
autocmd BufWritePre,FileWritePre *.cpp ks|call UpdateTitle()|'s 
"更新最近修改时间和文件名
function UpdateTitle()
    normal m'
    execute '/last modified  :/s@:.*$@\=":".strftime("%c")@'
    normal ''
    normal mk
    execute '/filename       :/s@:.*$@\=":".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction
"判断前10行代码里面，是否有Last modified这个单词，
"如果没有的话，代表没有添加过作者信息，需要新添加；
"如果有的话，那么只需要更新即可
function TitleDet()
    let n=1
    "默认为添加
    while n < 20 
        let line = getline(n)
        if line =~ '^\#\s*\S*last\smodified:\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call SetTitle()
endfunction

"quickfix set
"set makeprg=g++\ -Wall\ -o\ hello\ hello.cpp

"set the compliation

"! <command>表示执行cmd命令
"!start <command>表示异步执行cmd命令
"下面编译命令中的%表示当前文件的完整名字(文件名+类型名)
"下面编译命令中的%<表示当前文件名
map <F9> :call CR()<CR>
func! CR()
exec "w"
if &filetype == "cpp"
	exec "! g++ -Wall -O2 -g  % -o %<"
	exec "! %<"

elseif &filetype == "c"
	exec "! g++ -Wall -O2 -g  % -o %<"
	exec "! %<"

elseif &filetype == "java"
	exec "!javac %"
	exec "!java %<"

elseif &filetype == "python"
	exec "!python %"

elseif &filetype == "html"
	exec "! %"
endif
endfunc
 
imap { {<cr>}<c-o>O<left><right>

"------复制和粘贴------
map <C-A> ggVG
map <C-C> "+y
map <C-V> "+gp
map <F3> :Ve!<CR>
map <F4> :e.<CR>
"inoremap ( ()<LEFT>
"inoremap [ []<LEFT>
"inoremap { {}<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
