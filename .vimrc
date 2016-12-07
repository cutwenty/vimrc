" 使用vundle
" 将下面配置文件加入到.vimrc文件中
set nocompatible " 必须
filetype off     " 必须

" 将Vundle加入运行时路径中(Runtime path)
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" 使用Vundle管理插件，必须
Plugin 'gmarik/Vundle.vim'

"
" 其他插件
"
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" vim剪贴板和系统剪贴板同步
set clipboard+=unnamed

set foldmethod=syntax
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 符号补全
" inoremap ( ()<LEFT>
" inoremap { {}<LEFT>
" inoremap [ []<LEFT>
" inoremap ' ''<LEFT>
" inoremap " ""<LEFT>

""set foldmethod=syntax

" Highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline
set cursorline cursorcolumn

" Leader
let mapleader = ","

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set confirm       " Need confrimation while exit
set fileencodings=utf-8,gb18030,gbk,big5

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Cucumber navigation commands
  autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=4
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Color scheme
colorscheme molokai
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0
" syntax on
" set t_Co=256
" let g:solarized_termcolors=256
" set background=light
" colorscheme solarized


" Make it obvious where 80 characters is
set textwidth=100
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-rspec mappings
" nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
" nnoremap <Leader>s :call RunNearestSpec()<CR>
" nnoremap <Leader>l :call RunLastSpec()<CR>

" Run commands that require an interactive shell
" nnoremap <Leader>r :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
""nnoremap <C-j> <C-w>j
""nnoremap <C-k> <C-w>k
""nnoremap <C-h> <C-w>h ""nnoremap <C-l> <C-w>l
""inoremap <C-j> <Down>
""inoremap <C-k> <Up>
""inoremap <C-h> <Left>
""inoremap <C-l> <Right>

" insert模式下使用hjkl
inoremap <ESC>h <left>
inoremap <ESC>l <right>
inoremap <ESC>j <c-o>gj
inoremap <ESC>k <c-o>gk


" 移动行首/行尾/上行行尾/下行行尾
inoremap <ESC>H <Esc>^i
inoremap <ESC>L <End>
inoremap <ESC>K <Esc>k$a
inoremap <ESC>J <Esc>j$a

" 在光标下方，上方插入新行
inoremap <ESC>o <Esc>o
inoremap <ESC>O <Esc>O

" 单词移动
inoremap <ESC>n <C-Left>
inoremap <ESC>m <C-Right>

" 回车ctrl+j, backspace, delete
inoremap <ESC>c <C-o>x
""inoremap <c-z> <C-o>h<C-o>x
inoremap <ESC>z <bs>
" 删除当前行
inoremap <ESC>a <C-o>dd

""删除当前行并重写
inoremap <ESC>d <Esc>cc

""回车
inoremap <ESC>f <c-j>

