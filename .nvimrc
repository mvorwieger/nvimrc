call plug#begin('~/.local/share/nvim/plugged')

set nocompatible              
filetype off                 

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin("~/.config/nvim/bundle")

"HELLO GITHUB

Plug 'HerringtonDarkholme/yats.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'parsonsmatt/intero-neovim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh', 'for': ['typescript', 'typescript.tsx']}
Plug 'leafgarland/typescript-vim', {'for': ['typescript', 'typescript.tsx']}
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/denite.nvim'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'zchee/deoplete-clang'
Plug 'tpope/vim-surround'
Plug 'cloudhead/neovim-fuzzy'
Plug 'juanpabloaj/vim-pixelmuerto'
Plug 'sbdchd/neoformat'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'ncm2/ncm2'
Plug 'Quramy/tsuquyomi'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'

call plug#end()
call glaive#Install()

"============AUTOFORMATTING OMEGALUL========================="
autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd BufNewFile,BufRead *.tsx,*,jsx set filetpye=typescript.tsx
set completeopt=noinsert,menuone,noselect
augroup autoformat_settings
autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript, typescript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
augroup END

" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1
filetype plugin indent on

"============== Vim Settings ===============
set tabstop=4
set shiftwidth=4
set expandtab
set incsearch
set showmode
set nocompatible
filetype on
set wildmenu
set ruler
set lz
set hid
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set cindent
set ai
set si
set cin
set mouse=a
set cursorline
set numberwidth=6
set encoding=utf-8
set noswapfile
set number
set nowrap
set rnu
syntax on

"================ IGNORE FILES =================
set wildignore+=*/node_modules/*,*/dist/*,*/__pycache__/*
set wildignore+=*.o
set wildignore+=moc_*.cpp,moc_*.h
set wildignore+=moc_*.cpp,moc_*.h
set wildignore+=*/Assets/*.meta
if &t_Co == 256
        " If we're on a 256-color terminal, use pixelmuerto color scheme
	 colorscheme pixelmuerto
else
                 " Else fall back to ron
	colorscheme ron
endif

set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | FormatCode
augroup END

"=============Key Setups=============
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>
nnoremap <Space> :FuzzyOpen<CR>
imap jk <Esc>

" Haskell Starts here
let g:haskell_classic_highlighting = 1
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2
let g:haskell_indent_case_alternative = 1
let g:cabal_indent_section = 2
" Automatically reload on save
au BufWritePost *.hs InteroReload

" Lookup the type of expression under the cursor
au FileType haskell nmap <silent> <leader>t <Plug>InteroGenericType
au FileType haskell nmap <silent> <leader>T <Plug>InteroType
" Insert type declaration
au FileType haskell nnoremap <silent> <leader>ni :InteroTypeInsert<CR>
" Show info about expression or type under the cursor
au FileType haskell nnoremap <silent> <leader>i :InteroInfo<CR>

" Open/Close the Intero terminal window
au FileType haskell nnoremap <silent> <leader>nn :InteroOpen<CR>
au FileType haskell nnoremap <silent> <leader>nh :InteroHide<CR>

" Reload the current file into REPL
au FileType haskell nnoremap <silent> <leader>nf :InteroLoadCurrentFile<CR>
" Jump to the definition of an identifier
au FileType haskell nnoremap <silent> <leader>ng :InteroGoToDef<CR>
" Evaluate an expression in REPL
au FileType haskell nnoremap <silent> <leader>ne :InteroEval<CR>

" Start/Stop Intero
au FileType haskell nnoremap <silent> <leader>ns :InteroStart<CR>
au FileType haskell nnoremap <silent> <leader>nk :InteroKill<CR>

" Reboot Intero, for when dependencies are added
au FileType haskell nnoremap <silent> <leader>nr :InteroKill<CR> :InteroOpen<CR>

" Managing targets
" Prompts you to enter targets (no silent):
au FileType haskell nnoremap <leader>nt :InteroSetTargets<CR>

" Haskell ends here
