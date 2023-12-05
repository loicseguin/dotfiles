-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Pugins
-- Start by installing vim-plug following the instructions here:
-- https://github.com/junegunn/vim-plug
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('tpope/vim-fugitive')  -- Git related plugins
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('jamessan/vim-gnupg')
Plug('catppuccin/nvim', { as = 'catppuccin' })
Plug('sainnhe/gruvbox-material')
vim.call('plug#end')


-- Lualine for status line
require('lualine').setup{
    options = {
        icons_enabled = true,
        theme = 'auto',
        section_separators = '',
        component_separators = '',
    }
}


-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true
-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Formatting
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Make line numbers default
vim.o.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Better navigation between split windows
vim.keymap.set('n', '<C-j>', '<C-W><C-j>')
vim.keymap.set('n', '<C-k>', '<C-W><C-k>')
vim.keymap.set('n', '<C-l>', '<C-W><C-l>')
vim.keymap.set('n', '<C-h>', '<C-W><C-h>')

-- Visual shifting (does not exit visual mode)
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Toggle search highlighting
vim.keymap.set('n', '<leader>hs', ':set invhlsearch<CR>', { silent = true })

-- Switch to previous buffer
vim.keymap.set('n', '<leader>b', ':b#<CR>')

-- Quickly edit/reload vimrc file
vim.keymap.set('n', '<leader>ev', ':e $MYVIMRC<CR>', { silent = true })
vim.keymap.set('n', '<leader>sv', ':so $MYVIMRC<CR>', { silent = true })

-- Delete all trailing spaces in a file.
vim.keymap.set(
  'n',
  '<leader>ts',
  ':let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>',
  { silent = true, desc = 'Delete trailing spaces' }
)

-- Fugitive plugin keymaps
vim.keymap.set('n', '<leader>gs', ':Git<CR>', { silent = true, desc = 'Git status' })
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { silent = true, desc = 'Git commit' })
vim.keymap.set('n', '<leader>gd', ':Gdiff<CR>', { silent = true, desc = 'Git diff' })
vim.keymap.set('n', '<leader>gl', ':Glog<CR>', { silent = true, desc = 'Git log' })
vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { silent = true, desc = 'Git push' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- Colors and UI
vim.cmd.colorscheme "gruvbox-material"


-- vim-gnupg setup
local gnupggroup = vim.api.nvim_create_augroup("GnuPGExtra", { clear = true })
vim.api.nvim_create_autocmd(
    {"BufReadCmd", "FileReadCmd"},
    {
        group = gnupggroup,
        pattern = {"*.gpg", "*.pgp", "*.asc"},
        callback = function()
            vim.opt_local.updatetime=60000  -- Set updatetime to 1 minute.
            vim.opt_local.foldmethod="marker" -- Fold at markers.
            vim.opt_local.foldclose="all"     -- Automatically close all folds.
            vim.opt_local.foldopen="insert"   -- Only open folds with insert commands.
        end,
    }
)
vim.api.nvim_create_autocmd(
    "CursorHold",
    {
        group = gnupggroup,
        pattern = {"*.gpg", "*.pgp", "*.asc"},
	command = "quit"
    }
)

