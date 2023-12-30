-- Leader key must be set before loading plugins
-- ----------------------------------------------
vim.g.mapleader = ' '      -- Set <space> as the leader key
vim.g.maplocalleader = ' '


-- Plugins
-- -------
-- Check if lazy.nvim plugin manager is installed. If not, install it.
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.vim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'tpope/vim-fugitive',  -- A git plugin so awesome it should be illegal
    'jamessan/vim-gnupg',  -- Easy editing of gnupg encrypted files
    'neovim/nvim-lspconfig',  -- LSP configuration and plugins
    {
        -- Gruvbox colorscheme
        'sainnhe/gruvbox-material',
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_foreground = 'mix'
            vim.cmd.colorscheme 'gruvbox-material'
        end,
    },
    {
        -- Lualine for status line
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = false,
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
    { 'folke/which-key.nvim', opts = {} },  -- Show pending keybinds
    { 'numToStr/Comment.nvim', opts = {} }, -- 'gc' to comment visual regions
    {
        -- Fuzzy finder (files, lsp, etc.)
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
    },
}, {})


-- Options
-- -------
-- See `:help vim.o`

-- netrw
vim.g.netrw_banner = 0

-- Keep context visible around cursor line
vim.o.scrolloff = 4

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Formatting
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Number lines and use relative numbers
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse in all modes
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true


-- Basic Keymaps
-- -------------

local function map(mode, key, cmd, opts)
    opts = opts or {}
    vim.keymap.set(mode, key, cmd, opts)
end

-- Set space to do nothing in normal and visual mode
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Better navigation between split windows
map('n', '<C-j>', '<C-W><C-j>')
map('n', '<C-k>', '<C-W><C-k>')
map('n', '<C-l>', '<C-W><C-l>')
map('n', '<C-h>', '<C-W><C-h>')

-- Visual shifting (does not exit visual mode)
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Buffer navigation
map('n', '<leader>ba', ':b#<CR>', { desc = 'Goto alternate buffer' })
map('n', '<leader>bp', ':bp<CR>', { desc = 'Goto previous buffer' })
map('n', '<leader>bn', ':bn<CR>', { desc = 'Goto next buffer' })
map('n', '<leader>bd', ':bn<CR>', { desc = 'Delete buffer' })

-- Quickly edit vimrc file
map('n', '<leader>v', ':e $MYVIMRC<CR>', { desc = 'Edit vimrc', silent = true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Fugitive plugin keymaps
map('n', '<leader>gs', ':Git<CR>', { silent = true, desc = 'Git status' })
map('n', '<leader>gc', ':Git commit<CR>', { silent = true, desc = 'Git commit' })
map('n', '<leader>gd', ':Gdiff<CR>', { silent = true, desc = 'Git diff' })
map('n', '<leader>gl', ':Glog<CR>', { silent = true, desc = 'Git log' })
map('n', '<leader>gp', ':Git push<CR>', { silent = true, desc = 'Git push' })

-- Toggle search highlighting
map('n', '<leader>h', ':set invhlsearch<CR>', { desc = 'Toggle search highlighting' })

-- Delete all trailing spaces in a file.
map(
  'n',
  '<leader>t',
  ':let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>',
  { silent = true, desc = 'Delete trailing spaces' }
)

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })


-- Telescope setup
-- ---------------

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
map('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = 'Find recently opened files' })
map('n', '<leader><space>', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
map('n', '<leader>/',
    function()
        require('telescope.builtin')
        .current_buffer_fuzzy_find(require('telescope.themes')
        .get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end,
    { desc = 'Fuzzily search in current buffer' }
)

map('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search Git Files' })
map('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Search Files' })
map('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
map('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
map('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = 'Search by Grep' })
map('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
map('n', '<leader>sr', require('telescope.builtin').resume, { desc = 'Search Resume' })


-- LSP setup
-- ---------
local lspconfig = require('lspconfig')
lspconfig.rust_analyzer.setup {}
lspconfig.ruff_lsp.setup {}
lspconfig.clangd.setup {}

-- Use LspAttach autocommand to only map the following keys after the language
-- server attaches to the current buffer.
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <C-x><C-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end
            vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = desc })
        end

        nmap('<leader>lr', vim.lsp.buf.rename, 'Rename')
        nmap('<leader>lc', vim.lsp.buf.code_action, 'Code Action')
        nmap('<leader>ls', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
        nmap('<leader>lf', function()
            vim.lsp.buf.format { async = true }
        end, 'Format current buffer')

        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
        nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'Workspace List Folders')

        nmap('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
        nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
        nmap('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
        nmap('gy', require('telescope.builtin').lsp_type_definitions, 'Goto Type Definition')
        nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')

        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    end
})


-- which-key setup
-- ---------------
-- document existing key chains
require('which-key').register {
    ['<leader>b'] = { name = 'Buffers', _ = 'which_key_ignore' },
    ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
    ['<leader>l'] = { name = 'LSP', _ = 'which_key_ignore' },
    ['<leader>s'] = { name = 'Search', _ = 'which_key_ignore' },
    ['<leader>w'] = { name = 'Workspace', _ = 'which_key_ignore' },
}

-- vim-gnupg setup
-- ---------------
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
