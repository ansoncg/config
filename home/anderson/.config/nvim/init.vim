" ------------------------------------------------------------------------------
" Plugins 

" To see startup time:
" nvim --startuptime a.out

call plug#begin()

" Alinhar texto
Plug 'godlygeek/tabular'
" Plug 'junegunn/vim-easy-align'

" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Desliga o caps quando sai do insert
" Plug 'suxpert/vimcaps'

" Icones
Plug 'kyazdani42/nvim-web-devicons' "For barbar icons
" Plug 'ryanoasis/vim-devicons'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Arquivos
Plug 'kevinhwang91/rnvimr', {'branch': 'main'}
" Plug 'mcchrish/nnn.vim'
" Plug 'kyazdani42/nvim-tree.lua'
" Plug 'preservim/nerdtree'

" Tabline
Plug 'romgrk/barbar.nvim'
" Plug '/vim-airline/vim-airline'

" Statusline
Plug 'hoob3rt/lualine.nvim'

" Theme
Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'tomasiser/vim-code-dark'

" Conseguir mudar coisas dentro de simbolos
Plug 'tpope/vim-surround'

" Arvore de undo
Plug 'simnalamburt/vim-mundo'

" Atalhos para comentar linhas / Atalho -> gcc
Plug 'tpope/vim-commentary'

" Movimentação melhor
" Plug 'easymotion/vim-easymotion'
Plug 'phaazon/hop.nvim'

" Melhor parser para highlight 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Corretor sintatico usando LanguageTool
" Plug 'rhysd/vim-grammarous'

" Completion tab
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'
" Try coq if you need more speed
" Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}

" Guias de indentanção
Plug 'lukas-reineke/indent-blankline.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer', {'branch': 'main'}
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'tami5/lspsaga.nvim', {'branch': 'main'}

" Snippets
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets', {'branch': 'main'}
" Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
" Plug 'SirVer/ultisnips'
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'
" Plug 'honza/vim-snippets'

" Pagina de inicio
Plug 'mhinz/vim-startify'

" Multifile Search
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" LaTeX
Plug 'lervag/vimtex'

" GLSL
" Plug 'tikhomirov/vim-glsl'

" AI code helper 
Plug 'github/copilot.vim'
" Plug 'hrsh7th/cmp-copilot'
" Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

" Online code helper
Plug 'dbeniamine/cheat.sh-vim'

" Send code to vim terminal
Plug 'mtikekar/nvim-send-to-term'

" To Install
" Plug 'jupyter-vim/jupyter-vim'
" flake8

call plug#end()

" --------------------------------------------------------------------------------
" Sets
lua require("init")

" autocmd BufEnter * lcd %:p:h
set autochdir

" Abre vsplit na direita
set splitright

" Mostrar numeros de linhas
set number

" Tira a telinha de inicio
set shortmess+=I

" Deixa buffer aberto -> Não vou lembrar o que é -> google it
" Sem hidden nao da para trocar de buffer enquanto nao salvar
set hidden

" Busca progressiva
set incsearch

" Atualiza arquivo ao muda-lo por fora
set autoread

" Suporte ao mouse
set mouse+=a

" Usar espaços no lugar do tab
set expandtab

" Não importa o case
set ignorecase

" Faz importar o case se tiver maiscula na busca
set smartcase

" Tira os highlights das buscas
set nohlsearch 

" Completion menu
set completeopt=menuone,noselect
" set completeopt=menuone,noinsert,noselect,preview
" set completeopt=menuone,noinsert

"Não passar de 80 para caber no vsplit
" set colorcolumn=81

" PEP8 limite de 79 por linha
" au BufRead,BufNewFile *.py set colorcolumn=80

" Tab size
set tabstop=4
set shiftwidth=4

" Highlight na linha
set cursorline

let g:vim_markdown_folding_disabled = 1

" Highlight na coluna
" set cursorcolumn

" Numero relativo nas linhas
" set relativenumber

" Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)

" --------------------------------------------------------------------------------

" Fold tree sitter
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" Andando nas divisoes
nnoremap <Up>        <C-W>+
nnoremap <Down>      <C-W>-
nnoremap <Left>      <C-W><
nnoremap <Right>     <C-W>>

" Movendo as divisoes
nnoremap <S-Up>      <C-W>K
nnoremap <S-Down>    <C-W>J
nnoremap <S-Left>    <C-W>H
nnoremap <S-Right>   <C-W>L

" jk é bem mais facil que esc 
inoremap jk <Esc>
inoremap JK <Esc>
inoremap Jk <Esc>

" Plugin Undo
nnoremap <A-u> :MundoToggle<CR>

" Plugin Files
nnoremap <A-r> :RnvimrToggle<CR>
" nnoremap <A-n> :NnnPicker<CR>
" nnoremap <A-t> :NERDTreeToggle<CR>
" nnoremap <A-r> :NERDTreeCWD<CR>

let mapleader = "," " Leader na virugla

" Remap para facilitar o uso de marcas
nmap ç '

" Salvar no ctrl s
nnoremap <c-s> :w<CR>
inoremap <c-s> <Esc>:w<CR>
vnoremap <c-s> <Esc>:w<CR>

vnoremap <silent><c-s> <c-c>:update<cr>gv
inoremap <silent><c-s> <c-o>:update<cr>

map <silent> Q :close <CR>

" Yank do resto da linha
nnoremap Y y$

" Open header file (Clangd)
nmap gh :vsp <CR> :ClangdSwitchSourceHeader<CR> 

" Troca Netrw pelo ranger
let g:rnvimr_enable_ex = 1

