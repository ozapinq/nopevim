require('gitsigns').setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, {expr = true, desc = "Next change"})

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, {expr = true, desc = "Previous change"})

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk, {desc = "Stage change"})
        map('n', '<leader>hu', gs.undo_stage_hunk,
            {desc = "Undo stage of change"})
        map('n', '<leader>hr', gs.reset_hunk, {desc = "Reset change"})
        map('v', '<leader>hs',
            function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('v', '<leader>hr',
            function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', '<leader>hS', gs.stage_buffer, {desc = "Stage buffer"})
        map('n', '<leader>hR', gs.reset_buffer, {desc = "Reset buffer"})
        map('n', '<leader>hp', gs.preview_hunk, {desc = "Preview change"})
        map('n', '<leader>hb', function() gs.blame_line {full = true} end,
            {desc = "Blame current line"})
        map('n', '<leader>htb', gs.toggle_current_line_blame,
            {desc = "Toggle blame"})
        map('n', '<leader>hd', gs.diffthis, {desc = "Diff this"})
        map('n', '<leader>hD', function() gs.diffthis('~') end)
        map('n', '<leader>htd', gs.toggle_deleted, {desc = "Toggle deleted"})

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
})
