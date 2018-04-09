set encoding=utf-8
set nocompatible
colorscheme darkblue
set nu
set ruler
set hlsearch
set hidden
set autochdir
set foldmethod=syntax
set foldlevel=100
set nobackup
setlocal noswapfile
set ls=2 "laststatus=2
set statusline=[%F]%y%r%m%*[%{&encoding}]%=[Line:%l/%L,Column:%c][%p%%]
set wildmenu
set ch=1
set sw=2
set ts=2
set ai
set si
set et
set fdm=manual "indent,syntax,marker,expr,diff
set backupcopy=yes
set backspace=indent,eol,start
set tags=tags;/
"set tags+=/data1/yps/tags
"set tags+=/root/soft/php-5.5.25/tags
"set rtp+=~/.vim/bundle/Vundle.vim/
"call vundle#rc()
"Bundle 'Syntastic'

execute pathogen#infect()
syntax on
filetype plugin indent on
nmap <F5> :NERDTreeToggle<cr>

"快速查找文件
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"设置过滤不进行查找的后缀名
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$'

"状态条加强
let g:airline_powerline_fonts = 1

"代码分析：tagbar
"nmap <F8> :TagbarToggle<CR>

"代码检查
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

let g:syntastic_python_checkers = ['python3']
let g:syntastic_php_checkers = ['php']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" Go to definition else declaration
"nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" 主动调用补全
"let g:ycm_key_invoke_completion = '<C-a>'
" 解决与 YCM 插件的冲突
"let g:UltiSnipsExpandTrigger="<c-j>"
"let g:UltiSnipsJumpForwardTrigger="<c-j>"
"let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" golang
" let g:go_fmt_command = "goimports"

"let g:syntastic_php_phpcs_args = "--tab-width=4 --standard=Zend"

"let g:phpfmt_standard = 'Zend'
"let g:phpfmt_autosave = 1
"let g:phpfmt_command = '/data1/php/bin/phpcbf'
"let g:phpfmt_tmp_dir = '/tmp/code'
set nocscopeverbose

let g:tags_path = $PWD

function! BuildTags()
    execute 'silent !find '.g:tags_path.' -name "*.php" > '.g:tags_path.'/cscope.files'
    execute 'silent !cscope -bq -i '.g:tags_path.'/cscope.files -f '.g:tags_path.'/cscope.out'
    cscope kill g:tags_path.'/cscope.out'
    cscope add g:tags_path.'/cscope.out'
    execute 'silent !ctags -f '.g:tags_path.'/tags -L '.g:tags_path.'/cscope.files'
    return 0
endfunction

map <F6> :call BuildTags()<cr>

"cscope add /data1/yps/cscope.out

"autocmd BufWritePre *.php :call BuildTags()

nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_ctags_bin = 'ctags' 

map "+y :w !pbcopy<CR><CR>
map "+p :r !pbpaste<CR><CR> 