" Spaces to new lines
nmap <Leader>b :s/\s\+/\r/g<CR>
nmap <Leader>a :s/\s\+/\r/g<CR> :'[,sort<CR>  :,']j<CR>     

" --------------------------------------------------------------------------------
" Usando o caps com map do simbolo de copyright

" Copy
nmap ©c "+yy
vmap ©c "+y

" Paste
nmap ©v "+p
imap ©v <Esc>"+pa

" Start
nmap ©s :Startify<CR>

nmap ©8 "8p
nmap ©9 "9p
nmap ©0 "0p
imap ©8 <Esc>"8p
imap ©9 <Esc>"9p
imap ©0 <Esc>"0p

imap ©e é
imap ©E É
imap ©o ó

" --------------------------------------------------------------------------------
" Visual -------------------------

" Cores mais fieis 
set termguicolors

" Theme
colorscheme dracula
let g:indent_blankline_use_treesitter = v:true

":hi to see list
hi DraculaOrangeItalic gui=NONE
hi DraculaCyanItalic gui=NONE
hi DraculaPurpleItalic gui=NONE
hi DraculaGreenItalic gui=NONE
hi CursorLine ctermbg=237 guibg=#343746

" Cor do barbar quando muda o arquivo, tava transparente
hi BufferCurrentMod guifg=#FFB86C
hi BufferVisibleMod guifg=#FFB86C

" Barbar fill same color as polybar
hi BufferTabPageFill guibg=#282a36

" Borda do ranger
let g:rnvimr_border_attr = {'fg': 8, 'bg': -1}

" --------------------------------------------------------------------------------
" Corretor -------------------------- 
 
"set spell spelllang=pt,en "<- Spellcheck nativo do vim, precisa adicionar um
"dicionario. pt-br -> VERO

"Corretor usando o LanguageTool, consegue ver erros sintaticos
" nmap <Leader>c <Plug>(grammarous-open-info-window)
" nmap <Leader>x <Plug>(grammarous-fixit)
" nmap <Leader>a <Plug>(grammarous-fixall)
" nmap <Leader>p :GrammarousCheck --lang=pt-BR<CR>
" nmap <Leader>e :GrammarousCheck --lang=en-US<CR>

" --------------------------------------------------------------------------------
" Easy motion / Hop -------------------

" s{char}{char} to move to {char}{char}
" 2 char search

" map s <Plug>(easymotion-overwin-f2)
map s :HopChar2 <CR>
map S :HopChar1 <CR>

" --------------------------------------------------------------------------------
" Barbar -------------------------- 
"
" Move to previous/next
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>

" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>

" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>
nnoremap <silent>    <A-c> :BufferClose<CR>

" Magic buffer-picking mode
nnoremap <silent> <A-s>    :BufferPick<CR>

let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
let bufferline.closable = v:false

" --------------------------------------------------------------------------------
" Startify

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Recent']         },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_bookmarks = [
            \ { 'l': '~/.config/nvim/lua/init.lua' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'u': '~/files/usp/usp.md' },
            \ { 'h': '~/' },
            \ ]

let g:startify_files_number = 9
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1
let g:startify_update_oldfiles = 1
let g:startify_relative_path = 1
let g:startify_session_sort = 1
let g:startify_custom_indices = map(range(1,100), 'string(v:val)')

nmap <A-q> :SSave Temp Session<CR>y

" --------------------------------------------------------------------------------
" Telescope

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fd <cmd>Telescope diagnostics<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope commands<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>

" --------------------------------------------------------------------------------
" LSP Saga

nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent><leader>rn :Lspsaga rename<CR>
nnoremap <silent><leader>gs :Lspsaga signature_help<CR>
nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>

" --------------------------------------------------------------------------------
" Ranger 

let g:rnvimr_layout = {
           \ 'relative': 'editor',
           \ 'width': &columns - 15,
           \ 'height': &lines - 5,
           \ 'col': 7,
           \ 'row': 2,
           \ 'style': 'minimal'
           \ }

let g:rnvimr_presets = [ {'width': 0.900, 'height': 0.900} ]
autocmd VimEnter * :RnvimrStartBackground

" Ranger launch command
" let g:rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both" --cmd="set preview_images false"'

" --------------------------------------------------------------------------------
" Copilot 

" let g:copilot_no_tab_map = v:true
" let g:copilot_assume_mapped = v:true
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" --------------------------------------------------------------------------------
" Python envs

" Select the python path
" let g:python3_host_prog = '/path/to/python3'

" --------------------------------------------------------------------------------
" Send to terminal 

let g:send_disable_mapping = v:true
nmap <Leader>ss <Plug>SendLine
nmap <Leader>s <Plug>Send
vmap <Leader>s <Plug>Send

tnoremap <C-w>w <C-\><C-n><C-w>w
tnoremap <C-w><C-w> <C-\><C-n><C-w>w
" tnoremap <C-w>h <C-\><C-n><C-w>h
" tnoremap <C-w>l <C-\><C-n><C-w>l
" tnoremap <C-w>j <C-\><C-n><C-w>j
" tnoremap <C-w>k <C-\><C-n><C-w>k

" --------------------------------------------------------------------------------

" Save path, open new vsplit, open new terminal, run SendHere, insert mode, cd
" to the path, exec python, clean screen with CTRL l, switch to original
" buffer. (MAKE THIS SOMETHING BETTER THAN A MAP)
nmap <leader>p :let $VIM_DIR=expand('%:p:h')<CR>:vsplit<CR>:terminal<CR>:SendHere<CR>i cd $VIM_DIR<CR>exec python<CR><C-l><C-w>w
