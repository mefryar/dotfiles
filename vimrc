" Maintainer: Michael Fryar <michaelefryar@gmail.com>
"
" Sources:
"   - vimrc_example.rc
"   - https://vim.fandom.com/wiki/Example_vimrc

" Get the defaults that most users want. This includes `set nocompatible`,
" which loads Vim settings rather than Vi settings.
source $VIMRUNTIME/defaults.vim

" FEATURES

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

" OPTIONS

" Set colorscheme
set background=dark
colorscheme solarized

" Display line numbers on the left
set number

" AUTOCOMMANDS
" Put these in an autocmd group, so that we can delete them easily.
augroup vimrc
  au!

  " For all gitcommit files, wrap text at 72 characters.
  autocmd FileType gitcommit setlocal textwidth=72
augroup END

