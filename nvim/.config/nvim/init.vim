if (!isdirectory(expand("$HOME/.local/share/nvim/site/autoload")))
    call system(expand("curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"))
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'frankier/neovim-colors-solarized-truecolor-only'

Plug 'sbdchd/neoformat'
Plug 'terryma/vim-multiple-cursors'

Plug 'HerringtonDarkholme/yats.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim'

Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'leafgarland/typescript-vim'

Plug 'purescript-contrib/purescript-vim'

call plug#end()

" settigs
" set termguicolors
set number
set nopaste
set tabstop=2       " The width of a TAB is set to 2.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 2.
set shiftwidth=2    " Indents will have a width of 2
set softtabstop=2   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces
set encoding=utf-8
set termencoding=utf-8
set clipboard+=unnamedplus

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Theme
syntax enable

let base16colorspace=256
set termguicolors
colorscheme base16-tomorrow-night

" airline
let g:airline_theme = 'minimalist'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
set laststatus=2

let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 239
let g:indentLine_char = '|'

" code formatting
nnoremap <silent>f :Neoformat<CR>

"--no-semi --single-quote --write
let g:standard_prettier_settings = {
  \ 'exe': 'prettier',
  \ 'args': ['--stdin', '--parser typescript', '--no-semi', '--single-quote', '--write'],
  \ 'stdin': 1,
\ }

" typescript
let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option({'max_list': 5})

let g:nvim_typescript#max_completion_detail = 5

let g:neoformat_typescript_prettier = g:standard_prettier_settings
let g:neoformat_enabled_typescript = ['prettier']
