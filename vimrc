set nocompatible " be iMproved, required
set backspace=indent,eol,start
filetype off   " required

set tags=./.tags;,.tags
"set rtp+=~/.vim/bundle/Vundle.vim
set cmdheight=2
set laststatus=2  "永远显示状态栏

call plug#begin('~/.vim/plugged')
    Plug 'Valloric/YouCompleteMe' , { 'do': './install.py --clang-completer' }
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'w0rp/ale'
    Plug 'Shougo/echodoc.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'Yggdroot/LeaderF'
    Plug 'mileszs/ack.vim'
call plug#end()

filetype plugin indent on " required


"自动缩进与C语言风格缩进
set autoindent 
set cindent
"不要用空格代替制表符
set noexpandtab
"在行和段开始处使用制表符
set smarttab
"显示行号
set number
"缩进宽度
set tabstop=4
set softtabstop=4
set shiftwidth=4
"建议开启expandtab选项，会自动将tab扩展很空格，代码缩进会更美观
set expandtab 
set mouse=a "开启鼠标点击
set background=dark "背景使用黑色
set showmatch
set ruler
set t_Co=256 "开启256色
"set termguicolors
let g:solarized_termtrans = 1
set nocompatible  
syntax on 
syntax enable 
set background=dark 
colorscheme solarized
set ignorecase
set cursorline
set ruler
"搜索逐字符高亮
set hlsearch
set incsearch
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"自动补全
":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {<CR>}<ESC>O
":inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap " ""<ESC>i
":inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
filetype plugin indent on 

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

"linter
let g:ale_linters = {'c': ['clang'], 'c++': ['clang', 'cppcheck']}
"let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
let g:ale_sign_column_always = 1

let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11'
let g:ale_c_cppcheck_options = '-Wall -O2 -std=c99'
let g:ale_cpp_cppcheck_options = '--std=c++11 --enable=all'

nmap F3: ALEToggle<CR>

let g:airline_theme='base16_solarized'
let g:airline#extensions#tabline#enabled = 1
"这个是安装字体后 必须设置此项" 
let g:airline_powerline_fonts = 1 

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
noremap <c-n> :LeaderfMru<cr>
noremap <c-f> :LeaderfFunction!<cr>
noremap <m-n> :LeaderfBuffer<cr>
noremap <m-m> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

"调整窗口高度宽度的快捷键
nmap w= :resize +5<CR>
nmap w- :resize -5<CR>
nmap w, :vertical resize -5<CR>
nmap w. :vertical resize +5<CR>
nmap sp :split<CR>
nmap vs :vertical split<CR>
nmap <c-left> :bp<cr>
nmap <c-right> :bn<cr>
nmap <c-C> :bd<cr>

"ycm
set runtimepath+=~/.vim/plugged/YouCompleteMe
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_error_symbol = '!!'
let g:ycm_warning_symbol = '>>'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_collect_identifiers_from_tags_files=1 
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_confirm_extra_conf = 0
let g:ycm_python_binary_path = 'python3'
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']  " 映射按键, 没有这个会拦截掉tab, 导致其他插件的tab不能用.
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
set completeopt=menu,menuone
let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ }
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <F4> :YcmDiags<CR>

let g:echodoc#enable_at_startup = 1
let g:echodoc#enable_force_overwrite = 1

"NERDTree配置
nnoremap <silent> <C-F5> :NERDTree<CR>
let NERDChristmasTree=1  
let NERDTreeAutoCenter=1 
let NERDTreeChDirMode=2  "选中root即设置为当前目录
let NERDTreeQuitOnOpen=1 "打开文件时关闭树
let NERDTreeShowBookmarks=1 "显示书签
let NERDTreeMinimalUI=1 "不显示帮助面板
let NERDChristmasTree=1
let NERDTreeMouseMode=3 "单击打开文件夹
let NERDTreeWinSize=30 " 设置NERDTree子窗口宽度
let NERDTreeWinPos="left" "设置NERDTree子窗口位置
let NERDTreeShowHidden=0 "显示隐藏文件
let NERDTreeMinimalUI=1 "NERDTree子窗口中不显示冗余帮助信息
let NERDTreeAutoDeleteBuffer=1 "删除文件时自动删除文件对应buffer
"autocmd BufRead * 25vsp ./"自动开启NerdTree
nmap <F2> :NERDTreeToggle<cr>
nmap <F10> :set paste<cr>


let g:ackprg = 'ag --nogroup --nocolor --column'

autocmd VimEnter * NERDTree
wincmd w
autocmd VimEnter * wincmd w

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
