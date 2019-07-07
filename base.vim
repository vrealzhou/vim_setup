set nu
set background=dark
set t_Co=256
let mapleader = ","
let g:completor_gocode_binary = '$GOPATH/bin/gocode'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set clipboard=unnamed
set bs=2
set autowrite
set laststatus=2

let g:go_list_type = "quickfix"

filetype plugin on

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

let g:go_fmt_command = "goimports"

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
   set pastetoggle=<Esc>[201~
   set paste
return ""
endfunction

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Golang
" Enabling GoMetaLinter on save
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"
autocmd Filetype go setlocal tabstop=4
autocmd Filetype go setlocal shiftwidth=4

call plug#begin('~/.vim/plugged')
" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" GraphQL
Plug 'jparise/vim-graphql'
" Completor
" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'maralla/completor.vim'
Plug 'masawada/completor-dictionary'
Plug 'ferreum/completor-tmux'

Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'

" Tree
Plug 'scrooloose/nerdtree'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Colors
Plug 'fatih/molokai'
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'

" Search tools
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'

call plug#end()

let g:rehash256 = 1
let g:molokai_original = 1
colorscheme gruvbox

map <C-p> :FZF<CR>
map <C-f> :Find 
map <C-t><C-n> :tabnew 
map tt :NERDTreeToggle<CR>
imap <S-Tab> <Esc>

command CargoBuild execute "!cargo build"
command CargoRun execute "!cargo run"
command RustFmt execute "silent !rustfmt %" | execute 'redraw!'

command -nargs=+ Replace :call MyReplace(<f-args>)

function MyReplace(before, after)
    :execute ",$s/".a:before."/".a:after."/gc|1,''-&&"
endfunction

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

set grepprg=rg\ --vimgrep

" lightline
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
