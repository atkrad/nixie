{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    package = pkgs.neovim-unwrapped;
    plugins = with pkgs.unstable.vimPlugins; [
      {
        plugin = render-markdown-nvim;
        type = "lua";
        config = ''
          require('render-markdown').setup({
              file_types = { 'markdown' },
          })
        '';
      }
      {
        plugin = nvim-web-devicons;
        type = "lua";
        config = ''
          require'nvim-web-devicons'.setup {
           -- your personal icons can go here (to override)
           -- you can specify color or cterm_color instead of specifying both of them
           -- DevIcon will be appended to `name`
           override = {
            zsh = {
              icon = "",
              color = "#428850",
              cterm_color = "65",
              name = "Zsh"
            }
           };
           -- globally enable different highlight colors per icon (default to true)
           -- if set to false all icons will have the default icon's color
           color_icons = true;
           -- globally enable default icons (default to false)
           -- will get overriden by `get_icons` option
           default = true;
           -- globally enable "strict" selection of icons - icon will be looked up in
           -- different tables, first by filename, and if not found by extension; this
           -- prevents cases when file doesn't have any extension but still gets some icon
           -- because its name happened to match some extension (default to false)
           strict = true;
           -- set the light or dark variant manually, instead of relying on `background`
           -- (default to nil)
           variant = "light|dark";
           -- same as `override` but specifically for overrides by filename
           -- takes effect when `strict` is true
           override_by_filename = {
            [".gitignore"] = {
              icon = "",
              color = "#f1502f",
              name = "Gitignore"
            }
           };
           -- same as `override` but specifically for overrides by extension
           -- takes effect when `strict` is true
           override_by_extension = {
            ["log"] = {
              icon = "",
              color = "#81e043",
              name = "Log"
            }
           };
           -- same as `override` but specifically for operating system
           -- takes effect when `strict` is true
           override_by_operating_system = {
            ["apple"] = {
              icon = "",
              color = "#A2AAAD",
              cterm_color = "248",
              name = "Apple",
            },
           };
          }
        '';
      }
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-tree").setup({
            sort = {
              sorter = "case_sensitive",
            },
            view = {
              width = 30,
            },
            renderer = {
              group_empty = true,
            },
            filters = {
              dotfiles = true,
            },
          })
        '';
      }
      {
        plugin = vim-go;
      }
      {
        plugin = dracula-nvim;
        type = "lua";
        config = ''
          require('dracula').setup {
            -- show the '~' characters after the end of buffers
            show_end_of_buffer = true,
          }
          require('dracula').load()
          vim.cmd.colorscheme("dracula")
        '';
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup {
            ensure_installed = {},
            sync_install = false,
            auto_install = false,

            highlight = { enable = true },
            indent = { enable = true },
          }
        '';
      }
      {
        plugin = nvim-treesitter-context;
        type = "lua";
        config = ''
          require('treesitter-context').setup {
            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 10, -- How many lines the window should span. Values <= 0 mean no limit.
            -- Separator between context and content. Should be a single character string, like '—'
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = "—",
          }
        '';
      }
      {
        plugin = nvim_context_vt;
        type = "lua";
        config = ''
          require("nvim_context_vt").setup({
            disable_ft = { "markdown", "yaml" },
          })
        '';
      }
      {
        plugin = nvim-colorizer-lua;
        type = "lua";
        config = ''
          require('colorizer').setup()
        '';
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''
          require('gitsigns').setup {
            current_line_blame = true,
          }
        '';
      }
      {
        plugin = statuscol-nvim;
        type = "lua";
        config = ''
          require("statuscol").setup {
            relculright = true,
          }
        '';
      }
      {
        plugin = nvim-cursorline;
        type = "lua";
        config = ''
          require('nvim-cursorline').setup {
            cursorword = {
              enable = true,
              min_length = 3,
              hl = { underline = true },
            }
          }
        '';
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          require("which-key").setup {
            win = {
              border = "single",
            },
          }
        '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          -- Basic LSP setup will be in extraLuaConfig
        '';
      }
      {
        plugin = mason-nvim;
        type = "lua";
        config = ''
          require("mason").setup()
        '';
      }
      {
        plugin = mason-lspconfig-nvim;
        type = "lua";
        config = ''
          require("mason-lspconfig").setup {
            ensure_installed = { "gopls", "lua_ls" }
          }
        '';
      }
      {
        plugin = blink-cmp;
        type = "lua";
        config = ''
          require("blink.cmp").setup({})
        '';
      }
      {
        plugin = lspsaga-nvim;
        type = "lua";
        config = ''
          require('lspsaga').setup({})
        '';
      }
      {
        plugin = trouble-nvim;
        type = "lua";
        config = ''
          require('trouble').setup({})
        '';
      }
      {
        plugin = mini-icons;
        type = "lua";
        config = ''
          require("mini.icons").setup()
        '';
      }
      {
        plugin = neogit;
        type = "lua";
        config = ''
          require('neogit').setup({})
        '';
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          require('telescope').setup({})
        '';
      }
    ];
    extraLuaConfig = ''
      vim.g.mapleader = " "

      -- Mason and LSP setup
      require("mason").setup()
      local lspconfig = require("lspconfig")

      -- blink.cmp setup (auto-completion)
      require("blink.cmp").setup({})

      -- Lspsaga setup
      require('lspsaga').setup({})

      -- Trouble setup
      require('trouble').setup({})

      -- Set up LSP capabilities for blink.cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      if pcall(require, "blink.cmp.lsp") then
        capabilities = require("blink.cmp.lsp").update_capabilities(capabilities)
      end
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = {"vim"},
            },
          },
        },
      }
      lspconfig.gopls.setup {
        capabilities = capabilities,
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
          }
        }
      }

      -- Keymaps
      vim.keymap.set("n", "<space><space>", function() require("which-key").show() end, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>h", "<C-w>h", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>l", "<C-w>l", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "LSP Code Action" })
      vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>", { noremap = true, silent = true, desc = "Toggle Trouble" })
      vim.keymap.set("n", "<leader>sd", "<cmd>Lspsaga show_line_diagnostics<cr>", { noremap = true, silent = true, desc = "Show Line Diagnostics (Lspsaga)" })
      vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<cr>", { noremap = true, silent = true, desc = "Goto Definition (Lspsaga)" })
      vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { noremap = true, silent = true, desc = "Hover Doc (Lspsaga)" })
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })

      -- Indentation and Options
      vim.opt.expandtab = true
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.smartindent = true
      vim.opt.autoindent = true
      vim.opt.cindent = true
      vim.opt.number = true
      vim.opt.ruler = true
      vim.opt.cursorline = true
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
      vim.opt.signcolumn = "yes"
      vim.opt.list = false
      vim.opt.mouse = "a"
      vim.opt.clipboard = "unnamedplus"
      vim.opt.undofile = true
      vim.opt.splitright = true
      vim.opt.splitbelow = true
      vim.opt.backspace = { "indent", "eol", "start" }

      -- Enable syntax highlighting (equivalent to 'syntax enable')
      vim.cmd.syntax("enable")

      local wk = require("which-key")
      wk.add({
        { "<leader>f", group = "file" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File", mode = "n" },
        { "<leader>fs", "<cmd>w<cr>", desc = "Save File", mode = "n" },
        { "<leader>f1", hidden = true },

        { "<leader>b", group = "buffer" },
        { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Switch Buffer", mode = "n" },
        { "<leader>bd", "<cmd>bd<cr>", desc = "Delete Buffer", mode = "n" },

        { "<leader>g", group = "git" },
        { "<leader>gs", "<cmd>Neogit<cr>", desc = "Status", mode = "n" },
        { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Commit", mode = "n" },

        { "<leader>l", group = "lsp" },
        { "<leader>ld", "<cmd>Trouble<cr>", desc = "Diagnostics", mode = "n" },
        { "<leader>lr", desc = "Rename", mode = "n" },
        { "<leader>la", desc = "Code Action", mode = "n" },

        { mode = { "n", "v" },
          { "<leader>q", "<cmd>q<cr>", desc = "Quit" },
          { "<leader>w", "<cmd>w<cr>", desc = "Write" },
        },
      })
    '';
    extraPackages = with pkgs; [
      # For tree-sitter
      gcc
      lua
      gopls
    ];
  };
}