""复制当前行
inoremap <ESC>y <c-[>yya

""黏贴当前行
inoremap <ESC>p <c-[>pa

inoremap <ESC>[ <esc>
" inoremap <space> <esc>

inoremap <ESC>w <esc>:w<CR>
inoremap <ESC>q <esc>:q<CR>

" tab缩进、后退
inoremap <ESC>, <c-d>
inoremap <ESC>. <c-t>

" split 页面切换
inoremap <ESC>1 <esc><c-w>h
inoremap <ESC>2 <esc><c-w>l
inoremap <ESC>3 <esc><c-w>j
inoremap <ESC>4 <esc><c-w>k
noremap <ESC>1 <c-w>h
noremap <ESC>2 <c-w>l
noremap <ESC>3 <c-w>j
noremap <ESC>4 <c-w>k

nmap <ESC>w :w<CR>
nmap <ESC>q :q<CR>

" insert模式下使用hjkl
inoremap <M-h> <left>
inoremap <M-l> <right>
inoremap <M-j> <c-o>gj
inoremap <M-k> <c-o>gk


" 移动行首/行尾/上行行尾/下行行尾
inoremap <M-H> <Esc>^i
inoremap <M-L> <End>
inoremap <M-K> <Esc>k$a
inoremap <M-J> <Esc>j$a

" 在光标下方，上方插入新行
inoremap <M-o> <Esc>o
inoremap <M-O> <Esc>O

" 单词移动
inoremap <M-n> <C-Left>
inoremap <M-m> <C-Right>

" 回车ctrl+j, backspace, delete
inoremap <M-c> <C-o>x
""inoremap <c-z> <C-o>h<C-o>x
inoremap <M-z> <bs>
" 删除当前行
inoremap <M-a> <C-o>dd

""删除当前行并重写
inoremap <M-d> <Esc>cc

""回车
inoremap <M-f> <c-j>

""复制当前行
inoremap <M-y> <c-[>yya

""黏贴当前行
inoremap <M-p> <c-[>pa

inoremap <M-[> <esc>
" inoremap <space> <esc>

inoremap <M-w> <esc>:w<CR>
inoremap <M-q> <esc>:q<CR>

" tab缩进、后退
inoremap <M-,> <c-d>
inoremap <M-.> <c-t>

" split 页面切换
inoremap <M-1> <esc><c-w>h
inoremap <M-2> <esc><c-w>l
inoremap <M-3> <esc><c-w>j
inoremap <M-4> <esc><c-w>k
noremap <M-1> <c-w>h
noremap <M-2> <c-w>l
noremap <M-3> <c-w>j
noremap <M-4> <c-w>k

nmap <M-w> :w<CR>
nmap <M-q> :q<CR>

map <Leader><leader>. <Plug>(easymotion-repeat)

"inoremap <c-H> <Esc>^i
"inoremap <c-L> <End>
"inoremap <c-K> <Esc>k$<F8>a
"inoremap <c-J> <Esc>j$a


""inoremap <C-[> <esc>

set bs=2


"inoremap <D+[> <ESC> 

""inoremap <D-i> <Up>
""inoremap <D-l> <Right>
""inoremap <D-j> <Left>
""inoremap <D-k> <Down>

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=0
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ignore_files=[".*\.html$"]
let g:syntastic_javascript_checkers=["eslint"]
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

autocmd Syntax javascript set syntax=jquery " JQuery syntax support

set matchpairs+=<:>
set statusline+=%{fugitive#statusline()} "  Git Hotness

" Nerd Tree
let NERDChristmasTree=0
let NERDTreeWinSize=25
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
autocmd vimenter * if !argc() | NERDTree | endif " Automatically open a NERDTree if no files where specified
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Close vim if the only window left open is a NERDTree
nmap <Leader>[ :NERDTreeToggle<cr>




" Emmet
let g:user_emmet_mode='i' " enable for insert mode

" Search results high light
set hlsearch

" nohlsearch shortcut
nmap -hl :nohlsearch<cr>
nmap +hl :set hlsearch<cr>

" Javascript syntax hightlight
syntax enable

" ctrap
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

""nnoremap <leader>w :w<CR>
""nnoremap <leader>q :q<CR>

" RSpec.vim mappings
" map <Leader>t :call RunCurrentSpecFile()<CR>
" map <Leader>s :call RunNearestSpec()<CR>
" map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR>

" Vim-instant-markdown doesn't work in zsh
set shell=bash\ -i

" Snippets author
let g:snips_author = 'Yuez'

" Tagbar
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
let g:tagbar_width=20
let g:tagbar_autofocus=0
autocmd BufReadPost *.c,*.css,*.js call tagbar#autoopen()
let g:tagbar_type_css = {
      \ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
    \ }
nmap <Leader>] :TagbarToggle<CR>



" less文件支持
nnoremap <Leader>m :w <BAR> !lessc % > %:t:r.css<CR><space>

" winmanager的配置
" let g:winManagerWindowLayout='NERDTree|Tagbar'
" let g:winManagerWidth=30
" let g:AutoOpenWinManager = 1 "这里要配合修改winmanager.vim文件，见下方说明"


" 代码格式化，出错Cannot find module '/Users/hxhgta/.vim/bundle/vim-jsbeautify/plugin/lib/js/lib/beautify.js'
" ".vimrc
" map <c-f> :call JsBeautify()<cr>
" "" or
" autocmd FileType javascript noremap <c-f> :call JsBeautify()<cr>
" " for html
" autocmd FileType html noremap <c-f> :call HtmlBeautify()<cr>
" " for css or scss
" autocmd FileType css noremap <c-f> :call CSSBeautify()<cr>


" Track the engine.
Bundle 'SirVer/ultisnips'
"
" " Snippets are separated from the engine. Add this if you want them:
Bundle 'honza/vim-snippets'
"
" " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<ESC>i"
let g:UltiSnipsJumpForwardTrigger="<ESC>9"
let g:UltiSnipsJumpBackwardTrigger="<ESC>0"
" let g:UltiSnipsEnableSnipMate=0

" " If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir = 'UltiSnips'
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'bundle/vim-snippets/UltiSnips', '~/.vim/bundle/vim-snippets/snippets']








if filereadable(expand("~/.vimrc.bundles.local"))
	  source ~/.vimrc.bundles.local
endif

" filetype on










call vundle#end() " 必须
syntax on
filetype on
filetype plugin indent on " 必须





