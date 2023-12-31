require("which-key").setup()

vim.keymap.set({'n', 'v'}, '<Space>', '<Nop>', {silent = true})

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'",
               {expr = true, silent = true})
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'",
               {expr = true, silent = true})

vim.keymap.set('n', '<leader>F', ':Neoformat<cr>',
               {silent = true, desc = 'Format file'})
vim.keymap.set('n', '<leader>T', ':Telescope resume<cr>',
               {silent = true, desc = 'Telescope'})

-- <leader>t is for Telescope
vim.keymap.set('n', '<leader>tf', ':Telescope find_files<cr>',
               {silent = true, desc = 'Find files'})
vim.keymap.set('n', '<leader>tg', ':Telescope live_grep<cr>',
               {silent = true, desc = 'Live grep'})
vim.keymap.set('n', '<leader>tu', ':Telescope undo<cr>',
               {silent = true, desc = 'File changes history'})


-- <leader>e is for NvimTree
vim.keymap.set('n', '<leader>ee', ':NvimTreeFocus<cr>',
               {silent = true, desc = 'Open NvimTree'})
vim.keymap.set('n', '<leader>eo', ':NvimTreeFindFileToggle<cr>',
               {silent = true, desc = 'Find current file in NvimTree'})

vim.keymap.set('n', '<leader>G', ':Git<cr>',
               {silent = true, desc = 'Git'})
