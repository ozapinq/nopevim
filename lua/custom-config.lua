vim.cmd('colorscheme gruvbox')

vim.o.cursorline = true
-- Set leader to SPACE
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight',
                                                    {clear = true})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = highlight_group,
    pattern = '*'
})

--------------------------------------------------------------------------------
-- Plugins                                                                    --
--------------------------------------------------------------------------------

require('lualine').setup()
require('Comment').setup()
require('indent_blankline').setup()
require('fidget').setup()
require('nvim-autopairs').setup()
require('colorizer').setup()
require('nvim-treesitter.configs').setup({})
require('nvim-web-devicons').setup()
require("toggleterm").setup({open_mapping = [[<c-\>]], terminal_mappings = true})
require('todo-comments').setup()
require('alpha').setup(require('alpha.themes.startify').config)
require('modicator').setup()

require('config_keymap')
require('config_gitsigns')
require('config_lsp')
require('config_telescope')
require('config_nvimtree')

vim.cmd('COQnow --shut-up')
