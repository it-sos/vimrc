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
set sw=4
set ts=4
set ai
set si
set et
set fdm=manual "indent,syntax,marker,expr,diff
set backupcopy=yes
set backspace=indent,eol,start
"set tags=.ide/tags;/
"set tags+=/tags1
"set rtp+=~/.vim/bundle/Vundle.vim/
"call vundle#rc()
"Bundle 'Syntastic'
execute pathogen#infect()
syntax on
filetype plugin indent on

" 文件浏览器
nmap <F5> :NERDTreeToggle<cr>
autocmd VimEnter * NERDTree
let NERDTreeShowBookmarks=1

" 代码分析工具
nmap <silent> <F4> :TagbarToggle<CR>
"let g:tagbar_ctags_bin = '.ide/tags' 

" mac下复制到系统剪贴板
map "+y :w !pbcopy<CR><CR>
map "+p :r !pbpaste<CR><CR> 

"快速查找文件
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"设置过滤不进行查找的后缀名
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$'

"状态条加强
let g:airline_powerline_fonts = 1

" vue模板语法检测工具
autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

"代码检查状态栏
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" 语法检查
let g:syntastic_python_checkers = ['python3', 'python']
"let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd', 'phplint', 'phpstan']
let g:syntastic_php_checkers = ['php', 'phpmd', 'phpstan']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_css_checkers = ['stylelint']
let g:syntastic_html_checkers=['tidy', 'stylelint']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
"let g:syntastic_php_phpcs_args = "--tab-width=4 --standard=Zend"
"let g:phpfmt_standard = 'Zend'
"let g:phpfmt_autosave = 1
"let g:phpfmt_command = '/data1/php/bin/phpcbf'
"let g:phpfmt_tmp_dir = '/tmp/code'

" golang 支持
" let g:go_fmt_command = "goimports"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting 代码跟踪工具
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocscopeverbose
let i = 0
let parent = ''
let g:proj_path = ''
while i < 8
    let g:ide = glob(fnamemodify(parent.".ide", ":p"))
    if strlen(g:ide)> 0
        let g:proj_path = fnamemodify(parent, ":p") 
        break
    endif
    let i += 1
    let parent .= '../'
endwhile

function! BuildTags()
    if g:proj_path == ''
        return 0
    endif
    execute 'silent !find '.g:proj_path.' -path .git -prune -o -name "*.php" -o -name "*.py" -o -name "*.phtml" -type f > '.g:ide.'cscope.files'
    execute 'silent !cscope -bqk -i '.g:ide.'cscope.files -f '.g:ide.'cscope.out'
    execute 'silent :cscope kill  '.g:ide.'cscope.out'
    execute 'silent :cscope add '.g:ide.'cscope.out'
    "execute 'silent !ctags --tag-relative=yes --fields=+iaS --extra=+q -f '.g:ide.'tags -L '.g:ide.'cscope.files'
    return 0
endfunction
call BuildTags()
autocmd BufWritePre *.(php|py) :call BuildTags()

" 加载php类库代码
let phplib_cscope = '/data1/phplib/.ide/cscope.out'
if glob(phplib_cscope) != g:ide.'cscope.out' && g:proj_path != ''
    execute 'silent :cscope add '.phplib_cscope
endif

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>


" 设置
let g:user_emmet_settings = {
\ 'wxss': {
\   'extends': 'css',
\ },
\ 'wxml': {
\   'extends': 'html',
\   'aliases': {
\     'div': 'view',
\     'span': 'text',
\   },
\  'default_attributes': {
\     'block': [{'wx:for-items': '{{list}}','wx:for-item': '{{item}}'}],
\     'navigator': [{'url': '', 'redirect': 'false'}],
\     'scroll-view': [{'bindscroll': ''}],
\     'swiper': [{'autoplay': 'false', 'current': '0'}],
\     'icon': [{'type': 'success', 'size': '23'}],
\     'progress': [{'precent': '0'}],
\     'button': [{'size': 'default'}],
\     'checkbox-group': [{'bindchange': ''}],
\     'checkbox': [{'value': '', 'checked': ''}],
\     'form': [{'bindsubmit': ''}],
\     'input': [{'type': 'text'}],
\     'label': [{'for': ''}],
\     'picker': [{'bindchange': ''}],
\     'radio-group': [{'bindchange': ''}],
\     'radio': [{'checked': ''}],
\     'switch': [{'checked': ''}],
\     'slider': [{'value': ''}],
\     'action-sheet': [{'bindchange': ''}],
\     'modal': [{'title': ''}],
\     'loading': [{'bindchange': ''}],
\     'toast': [{'duration': '1500'}],
\     'audio': [{'src': ''}],
\     'video': [{'src': ''}],
\     'image': [{'src': '', 'mode': 'scaleToFill'}],
\   }
\ },
\}

setl omnifunc=csscomplete#CompleteCSS
let g:neomake_wxss_enabled_makers = ['stylelint']
let g:neomake_wxml_enabled_makers = ['tidy']

autocmd BufEnter * call s:SetWxapp()
function! s:SetWxapp()
  if &ft ==# 'javascript'
    setl dictionary+=~/.vim/bundle/wxapp.vim/dict/js.dict
  elseif &ft ==# 'wxml'
    setl dictionary+=~/.vim/bundle/wxapp.vim/dict/wxml.dict
  elseif &ft ==# 'wxss'
    setl dictionary+=~/.vim/bundle/wxapp.vim/dict/wxss.dict
  endif
endfunction
