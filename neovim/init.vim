call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTree' }
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'raimondi/delimitmate'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"Plug 'EdenEast/nightfox.nvim'
Plug 'sainnhe/edge'
Plug 'neovim/nvim-lspconfig'

" Install nvim-cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

call plug#end()

let mapleader = ","

" Quit all
map <Leader>q :qa<CR>

" Save all
map <Leader>w :wa<CR>

" Hex view
map <Leader>h :%!xxd<CR>
map <Leader>H :%!xxd -r<CR>

" Select all
map <Leader>a ggVG

" Adjust window size
map <Leader>< :10winc <<CR>
map <Leader>> :10winc ><CR>

" Move tabs
map <Leader>N :tabm -1<CR>
map <Leader>M :tabm +1<CR>

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Customization
colorscheme edge
"let g:airline_powerline_fonts = 1

lua << EOF
require 'lspconfig'.pylsp.setup{}
EOF

lua <<EOF
vim.o.completeopt = 'menuone,noselect'
local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup({
snippet = {
	expand = function(args)
		vim.fn["luasnip"].lsp_expand(args.body)
	end,
},
mapping = {
	['<C-p>'] = cmp.mapping.select_prev_item(),
	['<C-n>'] = cmp.mapping.select_next_item(),
	['<C-d>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.close(),
	['<CR>'] = cmp.mapping.confirm {
	behavior = cmp.ConfirmBehavior.Replace,
		select = true,
	},
	['<Tab>'] = function(fallback)
	if vim.fn.pumvisible() == 1 then
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
	elseif luasnip.expand_or_jumpable() then
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
	else
		fallback()
	end
	end,
	['<S-Tab>'] = function(fallback)
		if vim.fn.pumvisible() == 1 then
			vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
		elseif luasnip.jumpable(-1) then
			vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
		else
			fallback()
		end
	end,
},
sources = {
	{ name = 'nvim_lsp' },
	{ name = 'luasnip' },
}
})
EOF
