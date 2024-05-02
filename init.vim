:set number
:set relativenumber
call plug#begin()
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/hrsh7th/nvim-cmp'
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
call plug#end()

" Remap for NERDTree
:nnoremap <C-T> :NERDTree

" LSP config-clangd
lua << EOF
  local cmp = require'cmp'
   cmp.setup({
    snippet={
      expand = function(args)
      require('luasnip').lsp_expand(args.body) 
      end
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })
  local c_capabilities = require('cmp_nvim_lsp').default_capabilities()
  require'lspconfig'.clangd.setup{
  capabilities=c_capabilities,
  cmd={'clangd'},
  init_options = {
    clangdFileStatus = true,
    clangdSemanticHighlighting = true, 
    path = 'C:/clangd_18.1.3/bin'
  },
  filetypes={'c','cpp'}
  }
EOF

