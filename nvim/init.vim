" dein settings {{{
if &compatible
  set nocompatible
endif
" dein.vimのディレクトリ
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" なければgit clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " 管理するプラグインを記述したファイル
  let g:rc_dir    = expand("~/.config/nvim/")
  let s:toml      = g:rc_dir . 'dein.toml'
  let s:lazy_toml = g:rc_dir . 'dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif
" プラグインの追加・削除やtomlファイルの設定を変更した後は
" 適宜 call dein#update や call dein#clear_state を呼んでください。
" そもそもキャッシュしなくて良いならload_state/save_stateを呼ばないようにしてください。

" vimprocだけは最初にインストールしてほしい
" if dein#check_install(['vimproc'])
"   call dein#install(['vimproc'])
" endif
" その他インストールしていないものはこちらに入れる
if dein#check_install()
  call dein#install()
endif
" }}}

filetype plugin indent on
syntax enable

set number
set noswapfile
set list
set listchars=tab:^.
set backspace=indent,eol,start
set hlsearch
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set ignorecase
set smartcase
set incsearch
set viminfo='20,\"1000
set clipboard=unnamed
set background=dark
set cursorline
colorscheme Tomorrow-Night-Bright

" let loaded_matchparen = 1

hi clear CursorLine
hi CursorLine ctermbg=239 guibg=black

highlight ZenkakuSpace ctermbg=6
match ZenkakuSpace /\s\+$\|　/

nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Remove end of line spaces
autocmd BufWritePre * :%s/\s\+$//ge
" Tab to space
autocmd BufWritePre * :%s/\t/  /ge

" Syntastic
" autocmd! BufWritePost * Neomake
" let g:syntastic_check_on_wq = 0

autocmd BufRead,BufNewFile *.erb set filetype=eruby.html
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.less set filetype=css
autocmd BufNewFile,BufRead *.scss set filetype=css
autocmd BufNewFile,BufRead *.slim set filetype=slim

" previm
let g:vim_markdown_folding_disabled = 1

" deoplete
let g:deoplete#enable_at_startup = 1

" unite
let g:unite_enable_start_insert = 1
let g:unite_source_file_mru_limit = 200

" mru,reg,buf
nnoremap :um :<C-u>Unite file_mru -buffer-name=file_mru<CR>
nnoremap :ur :<C-u>Unite register -buffer-name=register<CR>
nnoremap :ub :<C-u>Unite buffer -buffer-name=buffer<CR>
nnoremap <C-p> :Unite file_rec/async<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
endif

" to shutdown wiht ESC ESC
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" NerdTree
noremap <silent> <C-e> :NERDTree<CR>

" devdocs
nmap K <Plug>(devdocs-under-cursor)
