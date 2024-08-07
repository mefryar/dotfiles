" Maintainer: Michael Fryar <michaelefryar@gmail.com>
"
" Load Vim 8 defaults. This includes `set nocompatible`,
" which loads Vim settings rather than Vi settings.
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" PLUGINS
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Asynchronous Lint Engine
Plug 'dense-analysis/ale'

" Clojure syntax highlighting
Plug 'jrdoane/vim-clojure-highlight'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Rainbow parentheses
Plug 'luochen1990/rainbow'

" Vim as a merge tool
Plug 'samoshkin/vim-mergetool'

" Enable REPL-driven development in Clojure
Plug 'tpope/vim-fireplace'

" Initialize plugin system
call plug#end()

" Set specific linters
let g:ale_linters = {
\  'clojure': ['clj-kondo'],
\  'haml': ['hamllint'],
\  'javascript': ['eslint'],
\  'python': ['flake8', 'pycodestyle'],
\  'ruby': ['rubocop']
\}

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1

" Don't lint when opening a file
let g:ale_lint_on_enter = 0

" Activate rainbow parentheses
let g:rainbow_active = 1

let g:rainbow_conf = {
\	'ctermfgs': ['darkred', 'darkyellow', 'darkgreen', 'darkblue', 'darkmagenta'],
\}

" (b) - for base revision
" (m) - for working tree version of MERGED file
" (r) - for 'remote' revision 
let g:mergetool_layout = 'bmr'
let g:mergetool_prefer_revision = 'unmodified'

" FEATURES
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Copy indent from the current line when starting a new line.
" This is particularly helpful when writing lists in a git commit message.
set autoindent

" Enable syntax highlighting
syntax on

" OPTIONS

" Ensure spell check errors are underlined in red
augroup SpellUnderlineRed
  autocmd!
  autocmd ColorScheme * highlight SpellBad cterm=underline ctermfg=red
augroup END

" Set colorscheme (Use ericbn/vim-solarized)
" (Reminder: iTerm2 -> Settings -> Profiles -> Colors -> Color Presets -> Solarized)
set background=dark
colorscheme solarized

" Set autocomplete to include hyphens
set iskeyword+=\-

" Enable italics
set t_ZH=[3m
set t_ZR=[23m

" Display line numbers on the left
set number

" MAPPINGS
" Notes:
"   - nnoremap indicates a normal mode non-recursive mapping
"   - The default <leader> key is \

" Copy current relative file path (src/foo.txt) to system clipboard
nnoremap <leader>cf :let @*=expand("%")<CR>

" Copy (yank) to system clipboard
noremap <Leader>y "*y

" Paste from system clipboard
noremap <Leader>p "*p

" AUTOCOMMANDS
" Put these in an autocmd group, so that we can delete them easily.
augroup vimrc
  autocmd!

  function MarkdownSettings()
    " Wrap text at 80 characters
    setlocal textwidth=80

    " Check spelling
    setlocal spell
  endfunction
  
  function GitCommitSettings()
    " Always start on first line
    call setpos('.', [0, 1, 1, 0])

    " Wrap text at 72 characters
    setlocal textwidth=72

    " Check spelling
    setlocal spell
  endfunction
  autocmd FileType markdown call MarkdownSettings()
  autocmd FileType gitcommit call GitCommitSettings()
augroup END

" PACKAGES
" The matchit plugin makes the % command work better by supporting
" cycling between if, else if, else, endif keywords in various programming
" languages. It is not backwards compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
