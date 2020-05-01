call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree'		" NERD Tree
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdcommenter'		" NERD commenter. Quickly comment lines
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'itchyny/lightline.vim'		" UI

if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} " Completion as in vscode
Plug 'jiangmiao/auto-pairs'


Plug 'lilydjwg/colorizer'
Plug 'LnL7/vim-nix'

Plug 'sbdchd/neoformat'


" elixir
Plug 'elixir-editors/vim-elixir'
"Plug 'elixir-lang/vim-elixir'
Plug 'carlosgaldino/elixir-snippets'

Plug 'herringtondarkholme/yats.vim' 	" Typescript syntax
Plug 'maxmellon/vim-jsx-pretty'
"
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'othree/xml.vim'
Plug 'othree/html5.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'tpope/vim-surround'

Plug 'alvan/vim-closetag'
Plug 'ap/vim-css-color'

Plug 'ryanoasis/vim-devicons'

Plug 'yggdroot/indentline'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'sainnhe/forest-night'
"Plug 'rakr/vim-one'
"Plug 'tomasr/molokai'
"Plug 'drewtempelmeyer/palenight.vim'
"Plug 'morhetz/gruvbox'
"Plug 'relastle/bluewery.vim'
"Plug 'Rigellute/shades-of-purple.vim'
"Plug 'patstockwell/vim-monokai-tasty'
"Plug 'sainnhe/gruvbox-material'
"Plug 'arcticicestudio/nord-vim'
"Plug 'dracula/vim', {'as': 'dracula'}
"
" Initialize plugin system
call plug#end()

"filetype plugin indent on
syntax on

""""Enconding
set encoding=utf-8	" utf-8 by default in files
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

"" Map leader to
let mapleader = "f"

"" Searching
set hlsearch	" highlight search
set incsearch
set ignorecase
set smartcase

"set termguicolors
set list
set foldmethod=marker
set mouse=a
set nowrap
set number
set ls=2	" show status bar always
set showtabline=0
"highlight LineNr ctermfg=gray
"highlight Pmenu ctermbg=gray guibg=gray " popup autocomplete menu color

set t_Co=256

set cursorline
"set guifont=Fura\ Code:h14
set termguicolors

"let g:molokai_original = 1

"colorscheme bluewery
"colorscheme shades_of_purple
"colorscheme gruvbox
"colorscheme molokai
"colorscheme one
"colorscheme palenight
"colorscheme dracula
"colorscheme gruvbox-material
colorscheme forest-night
"colorscheme nord

""FZF
nnoremap <silent> <leader>e :FZF -m<CR>
nmap <leader>y :History:<CR>
let g:fzf_history_dir = '~/.local/share/fzf-history'

map <C-n> :NERDTreeToggle<CR>
map <Tab> :NERDTreeFocusToggle<CR>
let g:NERDTreeWinSize=50


let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

au BufRead,BufNewFile *.eex set filetype=html.eelixir

set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signc

set signcolumn=yes

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'forest_night',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }


let g:prettier#config#print_width = 90
let g:prettier#config#tab_width = 2
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'false'
let g:prettier#config#parser = 'typescript'

let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.tsx,*.re,*.eex'


"Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
nmap <leader>f :Format<CR>
"nmap <leader>f :Neoformat! elixir<CR>



" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"


"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif
