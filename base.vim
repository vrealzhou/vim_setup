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
"Language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'mattn/webapi-vim'

" Golang
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" GraphQL
Plug 'jparise/vim-graphql'

Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'

" Tree
Plug 'scrooloose/nerdtree'

" Colors
Plug 'fatih/molokai'
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'

" Search tools
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'

call plug#end()

" Language server
" Required for operations modifying multiple buffers like rename.
set hidden

" coc config
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [\ :lprev<CR>
nmap <silent> ]\ :lnext<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)
autocmd User CocGitStatusChange {command}
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
" autocmd BufWritePre *.rs :call CocAction('runCommand', 'editor.action.organizeImport')

let g:rehash256 = 1
let g:molokai_original = 1
colorscheme gruvbox

map <C-p> :FZF<CR>
map <C-f> :Find 
map <C-t><C-n> :tabnew 
map tt :NERDTreeToggle<CR>
imap <S-Tab> <Esc>
nmap <C-t><C-b> :TagbarToggle<CR>

let g:rust_clip_command = 'pbcopy'

command -nargs=+ Replace :call MyReplace(<f-args>)

" Markdown preview
autocmd BufEnter *.md exe 'nnoremap <C-m><C-p> :silent update<Bar>silent !open -a Google\ Chrome %:p &<CR> :redraw!<CR>'

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
      \   'left': [ 
      \     [ 'mode', 'paste' ],
      \     [ 'ctrlpmark', 'git', 'diagnostic', 'cocstatus', 'filename', 'method' ]
      \   ],
      \   'right':[
      \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
      \     [ 'blame' ]
      \   ],
      \ },
      \ 'component_function': {
      \   'blame': 'LightlineGitBlame',
      \   'cocstatus': 'LightlineGitStatus'
      \ },
      \}

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

function! LightlineGitStatus() abort
  let status = get(g:, 'coc_git_status', '')
  " return status
  return winwidth(0) > 120 ? status : ''
endfunction
