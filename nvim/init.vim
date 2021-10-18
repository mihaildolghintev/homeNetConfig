call plug#begin('~/.config/nvim/plugged')

Plug 'kyazdani42/nvim-tree.lua'
Plug 'Xuyuanp/nerdtree-git-plugin' 	" show git status in Nerd tree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/fzf', {'do': {-> fzf#install()} }
Plug 'junegunn/fzf.vim'

"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-repeat'
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

Plug 'jiangmiao/auto-pairs'


Plug 'lilydjwg/colorizer'

Plug 'scrooloose/nerdcommenter'		" NERD commenter. Quickly comment lines
Plug 'tpope/vim-commentary'
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
"Plug 'projekt0n/github-nvim-theme'
"Plug 'https://gitlab.com/yorickpeterse/vim-paper.git'
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

set relativenumber
set lazyredraw
set splitright
"highlight LineNr ctermfg=gray
"highlight Pmenu ctermbg=gray guibg=gray " popup autocomplete menu color

set t_Co=256
"highlight Normal guibg=black guifg=white

set cursorline
set background=dark
set termguicolors

"let g:molokai_original = 1

"colorscheme bluewery
"colorscheme shades_of_purple
"colorscheme gruvbox
"colorscheme molokai
"colorscheme one
"colorscheme palenight
"colorscheme dracula
colorscheme gruvbox-material
"colorscheme paper
"colorscheme github_dark
nnoremap <A-f> :Ag<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-u> :Tags<CR>
nnoremap <C-o> :Rg<CR>
nnoremap <Leader>m :Buffers<CR>


nnoremap <A-j> <c-w>j
nnoremap <A-k> <c-w>k
nnoremap <A-h> <c-w>h
nnoremap <A-l> <c-w>l
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'



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



lua<< EOF
require'nvim-tree'.setup({
view = {
    width = 40
  }
})
EOF

lua<< EOF
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}
EOF

lua << EOF
require('lualine').setup {
  options = {
    theme = 'gruvbox'
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

let test#strategy = "neovim"
let test#neovim#term_position = "topleft"
let test#neovim#term_position = "vert"
" let test#neovim#term_position = "vert botright 30"
let g:floaterm_keymap_kill = '<A-g>'
nnoremap   <silent>   <A-Backspace>    :FloatermNew --cwd=<root><CR>

nmap  <leader>tn :TestNearest<CR>
nmap  <leader>tf :TestFile<CR>
nmap  <leader>ts :TestSuite<CR>
nmap  <leader>tl :TestLast<CR>

nmap <leader>cr <Plug>(coc-references)
nmap <C-a> <C-o>
nmap <C-d> <Plug>(coc-definition)
nmap <leader>r <Plug>(coc-rename)

let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_gitignore = 1 "0 by default
let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
let g:nvim_tree_create_in_closed_folder = 0 "1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
let g:nvim_tree_refresh_wait = 500 "1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'notify',
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen, NvimTreeClose, NvimTreeFocus and NvimTreeResize are also available if you need them

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue
