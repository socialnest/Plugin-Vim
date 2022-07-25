set number
set nocompatible
set expandtab
set autoindent
set softtabstop=4
set shiftwidth=2
set tabstop=4

"Enable mouse click for nvim
set mouse=a
"Fix cursor replacement after closing nvim
set guicursor=a:hor20-Cursor
set guifont=FiraCode-Retina:29
"Shift + Tab does inverse tab
inoremap <S-Tab> <C-d>


set encoding=utf-8

set pyxversion=3
"Or"
set pyxversion=2
set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{LinterStatus()}

"Python 2 executable file location
let g:python_host_prog = "/usr/bin/python2"
"Python 3 executable file location
let g:python3_host_prog = "/usr/bin/python3"
let g:ruby_host_prog = "/usr/local/bin/neovim-ruby-host"
let g:deoplete#auto_complete=1
" .vimrc
let g:auto_save = 1  " enable AutoSave on Vim startup
set rtp+=~/.vim/bundle/Vundle.vim
set runtimepath+=~/.vim/bundle/deoplete.nvim/
set runtimepath+=~/.vim/bundle/deoplete-jedi/
set runtimepath+=~/.vim/bundle/nvim-yarp/
set runtimepath+=~/.vim/bundle/vim-hug-neovim-rpc/
set runtimepath+=~/.config/nvim/node_modules/coc-pyright
set runtimepath+=~/.vim/bundle/coc.nvim/
call vundle#begin()
if has('nvim')
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'preservim/nerdtree'
Plugin 'mhartington/oceanic-next'
Plugin 'ryanoasis/vim-devicons'
Plugin 'Shougo/deoplete.nvim', { 'do': ':Upd    ateRemotePlugins' }
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-ruby/vim-ruby'
Plugin 'etordera/deoplete-ruby'
Plugin 'jiangmiao/auto-pairs'
Plugin  'dense-analysis/ale'
Plugin 'machakann/vim-highlightedyank'
Plugin 'thaerkh/vim-workspace'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
else
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'zchee/deoplete-jedi'
Plugin 'deoplete-plugins/deoplete-jedi'
" Track the engine.

" Snippets are separated from the engine. Add this if you want them:
endif

call vundle#end()
filetype plugin indent on

let g:workspace_autocreate = 1

let g:deoplete#enable_at_startup = 1

let g:coc_global_extensions = ['coc-solargraph']

hi HighlightedyankRegion cterm=reverse gui=reverse
" set highlight duration time to 1000 ms, i.e., 1 second
let g:highlightedyank_highlight_duration = 1000
let g:coc_global_extensions = ['coc-pyright']

" Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')
  " Use CTRL-S for selections ranges.
  " Requires 'textDocument/selectionRange' support of language server.
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

nnoremap <F9> :silent execute "! /usr/local/bin/black % &" <bar> redraw!<CR>

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

inoremap <expr><C-n> deoplete#mappings#manual_complete()

let g:ale_python_flake8_options= '--max-line-length=88'

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction 

"colorscheme
if (has("termguicolors"))
 set termguicolors
endif

syntax enable
colorscheme OceanicNext


"nerdtree
map <C-b> :NERDTreeToggle<CR>


let g:ale_linters = {
      \   'ruby': ['standardrb', 'rubocop'],
      \   'python': ['flake8', 'pylint'],
      \  'json': ['jsonlint'],
      \}


let g:ale_fixers = {
      \    'ruby': ['rubocop'],
      \    'python': ['flake8'],
      \}
let g:ale_fix_on_save = 1

" Enable completion where available.
" This setting must be set before ALE is loaded.
if has('gui_running')
    set guifont=Droid\ Sans\ Mono\ Slashed\ for\ Powerline
  endif

let g:airline_powerline_fonts = 1


let g:airline_theme='tomorrow'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = '»'
let g:airline_left_alt_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '«'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.readonly = '∥'
let g:airline_symbols.paste = 'ρ'

let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'


" 
"
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
let g:ale_completion_enabled = 1

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

inoremap <leader>e <esc>:ALENext<cr>
nnoremap <leader>e :ALENext<cr>
inoremap <leader>p <esc>:ALEPrevious<cr>
nnoremap <leader>p :ALEPrevious<cr>

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
        \   '😞 %dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction 
