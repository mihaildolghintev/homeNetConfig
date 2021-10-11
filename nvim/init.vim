call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree'		" NERD Tree
Plug 'Xuyuanp/nerdtree-git-plugin' 	" show git status in Nerd tree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plug 'itchyny/lightline.vim'		" UI
Plug 'hoob3rt/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/fzf', {'do': {-> fzf#install()} }
Plug 'junegunn/fzf.vim'

"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-haml'
Plug 'thoughtbot/vim-rspec'
Plug 'pechorin/any-jump.vim'
Plug 'andymass/vim-matchup'
Plug 'tpope/vim-rbenv'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'vim-test/vim-test'
Plug 'voldikss/vim-floaterm'

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} " Completion as in vscode
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'jiangmiao/auto-pairs'


Plug 'lilydjwg/colorizer'

Plug 'scrooloose/nerdcommenter'		" NERD commenter. Quickly comment lines
Plug 'othree/xml.vim'
Plug 'othree/html5.vim'
Plug 'tpope/vim-surround'

Plug 'alvan/vim-closetag'
Plug 'ap/vim-css-color'

Plug 'yggdroot/indentline'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"Plug 'rakr/vim-one'
"Plug 'tomasr/molokai'
"Plug 'drewtempelmeyer/palenight.vim'
"Plug 'morhetz/gruvbox'
"Plug 'relastle/bluewery.vim'
"Plug 'Rigellute/shades-of-purple.vim'
"Plug 'patstockwell/vim-monokai-tasty'
Plug 'sainnhe/gruvbox-material'
Plug 'projekt0n/github-nvim-theme'
"Plug 'cormacrelf/vim-colors-github'
"Plug 'dracula/vim', {'as': 'dracula'}
"
" Initialize plugin system
call plug#end()

filetype plugin indent on
syntax on


"set termguicolors
set list
set clipboard=unnamedplus
let mapleader = " "
set foldmethod=marker
set mouse=a
set nowrap
set number
set enc=utf-8	" utf-8 by default in files
set ls=2	" show status bar always
set hlsearch	" highlight search
set showtabline=0
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
"highlight LineNr ctermfg=gray
"highlight Pmenu ctermbg=gray guibg=gray " popup autocomplete menu color

"set t_Co=256
"highlight Normal guibg=black guifg=white

set cursorline
set background=dark
"set termguicolors

"let g:molokai_original = 1

"colorscheme bluewery
"colorscheme shades_of_purple
"colorscheme gruvbox
"colorscheme molokai
"colorscheme one
"colorscheme palenight
"colorscheme dracula
"colorscheme gruvbox-material
colorscheme github_dark
nnoremap <A-f> :Ag<CR>
nnoremap <C-p> <cmd>Telescope find_files<CR>
nnoremap <C-u> <cmd>Telescope help_tags<CR>
nnoremap <Leader>m <cmd>Telescope buffers<CR>

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=50


"
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


lua << EOF
require('lualine').setup {
  options = {
    theme = 'github'
    } 
  }
EOF
" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }


let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.tsx,*.re,*.erb'

autocmd BufNewFile,BufRead *.html.erb set filetype=html.eruby


" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


let g:snipMate = { 'snippet_version' : 1 }

let test#strategy = "floaterm"
let g:floaterm_keymap_kill = '<Esc>'
nnoremap   <silent>   <A-Backspace>    :FloatermNew --cwd=<root><CR>

nmap  <leader>tn :TestNearest<CR>
nmap  <leader>tf :TestFile<CR>
nmap  <leader>ts :TestSuite<CR>
nmap  <leader>tl :TestLast<CR>

nmap <leader>cr <Plug>(coc-references)
nmap <C-a> <C-o>
nmap <C-d> <Plug>(coc-definition)
nmap <leader>r <Plug>(coc-rename)
