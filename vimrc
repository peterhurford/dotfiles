set runtimepath^=~/.vim/bundle/ctrlp.vim                          "ctrlp plugin
execute pathogen#infect()
syntax on
filetype plugin indent on                                         "Turn plugins on

"Easymotion (f searches for letter, F does same, s/S gets normal f/F)
let g:EasyMotion_do_mapping = 0   " Disable default mappings
let g:EasyMotion_smartcase = 1    " Case insensitive
nmap f <Plug>(easymotion-s)
nmap F <Plug>(easymotion-s)
nmap / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-sn)
noremap s f
noremap S F

set nobackup                                                      "no backup files
set nowritebackup                                                 "only in case you don't want a backup file while editing
set noswapfile                                                    "no swap files
set tabstop=2 shiftwidth=2 expandtab smartindent                  "smart tabbing
set number                                                        "Line numbers on
set autoread                                                      "Updates vim file when changed from outside
set magic                                                         "Allows pattern matching with special characters
set wildmenu                                                      "Visual autocomplete for filenames
set lazyredraw                                                    "Only redraw when needed (makes vim faster)
set foldmethod=manual                                             "Turn on folding (use za to toggle a fold)
set scrolloff=10                                                  "Keep 10 lines below cursor (scrolls earlier)
set splitbelow splitright                                         "Splits appear below and to the right>
set backspace=indent,eol,start                                    "Fix backspace"
"startinsert                                                       "Start in insert mode (very useful for Mutt)
2mat ErrorMsg '\%81v.'                                            "Highlight column 81 to enforce style guide

" Map , to leader
let mapleader=","

"don't have to press shift to get : (faster)
nnoremap : ;

"semicolon still works
nnoremap ; :

" arrow keys are slightly different than hjkl, as they move within line.
nnoremap j j^
nnoremap k k^

" jk automove to beginning of line
nnoremap <Down> gj
nnoremap <Up> gk

" Remap movement keys: 0 to front (instead of ^), - to end (instead of $), ^ to beginning (instead of 0)
noremap 0 ^
noremap - $
noremap ^ 0

" Faster moves
" = preforms save, == does save and quit, ctrl+d quit, ctrl+d ctrl+d force quit
nnoremap = :w<CR>
nnoremap == :wq<CR>
nnoremap <C-D> :q<CR>
nnoremap <C-D><C-D> :q!<CR>

" cc is old s (substitute character)
" cb is cw that goes to the beginning of the word 
nnoremap cc s
nnoremap cb bcw

" Quick yanking to the end of the line
nnoremap Y y$

" I can't figure out how to use default ] or [, so let's make it } or {, which is useful.
nnoremap ] }
nnoremap [ {

" ,w toggles wrap
noremap <Leader>w :set wrap! wrap?<CR>

" ,- for horizontal split and ,\ for vertical split, both opening up the tree
noremap <Leader>- :split<CR>
noremap <Leader>\ :vsplit<CR>

" ,t opens a new tab and  tt cycles through tabs (<number>tt moves to that tab number)
noremap <Leader>t :tabnew<CR>
noremap tt gt

" ,xx closes all vim tabs
noremap <Leader>xx :bufdo bd<CR>:q!<CR>

" ,ss creates a vim session (saves files for later opening with vim -S)
noremap <Leader>ss :mksession!<CR>

" v/V restores the old b/B
noremap v b
noremap V B

" ,n toggles relative number
noremap <Leader>n :exec &number==&relativenumber? "set number!" : "set relativenumber!"<CR>

" ,p toggles paste
nnoremap <Leader>p :set paste! paste?<CR>

" ,v resources ~/.vimrc
nnoremap <Leader>v :source ~/.vimrc<CR>

" ,e reloads the file
nnoremap <Leader>e :e

" ,e opens editor (set to current directory)
autocmd BufEnter * lcd %:p:h                              " e . opens in current directory
let g:netrw_browse_split=0                                "Vim explore always opens in current tab on enter
nnoremap <Leader>e :e .<CR>

" ,? toggles laststatus (on by default)
set laststatus=2
noremap <Leader>? :exec &laststatus? "set laststatus=0" : "set laststatus=2"<CR>

" K is more annoying than useful
noremap K <nop>

" Status line is file name, git branch, and whether the file has been modified
set statusline=%F\ %{GitBranch()}\ %m

" Git-vim (,gs shows git status, ,gb shows git blame, and ,gd shows git diff -- without opening a new vim pane, thank you.)
let g:git_no_map_default = 1
noremap <Leader>gs :Git status<CR>
noremap <Leader>gb :GitBlame<CR>
noremap <Leader>gd :Git diff<CR>
noremap <Leader>gl :Git log<CR>

" :S msg uses Git Send Plugin
let g:GitSendPrefix = 'S'

"Vim R (Start R with ,r and send lines with space)
map <Leader>r <Plug>RStart 
vmap <Space> <Plug>RDSendSelection 
nmap <Space> <Plug>RDSendLine
nmap <Leader>rr <Plug>RESendFile
let vimrplugin_assign = 0

"CTRL-P
let g:ctrlp_map = '<C-X>'                                 "Make CTRL-P plugin use CTRL-X instead (faster)

"Faster CTRL-P
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'
