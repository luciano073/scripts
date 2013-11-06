" /===================================\
" | VimFiles by Lucas Caton. |
" | http://blog.lucascaton.com.br/ |
" | http://www.twitter.com/lucascaton |
" | Created at 2011, January. |
" \===================================/


" ---------------------------------
" Plugins
" ---------------------------------

" Pathogen
execute pathogen#infect()

let g:ackprg = 'ag --nogroup --nocolor --column'

" NERDTree
nmap <F2> :NERDTreeToggle<CR>

" Tabular
inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" PowerLine
let g:Powerline_symbols = 'fancy'
set laststatus=2
" %{fugitive#statusline()}

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 2
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir': '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ 'link': 'some_bad_symbolic_links',
  \ }


" ---------------------------------
" Settings
" ---------------------------------

" Completion
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

" Autoindent with two spaces, always expand tabs
set tabstop=2
set shiftwidth=2
set expandtab

" Folding settings
" set foldmethod=indent " fold based on indent
" set foldnestmax=10 " deepest fold is 3 levels
set nofoldenable " dont fold by default
" set foldlevel=1

set wildmode=list:longest " make cmdline tab completion similar to bash
set wildmenu " enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ " stuff to ignore when tab completing

" Highlight all search results
set incsearch
set hlsearch

" Plugin and indentation on
filetype plugin indent on

" Ignore case in searches
set ignorecase

" Open splits at right side (and below)
set splitright
set splitbelow


" ---------------------------------
" Shortcuts for Linux (Gvim)
" ---------------------------------

" Ctrl+C to copy and Ctrl+P to paste
" vnoremap <C-C> "+y
" inoremap <C-P> <ESC>"+pa
" nnoremap <C-P> "+p

" Ctrl+S to save the current file
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>

" ---------------------------------
" Syntax Highlighting
" ---------------------------------

au BufNewFile,BufRead *.thor set filetype=ruby
au BufNewFile,BufRead *.less set filetype=css
au BufNewFile,BufRead Guardfile set filetype=ruby
au BufNewFile,BufRead .pryrc set filetype=ruby
au BufNewFile,BufRead Vagrantfile set filetype=ruby
au BufNewFile,BufRead *.pp set filetype=ruby

syntax on

let g:syntastic_mode_map={ 'mode': 'active',
                     \ 'active_filetypes': [],
                     \ 'passive_filetypes': ['html'] }


if has("gui_running")
  set lines=30
  set columns=132

" Highlight the line and the column of the current position of cursor
  " set cursorline
  " set cursorcolumn
  " hi CursorLine guibg=#222222
  " hi CursorColumn guibg=#222222
endif

 " if has("gui_running") || $TERM == "xterm-256color"
"   set t_Co=256
"   colorscheme github
" else
"   let g:CSApprox_loaded = 0
" endif


" Ctrl+L clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>

" Improve 'n' command (for searches)
nmap n nzz
nmap N Nzz

" " Removes trailing spaces
" function TrimWhiteSpace()
"   %s/\s*$//
"   ''
" endfunction

set list listchars=tab:»·,trail:·

" map <leader>= :call TrimWhiteSpace()<CR>
" map! <leader>= :call TrimWhiteSpace()<CR>

autocmd BufWritePre * :%s/\s\+$//e

"Buffers
map <A-1> :b1<cr>
map <A-2> :b2<cr>
map <A-3> :b3<cr>
map <A-4> :b4<cr>
map <A-5> :b5<cr>
map <A-6> :b6<cr>
map <A-7> :b7<cr>
map <A-8> :b8<cr>
map <A-9> :b9<cr>
map <A-0> :b10<cr>
map <S-F1> :b11<cr>
map <S-F2> :b12<cr>
map <S-F3> :b13<cr>
map <S-F4> :b14<cr>
map <S-F5> :b15<cr>
map <S-F6> :b16<cr>
map <S-F7> :b17<cr>
map <S-F8> :b18<cr>
map <S-F9> :b19<cr>
map <S-F10> :b20<cr>
map <S-F11> :b21<cr>
map <S-F12> :b22<cr>
map <C-Q> :bwipeout<cr>
map <F6> :buffers<cr>

" autocmd! bufwritepost .vimrc source %

set backup
set backupdir=/tmp
set dir=/tmp

let b:match_words = '^\(class\):^\(end\),def:end,do:end'

" Ctrl+R reloads the ~/.vimrc file
nnoremap <F12> :source ~/.vimrc<cr>
