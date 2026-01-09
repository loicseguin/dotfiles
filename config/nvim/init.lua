vim.g.mapleader = vim.keycode("<space>")     -- Set <space> as the leader key
vim.g.maplocalleader = vim.keycode("<space>")

vim.cmd.colorscheme 'retrobox'  -- Almost as good as gruvbox
vim.o.signcolumn = "yes" -- always show sign column

vim.o.expandtab = true   -- Replace tabs with spaces
vim.o.textwidth = 80     -- Wrap text at 80 characters
vim.o.tabstop = 4        -- Four spaces for tab
vim.o.shiftwidth = 0     -- use same value as tabstop
vim.o.softtabstop = -1   -- use same value as shiftwidth

vim.o.updatetime = 400   -- shorter update time to save to swap
vim.o.undofile = true    -- enable persistent undo

-- Fugitive plugin keymaps
vim.keymap.set('n', '<leader>gs', ':Git<CR>', { silent = true, desc = 'Git status' })
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { silent = true, desc = 'Git commit' })
vim.keymap.set('n', '<leader>gd', ':Gdiff<CR>', { silent = true, desc = 'Git diff' })
vim.keymap.set('n', '<leader>gl', ':Glog<CR>', { silent = true, desc = 'Git log' })
vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { silent = true, desc = 'Git push' })

-- LSP keymaps
vim.keymap.set('n', '<leader>lf', ':lua vim.lsp.buf.format()<CR>', { silent = true, desc = 'LSP format' })

-- disable automatic zig formatting
vim.g.zig_fmt_autosave = 0

-- enable lsp
vim.api.nvim_create_autocmd("FileType", {
    pattern = 'rust',
    callback = function(ev)
        vim.lsp.start({
            name = "rust-analyzer",
            cmd = { "rust-analyzer" },
            root_dir = vim.fs.root(ev.buf, { 'Cargo.toml', 'Cargo.lock', '.git' }),
        })
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = 'cpp',
    callback = function(ev)
        vim.lsp.start({
            name = "clangd",
            cmd = { "clangd" },
            root_dir = vim.fs.root(ev.buf, { 'Makefile', 'main.cc', '.git' }),
        })
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = 'go',
    callback = function(ev)
        vim.lsp.start({
            name = "gopls",
            cmd = { "gopls" },
            root_dir = vim.fs.root(ev.buf, { 'go.work', 'go.mod', '.git' }),
        })
    end,
})
