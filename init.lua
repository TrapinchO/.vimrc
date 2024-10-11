-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- This is also needed to be done before anything using it; i.e. my keybinds
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


-- MY SETTINGS -----------------------------------------------------------------------

vim.wo.number = true -- line numbers
vim.api.nvim_exec("language en_us", true) -- courtesy of https://vi.stackexchange.com/a/36427
vim.o.scrolloff = 5  -- minimum amount of life at top/botton before cursor

-- fix tab
-- courtesy of https://stackoverflow.com/a/1878983
vim.opt["shiftwidth"] = 4
vim.opt["expandtab"] = true
vim.opt["tabstop"] = 4

-- https://www.reddit.com/r/neovim/comments/ucks49/how_to_remap_kj_to_esc_in_initlua/
local options = { noremap = true }
vim.keymap.set("i", "jk", "<Esc>", options)

-- moves to errors; I think those were used for sth, but didnt get what for so its probably fine
vim.keymap.set("n", ",", vim.diagnostic.goto_prev)
vim.keymap.set("n", ";", vim.diagnostic.goto_next)
-- https://www.reddit.com/r/vim/comments/4yvjje/remapping_u_to_redo_cr_to_reversesearch/
vim.keymap.set("n", "U", "<C-R>")
-- https://vi.stackexchange.com/questions/4919/exit-from-terminal-mode-in-neovim-vim-8
-- idk if it works
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>w", "<cmd>wa<cr>")

vim.keymap.set("n", "<C-h>", "<C-W><C-h>", options)
vim.keymap.set("n", "<C-j>", "<C-W><C-j>", options)
vim.keymap.set("n", "<C-k>", "<C-W><C-k>", options)
vim.keymap.set("n", "<C-l>", "<C-W><C-l>", options)
vim.keymap.set("n", "<leader>.", "<cmd>Lazy<cr>", options)
vim.keymap.set("n", "<leader>/", "<cmd>Cheatsheet<cr>", options)
vim.keymap.set("n", "<leader>q", "<cmd>Telescope find_files<cr>", options)
vim.keymap.set("n", "<leader>e", "<cmd>Telescope live_grep<cr>", options)

vim.cmd([[autocmd VimEnter * Neotree]])

vim.opt.termguicolors = true -- changes how colors work
--vim.cmd [[colorscheme vim]] -- gives the good old scheme; also enables syntax hihglight for some reason

vim.g.godot_executable = 'C:\\Programy\\Godot\\NoNET'

--------------------------------------------------------------------------------------



-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- Setup lazy.nvim
require("lazy").setup({
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
  spec = { -- add your plugins here
{
    "neovim/nvim-lspconfig",
    --branch = "master",
    --enabled = true,
},
{ "hrsh7th/cmp-nvim-lsp" },
{ "hrsh7th/cmp-buffer" },
{ "hrsh7th/nvim-cmp" },
{ "hrsh7th/cmp-vsnip" },
{ "hrsh7th/vim-vsnip" },


{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function ()
        -- Unless you are still migrating, remove the deprecated commands from v1.x
        vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
        require("neo-tree").setup({
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        window = {
            position = "left",
            width = 35
        },
      })
    end
},
{
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup()
    end
},
{
    "freddiehaddad/feline.nvim",
    config = function(_, opts)
        require('feline').setup()
        require('feline').winbar.setup()
    end
},


{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
{ "jiangmiao/auto-pairs" },
{
    "sudormrfbin/cheatsheet.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
    },
},


{ "habamax/vim-godot"},

{ "rose-pine/neovim", name = "rose-pine" }

--[[
{
    "xiantang/darcula-dark.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
},
--]]
--[[
{
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
},
--]]
--[[
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>.",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
},
--]]




  },
})



-- LSP SETTINGS-----------------------------------------------------------------------
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- lsp configuration

local lsp = require('lspconfig')
local cmp = require('cmp')
local servers = {
    'rust_analyzer',
    "csharp_ls",
    'vimls',
    "gdscript",
    --'ts_ls',
    --'pyright',
    --'hls',
    --'html',
    --'jsonls',
    --'hls',
    --'remark_ls',
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>', opts)
end
for _, server in ipairs(servers) do
    lsp[server].setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true  }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        -- https://stackoverflow.com/a/73144320
        -- { name = 'buffer' },
    })
})
local diagnostic_opts = {
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = true,
}
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, diagnostic_opts)


vim.cmd [[colorscheme rose-pine]] -- gives the good old scheme; also enables syntax hihglight for some reason



