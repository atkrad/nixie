{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    package = pkgs.unstable.neovim-unwrapped;
    withRuby = false;
    withPython3 = false;
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
              dotfiles = false,  -- Show dotfiles by default (toggle with 'H' in tree)
              custom = { "^.git$" },  -- But hide .git directory
            },
            actions = {
              open_file = {
                quit_on_open = false,
              },
            },
            -- Integration with project.nvim
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
              enable = true,
              update_root = true,
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
            -- Enable transparent background for better integration
            transparent_bg = true,
          }
          require('dracula').load()
          vim.cmd.colorscheme("dracula")
        '';
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          -- Setup nvim-treesitter (parsers already installed via Nix)
          require('nvim-treesitter').setup {}

          -- Enable highlighting for all filetypes
          vim.api.nvim_create_autocmd('FileType', {
            callback = function()
              pcall(vim.treesitter.start)
            end,
          })

          -- Enable treesitter-based indentation
          vim.api.nvim_create_autocmd('FileType', {
            callback = function()
              vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
          })
        '';
      }
      {
        plugin = nvim-treesitter-context;
        type = "lua";
        config = ''
          require('treesitter-context').setup {
            enable = true,
            max_lines = 10,
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
            -- Doom Emacs style: only show registered leader key groups
            plugins = {
              marks = false,
              registers = false,
              presets = {
                operators = false,    -- hide d, c, y, etc.
                motions = false,      -- hide w, b, e, etc.
                text_objects = false, -- hide iw, aw, etc.
                windows = false,      -- hide <c-w> bindings
                nav = false,          -- hide [, ], etc.
                z = false,            -- hide z bindings
                g = false,            -- hide g bindings
              },
            },
            icons = {
              group = "", -- use no default group icon, we add our own
            },
          }
        '';
      }
      {
        plugin = nvim-lspconfig;
        # Config in extraLuaConfig using new vim.lsp.config API
      }
      {
        plugin = blink-cmp;
        type = "lua";
        config = ''
          require("blink.cmp").setup({
            snippets = {
              expand = function(snippet) vim.snippet.expand(snippet) end,
              active = function(filter) return vim.snippet.active(filter) end,
              jump = function(direction) vim.snippet.jump(direction) end,
            },
            sources = {
              default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
          })
        '';
      }
      {
        plugin = lspsaga-nvim;
        type = "lua";
        config = ''
          require('lspsaga').setup({
            symbol_in_winbar = {
              enable = false,
            },
          })
        '';
      }
      {
        plugin = trouble-nvim;
        type = "lua";
        config = ''
          require('trouble').setup({
            auto_close = false,       -- Don't auto close
            auto_refresh = true,      -- Auto refresh when diagnostics change
            auto_preview = true,      -- Auto preview items
            focus = false,            -- Don't steal focus when opening
            follow = true,            -- Follow the current item
            indent_guides = true,     -- Show indent guides
            multiline = true,         -- Render multi-line messages

            -- Window configuration
            win = {
              type = "split",         -- Use split instead of float
              position = "bottom",    -- Bottom split
              size = 10,              -- 10 lines high
            },

            -- Use Dracula-friendly icons
            icons = {
              indent = {
                top = "│ ",
                middle = "├╴",
                last = "└╴",
                fold_open = " ",
                fold_closed = " ",
                ws = "  ",
              },
              folder_closed = " ",
              folder_open = " ",
            },

            -- Configure modes
            modes = {
              diagnostics = {
                auto_open = false,    -- Don't auto-open on diagnostics
              },
              symbols = {
                desc = "document symbols",
                mode = "lsp_document_symbols",
                focus = false,
                win = { position = "right", size = 40 },
                filter = {
                  any = {
                    ft = { "help", "markdown" },
                    kind = {
                      "Class",
                      "Constructor",
                      "Enum",
                      "Field",
                      "Function",
                      "Interface",
                      "Method",
                      "Module",
                      "Namespace",
                      "Package",
                      "Property",
                      "Struct",
                      "Trait",
                    },
                  },
                },
              },
            },
          })
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
        plugin = diffview-nvim;
        type = "lua";
        config = ''
          require("diffview").setup({
            enhanced_diff_hl = true,
            view = {
              merge_tool = {
                layout = "diff3_mixed",
              },
            },
          })
        '';
      }
      {
        plugin = neogit;
        type = "lua";
        config = ''
          require('neogit').setup({
            -- Disable hints once you're comfortable
            disable_hint = false,

            -- Use unicode graph for prettier commit history
            graph_style = "unicode",

            -- Integrate with Telescope and Diffview
            integrations = {
              telescope = true,
              diffview = true,
            },

            -- Use native fzf sorter from telescope
            telescope_sorter = function()
              return require("telescope").extensions.fzf.native_fzf_sorter()
            end,

            -- Persist settings per-project
            remember_settings = true,
            use_per_project_settings = true,

            -- Open Neogit as a tab
            kind = "tab",

            -- Commit editor settings
            commit_editor = {
              kind = "tab",
              show_staged_diff = true,
              staged_diff_split_kind = "auto",
              spell_check = true,
            },

            -- Status buffer settings
            status = {
              show_head_commit_hash = true,
              recent_commit_count = 10,
            },

            -- Section visibility
            sections = {
              untracked = { folded = false, hidden = false },
              unstaged = { folded = false, hidden = false },
              staged = { folded = false, hidden = false },
              stashes = { folded = true, hidden = false },
              unpulled_upstream = { folded = true, hidden = false },
              unmerged_upstream = { folded = false, hidden = false },
              recent = { folded = true, hidden = false },
            },

            -- Custom signs with nerd font icons
            signs = {
              hunk = { "", "" },
              item = { "", "" },
              section = { "", "" },
            },
          })
        '';
      }
      {
        plugin = plenary-nvim;
      }
      {
        plugin = nvim-notify;
        type = "lua";
        config = ''
          require("notify").setup({
            -- Animation style
            stages = "fade_in_slide_out",
            -- Default timeout for notifications
            timeout = 3000,
            -- Render style
            render = "default",
            -- Minimum width for notification windows
            minimum_width = 50,
            -- Icons for notifications (requires a Nerd Font)
            icons = {
              ERROR = "",
              WARN = "",
              INFO = "",
              DEBUG = "",
              TRACE = "✎",
            },
            -- Max number of columns for messages
            max_width = nil,
            max_height = nil,
            -- Background colour for notifications
            background_colour = "#282a36",  -- Dracula background
          })

          -- Set as default notify function
          vim.notify = require("notify")

          -- Load telescope extension for notification history
          require("telescope").load_extension("notify")
        '';
      }
      {
        plugin = telescope-fzf-native-nvim;
        type = "lua";
        config = ''
          require('telescope').load_extension('fzf')
        '';
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          require('telescope').setup({
            defaults = {
              mappings = {
                i = {
                  ["<C-j>"] = "move_selection_next",
                  ["<C-k>"] = "move_selection_previous",
                },
              },
            },
          })
        '';
      }
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require("nvim-autopairs").setup({
            check_ts = true,  -- Enable treesitter integration
          })
        '';
      }
      {
        plugin = comment-nvim;
        type = "lua";
        config = ''
          require('Comment').setup()
        '';
      }
      {
        plugin = fidget-nvim;
        type = "lua";
        config = ''
          require("fidget").setup({
            progress = {
              display = {
                done_icon = "✔",                 -- Icon when complete
                done_style = "DiagnosticOk",     -- Green for completed
                progress_icon = { "dots" },      -- Animated spinner
                progress_style = "DiagnosticInfo", -- Cyan for in-progress
                group_style = "Title",           -- Purple for group name
                icon_style = "DiagnosticWarn",   -- Orange/yellow for icons
              },
            },
            notification = {
              window = {
                normal_hl = "Comment",      -- Dracula comment color for base text
                winblend = 0,               -- No transparency for better visibility
                border = "rounded",         -- Add a border
                x_padding = 1,
                y_padding = 0,
              },
              view = {
                group_separator_hl = "Comment",  -- Dracula comment for separator
              },
            },
          })
        '';
      }
      {
        plugin = alpha-nvim;
        type = "lua";
        config = ''
          local alpha = require('alpha')
          local dashboard = require('alpha.themes.dashboard')

          -- Set header with NIXIE
          dashboard.section.header.val = {
            "                                                     ",
            "                                                     ",
            "        ███╗   ██╗██╗██╗  ██╗██╗███████╗             ",
            "        ████╗  ██║██║╚██╗██╔╝██║██╔════╝             ",
            "        ██╔██╗ ██║██║ ╚███╔╝ ██║█████╗               ",
            "        ██║╚██╗██║██║ ██╔██╗ ██║██╔══╝               ",
            "        ██║ ╚████║██║██╔╝ ██╗██║███████╗             ",
            "        ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝╚═╝╚══════╝             ",
            "                                                     ",
            "           ⚡ Nix-powered Development ⚡               ",
            "                                                     ",
          }

          -- Set menu
          dashboard.section.buttons.val = {
            dashboard.button("f", "󰈞  Find file", "<cmd>Telescope find_files<cr>"),
            dashboard.button("r", "󰋚  Recent files", "<cmd>Telescope oldfiles<cr>"),
            dashboard.button("g", "󰊄  Find text", "<cmd>Telescope live_grep<cr>"),
            dashboard.button("n", "󰕮  New file", "<cmd>ene <bar> startinsert<cr>"),
            dashboard.button("e", "󰙅  File tree", "<cmd>NvimTreeToggle<cr>"),
            dashboard.button("c", "󰈙  Config", "<cmd>e ~/nixie/home-manager/modules/neovim/default.nix<cr>"),
            dashboard.button("q", "󰩈  Quit", "<cmd>qa<cr>"),
          }

          -- Set footer
          local function footer()
            local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
            local version = vim.version()
            local nvim_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
            return datetime .. "   Neovim " .. nvim_version
          end

          dashboard.section.footer.val = footer()

          -- Apply colors (using Dracula theme colors)
          dashboard.section.header.opts.hl = "Function"
          dashboard.section.buttons.opts.hl = "Keyword"
          dashboard.section.footer.opts.hl = "Comment"

          alpha.setup(dashboard.opts)

          -- Disable folding on alpha buffer
          vim.cmd([[
            autocmd FileType alpha setlocal nofoldenable
          ]])
        '';
      }
      {
        plugin = aerial-nvim;
        type = "lua";
        config = ''
          require("aerial").setup({
            backends = { "lsp", "treesitter", "markdown", "man" },
            layout = {
              default_direction = "right",
              min_width = 30,
            },
            show_guides = true,
            guides = {
              mid_item = "├─",
              last_item = "└─",
              nested_top = "│ ",
              whitespace = "  ",
            },
            on_attach = function(bufnr)
              vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", {buffer = bufnr})
              vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", {buffer = bufnr})
            end,
          })
        '';
      }
      {
        plugin = nvim-navic;
        type = "lua";
        config = ''
          require("nvim-navic").setup({
            highlight = true,
            separator = " > ",
            depth_limit = 0,
            depth_limit_indicator = "..",
            safe_output = true,
          })
        '';
      }
      {
        plugin = friendly-snippets;
      }
      {
        plugin = nvim-spectre;
        type = "lua";
        config = ''
          require('spectre').setup({
            live_update = true,
            line_sep_start = '┌─────────────────────────────────────────',
            result_padding = '│  ',
            line_sep       = '└─────────────────────────────────────────',
          })
        '';
      }
      {
        plugin = nvim-dap;
      }
      {
        plugin = nvim-dap-ui;
        type = "lua";
        config = ''
          local dap, dapui = require("dap"), require("dapui")
          dapui.setup({
            layouts = {
              {
                elements = {
                  { id = "scopes", size = 0.25 },
                  { id = "breakpoints", size = 0.25 },
                  { id = "stacks", size = 0.25 },
                  { id = "watches", size = 0.25 },
                },
                size = 40,
                position = "left",
              },
              {
                elements = {
                  "repl",
                  "console",
                },
                size = 10,
                position = "bottom",
              },
            },
          })

          -- Auto open/close UI
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        '';
      }
      {
        plugin = nvim-dap-go;
        type = "lua";
        config = ''
          require('dap-go').setup()
        '';
      }
      {
        plugin = nvim-dap-virtual-text;
        type = "lua";
        config = ''
          require("nvim-dap-virtual-text").setup({
            enabled = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = true,
            show_stop_reason = true,
            commented = false,
            virt_text_pos = 'eol',
          })
        '';
      }
      {
        plugin = project-nvim;
        type = "lua";
        config = ''
          require("project").setup({
            manual_mode = false,  -- Enable automatic project detection
            patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "go.mod", "flake.nix" },
            enable_autochdir = true,  -- Automatically change to project root (JetBrains-like!)
            silent_chdir = true,  -- Don't show messages when changing directory
            show_hidden = false,  -- Don't show hidden files in project picker
            scope_chdir = 'global',  -- Change directory globally
          })
          require('telescope').load_extension('projects')
        '';
      }
      {
        plugin = persistence-nvim;
        type = "lua";
        config = ''
          require("persistence").setup({
            dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
            options = { "buffers", "curdir", "tabpages", "winsize" },
          })
        '';
      }
      {
        plugin = nui-nvim;
      }
      {
        plugin = noice-nvim;
        type = "lua";
        config = ''
          require("noice").setup({
            lsp = {
              progress = {
                enabled = false,  -- Let fidget.nvim handle LSP progress
              },
              override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
              },
            },
            presets = {
              bottom_search = true,
              command_palette = true,
              long_message_to_split = true,
              inc_rename = false,
              lsp_doc_border = true,
            },
            routes = {
              {
                filter = {
                  event = "msg_show",
                  kind = "",
                  find = "written",
                },
                opts = { skip = true },
              },
            },
            -- Configure noice to use nvim-notify for notifications
            notify = {
              enabled = true,
              view = "notify",
            },
          })
        '';
      }
      {
        plugin = refactoring-nvim;
        type = "lua";
        config = ''
          require('refactoring').setup({
            prompt_func_return_type = {
              go = true,
              java = true,
              cpp = true,
              c = true,
              lua = true,
            },
            prompt_func_param_type = {
              go = true,
              java = true,
              cpp = true,
              c = true,
              lua = true,
            },
          })
        '';
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require('lualine').setup({
            options = {
              theme = 'dracula',
              section_separators = { left = ' ', right = ' ' },
              component_separators = { left = '|', right = '|' },
            },
            sections = {
              lualine_a = {'mode'},
              lualine_b = {'branch', 'diff', 'diagnostics'},
              lualine_c = {
                { 'filename', path = 1 },
                {
                  "navic",
                  color_correction = "dynamic",  -- Fixes background color to match lualine section
                  navic_opts = nil
                }
              },
              lualine_x = {'encoding', 'fileformat', 'filetype'},
              lualine_y = {'progress'},
              lualine_z = {'location'}
            },
            extensions = {'nvim-tree', 'trouble', 'aerial'},
          })
        '';
      }
      {
        plugin = nvim-nio;
      }
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = ''
          require("bufferline").setup({
            options = {
              mode = "buffers",
              numbers = "ordinal",
              separator_style = "thick",
              always_show_bufferline = true,
              show_buffer_close_icons = true,
              show_close_icon = false,
              color_icons = true,
              show_buffer_icons = true,
              show_duplicate_prefix = true,
              diagnostics = "nvim_lsp",
              diagnostics_indicator = function(count, level)
                local icon = level:match("error") and " " or " "
                return " " .. icon .. count
              end,
              indicator = {
                icon = '▎',
                style = 'icon',
              },
              offsets = {
                {
                  filetype = "NvimTree",
                  text = "  File Explorer",
                  highlight = "Directory",
                  text_align = "left",
                  separator = true,
                },
              },
              hover = {
                enabled = true,
                delay = 200,
                reveal = {'close'},
              },
              max_name_length = 18,
              max_prefix_length = 15,
              tab_size = 20,
            },
            highlights = {
              fill = { bg = "#21222c" },
              background = { fg = "#6272a4", bg = "#282a36" },
              buffer_visible = { fg = "#f8f8f2", bg = "#282a36" },
              buffer_selected = { fg = "#f8f8f2", bg = "#44475a", bold = true, italic = false },
              numbers = { fg = "#6272a4", bg = "#282a36" },
              numbers_visible = { fg = "#bd93f9", bg = "#282a36" },
              numbers_selected = { fg = "#bd93f9", bg = "#44475a", bold = true },
              close_button = { fg = "#6272a4", bg = "#282a36" },
              close_button_visible = { fg = "#ff5555", bg = "#282a36" },
              close_button_selected = { fg = "#ff5555", bg = "#44475a" },
              indicator_selected = { fg = "#bd93f9", bg = "#44475a" },
              separator = { fg = "#21222c", bg = "#282a36" },
              separator_selected = { fg = "#21222c", bg = "#282a36" },
              separator_visible = { fg = "#21222c", bg = "#282a36" },
              modified = { fg = "#ffb86c", bg = "#282a36" },
              modified_visible = { fg = "#ffb86c", bg = "#282a36" },
              modified_selected = { fg = "#ffb86c", bg = "#44475a" },
              duplicate = { fg = "#6272a4", bg = "#282a36", italic = true },
              duplicate_visible = { fg = "#6272a4", bg = "#282a36", italic = true },
              duplicate_selected = { fg = "#f8f8f2", bg = "#44475a", italic = true },
            },
          })
        '';
      }
    ];
    initLua = ''
      vim.g.mapleader = " "

      -- Set up LSP capabilities for blink.cmp (applied to all servers)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      if pcall(require, "blink.cmp") then
        capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
      end

      -- Common on_attach function for all LSP servers
      local on_attach = function(client, bufnr)
        -- Attach navic for breadcrumbs
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, bufnr)
        end

        -- Enable inlay hints if supported
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end

      -- Use vim.lsp.config instead of deprecated require("lspconfig")
      -- Apply capabilities and on_attach to all servers
      vim.lsp.config('*', {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- Configure lua_ls
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = {"vim"},
            },
            hint = {
              enable = true,
            },
          },
        },
      })

      -- Configure gopls with enhanced settings for JetBrains-like experience
      vim.lsp.config('gopls', {
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
              shadow = true,
              nilness = true,
              unusedwrite = true,
              useany = true,
            },
            staticcheck = true,
            gofumpt = true,
            codelenses = {
              gc_details = true,
              generate = true,
              regenerate_cgo = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          }
        }
      })

      -- Configure nil_ls (Nix LSP)
      vim.lsp.config('nil_ls', {
        settings = {
          ['nil'] = {
            formatting = {
              command = { "nixfmt" },  -- Uses pkgs.nixfmt from extraPackages
            },
            diagnostics = {
              ignored = {},  -- Add diagnostic codes to ignore, e.g. ["unused_binding"]
              excludedFiles = {},
            },
            nix = {
              binary = "nix",
              maxMemoryMB = 2560,
              flake = {
                autoArchive = true,  -- Automatically archive flake inputs
                autoEvalInputs = false,  -- Set to true for better completion (uses more memory)
                nixpkgsInputName = "nixpkgs",  -- For NixOS options completion
              },
            },
          },
        },
      })

      -- Enable the LSP servers
      vim.lsp.enable({'lua_ls', 'gopls', 'nil_ls'})

      -- Configure nvim-navic highlights to match Dracula theme
      -- Remove 'default = true' to ensure these override any conflicting highlights
      vim.api.nvim_set_hl(0, "NavicIconsFile",          {fg = "#ffb86c", bg = "NONE"}) -- Orange
      vim.api.nvim_set_hl(0, "NavicIconsModule",        {fg = "#bd93f9", bg = "NONE"}) -- Purple
      vim.api.nvim_set_hl(0, "NavicIconsNamespace",     {fg = "#bd93f9", bg = "NONE"}) -- Purple
      vim.api.nvim_set_hl(0, "NavicIconsPackage",       {fg = "#bd93f9", bg = "NONE"}) -- Purple
      vim.api.nvim_set_hl(0, "NavicIconsClass",         {fg = "#8be9fd", bg = "NONE"}) -- Cyan
      vim.api.nvim_set_hl(0, "NavicIconsMethod",        {fg = "#50fa7b", bg = "NONE"}) -- Green
      vim.api.nvim_set_hl(0, "NavicIconsProperty",      {fg = "#ff79c6", bg = "NONE"}) -- Pink
      vim.api.nvim_set_hl(0, "NavicIconsField",         {fg = "#ff79c6", bg = "NONE"}) -- Pink
      vim.api.nvim_set_hl(0, "NavicIconsConstructor",   {fg = "#50fa7b", bg = "NONE"}) -- Green
      vim.api.nvim_set_hl(0, "NavicIconsEnum",          {fg = "#8be9fd", bg = "NONE"}) -- Cyan
      vim.api.nvim_set_hl(0, "NavicIconsInterface",     {fg = "#8be9fd", bg = "NONE"}) -- Cyan
      vim.api.nvim_set_hl(0, "NavicIconsFunction",      {fg = "#50fa7b", bg = "NONE"}) -- Green
      vim.api.nvim_set_hl(0, "NavicIconsVariable",      {fg = "#ffb86c", bg = "NONE"}) -- Orange
      vim.api.nvim_set_hl(0, "NavicIconsConstant",      {fg = "#bd93f9", bg = "NONE"}) -- Purple
      vim.api.nvim_set_hl(0, "NavicIconsString",        {fg = "#f1fa8c", bg = "NONE"}) -- Yellow
      vim.api.nvim_set_hl(0, "NavicIconsNumber",        {fg = "#bd93f9", bg = "NONE"}) -- Purple
      vim.api.nvim_set_hl(0, "NavicIconsBoolean",       {fg = "#bd93f9", bg = "NONE"}) -- Purple
      vim.api.nvim_set_hl(0, "NavicIconsArray",         {fg = "#ffb86c", bg = "NONE"}) -- Orange
      vim.api.nvim_set_hl(0, "NavicIconsObject",        {fg = "#ffb86c", bg = "NONE"}) -- Orange
      vim.api.nvim_set_hl(0, "NavicIconsKey",           {fg = "#8be9fd", bg = "NONE"}) -- Cyan
      vim.api.nvim_set_hl(0, "NavicIconsNull",          {fg = "#bd93f9", bg = "NONE"}) -- Purple
      vim.api.nvim_set_hl(0, "NavicIconsEnumMember",    {fg = "#ff79c6", bg = "NONE"}) -- Pink
      vim.api.nvim_set_hl(0, "NavicIconsStruct",        {fg = "#8be9fd", bg = "NONE"}) -- Cyan
      vim.api.nvim_set_hl(0, "NavicIconsEvent",         {fg = "#ff79c6", bg = "NONE"}) -- Pink
      vim.api.nvim_set_hl(0, "NavicIconsOperator",      {fg = "#ff79c6", bg = "NONE"}) -- Pink
      vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", {fg = "#8be9fd", bg = "NONE"}) -- Cyan
      vim.api.nvim_set_hl(0, "NavicText",               {fg = "#f8f8f2", bg = "NONE"}) -- Foreground
      vim.api.nvim_set_hl(0, "NavicSeparator",          {fg = "#6272a4", bg = "NONE"}) -- Comment (subtle)

      -- Configure Fidget highlights to match Dracula theme
      vim.api.nvim_set_hl(0, "FidgetTask", {fg = "#8be9fd"}) -- Cyan for in-progress tasks
      vim.api.nvim_set_hl(0, "FidgetTitle", {fg = "#bd93f9"}) -- Purple for titles

      -- Essential Keymaps (non-leader keys)
      vim.keymap.set("n", "<leader>sd", "<cmd>Lspsaga show_line_diagnostics<cr>", { noremap = true, silent = true, desc = "Show Line Diagnostics (Lspsaga)" })
      vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<cr>", { noremap = true, silent = true, desc = "Goto Definition (Lspsaga)" })
      vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { noremap = true, silent = true, desc = "Hover Doc (Lspsaga)" })
      vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { noremap = true, silent = true })

      -- Buffer navigation with Tab (VS Code style)
      vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
      vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Buffer" })

      -- Go to buffer by visible position
      vim.keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "Buffer 1" })
      vim.keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", { desc = "Buffer 2" })
      vim.keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", { desc = "Buffer 3" })
      vim.keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", { desc = "Buffer 4" })
      vim.keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", { desc = "Buffer 5" })
      vim.keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", { desc = "Buffer 6" })
      vim.keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", { desc = "Buffer 7" })
      vim.keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", { desc = "Buffer 8" })
      vim.keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", { desc = "Buffer 9" })
      vim.keymap.set("n", "<leader>$", "<cmd>BufferLineGoToBuffer -1<cr>", { desc = "Last Buffer" })

      -- Buffer pick (press key to jump to buffer)
      vim.keymap.set("n", "gb", "<cmd>BufferLinePick<cr>", { desc = "Pick Buffer" })
      vim.keymap.set("n", "gD", "<cmd>BufferLinePickClose<cr>", { desc = "Pick Buffer to Close" })

      -- Snippet navigation keybindings (for vim.snippet)
      vim.keymap.set({"i", "s"}, "<C-l>", function()
        if vim.snippet.active({ direction = 1 }) then
          vim.snippet.jump(1)
        end
      end, {silent = true, desc = "Jump to next snippet placeholder"})

      vim.keymap.set({"i", "s"}, "<C-h>", function()
        if vim.snippet.active({ direction = -1 }) then
          vim.snippet.jump(-1)
        end
      end, {silent = true, desc = "Jump to previous snippet placeholder"})

      -- Indentation and Options
      vim.opt.expandtab = true
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.smartindent = true
      vim.opt.autoindent = true
      vim.opt.cindent = true
      vim.opt.number = true
      vim.opt.relativenumber = true  -- Relative line numbers for easier jumping
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
      vim.opt.scrolloff = 8  -- Keep 8 lines visible above/below cursor
      vim.opt.sidescrolloff = 8
      vim.opt.updatetime = 250  -- Faster completion
      vim.opt.timeoutlen = 300  -- Faster which-key popup
      vim.opt.ignorecase = true  -- Case insensitive search
      vim.opt.smartcase = true  -- Unless uppercase letters are used
      vim.opt.hlsearch = true  -- Highlight search results
      vim.opt.incsearch = true  -- Show search matches as you type

      -- Auto-reload files when changed externally (prevents "file changed" warnings)
      vim.opt.autoread = true
      vim.api.nvim_create_autocmd(
        { "FocusGained", "BufEnter", "CursorHold" },
        { command = "checktime" }
      )

      -- Enable syntax highlighting (equivalent to 'syntax enable')
      vim.cmd.syntax("enable")

      local wk = require("which-key")
      wk.add({
        -- ══════════════════════════════════════════════════════════════════════
        -- Quick Actions (single key after leader)
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = " Explorer", mode = "n" },
        { "<leader>o", "<cmd>AerialToggle<cr>", desc = " Outline", mode = "n" },
        { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = " Search Project", mode = "n" },
        { "<leader>.", "<cmd>Telescope find_files<cr>", desc = " Find File", mode = "n" },
        { "<leader>,", "<cmd>Telescope buffers<cr>", desc = "󰈙 Switch Buffer", mode = "n" },
        { "<leader>:", "<cmd>Telescope commands<cr>", desc = " Commands", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- File operations
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>f", group = " file" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files", mode = "n" },
        { "<leader>fn", "<cmd>enew<cr>", desc = "New File", mode = "n" },
        { "<leader>fs", "<cmd>w<cr>", desc = "Save", mode = "n" },
        { "<leader>fS", "<cmd>wa<cr>", desc = "Save All", mode = "n" },
        { "<leader>fy", "<cmd>let @+ = expand('%:p')<cr>", desc = "Yank Path", mode = "n" },
        { "<leader>fY", "<cmd>let @+ = expand('%:~:.')<cr>", desc = "Yank Relative Path", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- Buffer operations
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>b", group = " buffer" },
        { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Switch Buffer", mode = "n" },
        { "<leader>bd", "<cmd>bd<cr>", desc = "Delete Buffer", mode = "n" },
        { "<leader>bD", "<cmd>%bd|e#|bd#<cr>", desc = "Delete Others", mode = "n" },
        { "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "Next", mode = "n" },
        { "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous", mode = "n" },
        { "<leader>bs", "<cmd>w<cr>", desc = "Save", mode = "n" },
        { "<leader>bS", "<cmd>wa<cr>", desc = "Save All", mode = "n" },
        { "<leader>bP", "<cmd>BufferLineTogglePin<cr>", desc = "Pin Buffer", mode = "n" },
        { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Others", mode = "n" },
        { "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Close Right", mode = "n" },
        { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Left", mode = "n" },
        { "<leader>be", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort by Extension", mode = "n" },
        { "<leader>bm", "<cmd>BufferLineMoveNext<cr>", desc = "Move Right", mode = "n" },
        { "<leader>bM", "<cmd>BufferLineMovePrev<cr>", desc = "Move Left", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- Project operations
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>p", group = " project" },
        { "<leader>pp", "<cmd>Telescope projects<cr>", desc = "Switch Project", mode = "n" },
        { "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
        { "<leader>pg", "<cmd>Telescope live_grep<cr>", desc = "Grep", mode = "n" },
        { "<leader>pr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- Window operations
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>w", group = " window" },
        { "<leader>ww", "<C-w>w", desc = "Other Window", mode = "n" },
        { "<leader>wd", "<C-w>c", desc = "Delete Window", mode = "n" },
        { "<leader>ws", "<cmd>split<cr>", desc = "Split Below", mode = "n" },
        { "<leader>wv", "<cmd>vsplit<cr>", desc = "Split Right", mode = "n" },
        { "<leader>wh", "<C-w>h", desc = "← Left", mode = "n" },
        { "<leader>wj", "<C-w>j", desc = "↓ Down", mode = "n" },
        { "<leader>wk", "<C-w>k", desc = "↑ Up", mode = "n" },
        { "<leader>wl", "<C-w>l", desc = "→ Right", mode = "n" },
        { "<leader>w=", "<C-w>=", desc = "Balance", mode = "n" },
        { "<leader>wm", "<cmd>only<cr>", desc = "Maximize", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- Git operations
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>g", group = " git" },
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Status", mode = "n" },
        { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Commit", mode = "n" },
        { "<leader>gp", "<cmd>Neogit push<cr>", desc = "Push", mode = "n" },
        { "<leader>gP", "<cmd>Neogit pull<cr>", desc = "Pull", mode = "n" },
        { "<leader>gf", "<cmd>Neogit fetch<cr>", desc = "Fetch", mode = "n" },
        { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches", mode = "n" },
        { "<leader>gB", "<cmd>Gitsigns blame_line<cr>", desc = "Blame Line", mode = "n" },
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff View", mode = "n" },
        { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close Diff", mode = "n" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History", mode = "n" },
        { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch History", mode = "n" },
        { "<leader>gl", "<cmd>Neogit log<cr>", desc = "Log", mode = "n" },
        { "<leader>gr", "<cmd>Neogit rebase<cr>", desc = "Rebase", mode = "n" },
        { "<leader>gs", "<cmd>Neogit stash<cr>", desc = "Stash", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- LSP operations
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>l", group = " lsp" },
        { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = "n" },
        { "<leader>ld", "<cmd>Trouble<cr>", desc = "Diagnostics", mode = "n" },
        { "<leader>lf", vim.lsp.buf.format, desc = "Format", mode = "n" },
        { "<leader>lh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = "Toggle Inlay Hints", mode = "n" },
        { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", mode = "n" },
        { "<leader>lr", vim.lsp.buf.rename, desc = "Rename", mode = "n" },
        { "<leader>lR", "<cmd>LspRestart<cr>", desc = "Restart", mode = "n" },
        { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols", mode = "n" },
        { "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- Search operations
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>s", group = " search" },
        { "<leader>ss", "<cmd>Telescope live_grep<cr>", desc = "Search Project", mode = "n" },
        { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search Buffer", mode = "n" },
        { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands", mode = "n" },
        { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Files", mode = "n" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help", mode = "n" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", mode = "n" },
        { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks", mode = "n" },
        { "<leader>sr", "<cmd>lua require('spectre').toggle()<cr>", desc = "Search & Replace", mode = "n" },
        { "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", desc = "Search Word", mode = "n" },
        { "<leader>sd", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Line Diagnostics", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- Code operations
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>c", group = " code" },
        { "<leader>ca", vim.lsp.buf.code_action, desc = "Action", mode = "n" },
        { "<leader>cf", vim.lsp.buf.format, desc = "Format", mode = "n" },
        { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", mode = "n" },
        { "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Line Diagnostics", mode = "n" },
        { "<leader>cD", "<cmd>Lspsaga show_buf_diagnostics<cr>", desc = "Buffer Diagnostics", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- Refactoring operations
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>r", group = " refactor", mode = {"n", "x"} },
        { "<leader>re", function() require('refactoring').refactor('Extract Function') end, desc = "Extract Function", mode = "x" },
        { "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end, desc = "Extract to File", mode = "x" },
        { "<leader>rv", function() require('refactoring').refactor('Extract Variable') end, desc = "Extract Variable", mode = "x" },
        { "<leader>ri", function() require('refactoring').refactor('Inline Variable') end, desc = "Inline Variable", mode = {"n", "x"} },
        { "<leader>rb", function() require('refactoring').refactor('Extract Block') end, desc = "Extract Block", mode = "n" },
        { "<leader>rB", function() require('refactoring').refactor('Extract Block To File') end, desc = "Extract Block to File", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- Debug operations
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>d", group = " debug" },
        { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Breakpoint", mode = "n" },
        { "<leader>dB", function() require('dap').set_breakpoint(vim.fn.input('Condition: ')) end, desc = "Conditional Breakpoint", mode = "n" },
        { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue", mode = "n" },
        { "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step Into", mode = "n" },
        { "<leader>do", "<cmd>DapStepOver<cr>", desc = "Step Over", mode = "n" },
        { "<leader>dO", "<cmd>DapStepOut<cr>", desc = "Step Out", mode = "n" },
        { "<leader>dt", "<cmd>DapTerminate<cr>", desc = "Terminate", mode = "n" },
        { "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle UI", mode = "n" },
        { "<leader>dh", "<cmd>lua require('dap.ui.widgets').hover()<cr>", desc = "Hover", mode = "n" },
        { "<leader>dr", "<cmd>lua require('dap').repl.open()<cr>", desc = "REPL", mode = "n" },
        { "<leader>dg", "<cmd>lua require('dap-go').debug_test()<cr>", desc = "Go Test", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- Diagnostics (Trouble)
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>x", group = " diagnostics" },
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "All Diagnostics", mode = "n" },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics", mode = "n" },
        { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix", mode = "n" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List", mode = "n" },
        { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols", mode = "n" },
        { "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>", desc = "References", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- Toggle options
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>t", group = " toggle" },
        { "<leader>tn", "<cmd>set number!<cr>", desc = "Line Numbers", mode = "n" },
        { "<leader>tr", "<cmd>set relativenumber!<cr>", desc = "Relative Numbers", mode = "n" },
        { "<leader>ts", "<cmd>set spell!<cr>", desc = "Spell Check", mode = "n" },
        { "<leader>tw", "<cmd>set wrap!<cr>", desc = "Word Wrap", mode = "n" },
        { "<leader>th", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = "Inlay Hints", mode = "n" },
        { "<leader>tc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", mode = "n" },
        { "<leader>tb", "<cmd>let &background = &background == 'dark' ? 'light' : 'dark'<cr>", desc = "Background", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- UI operations
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>u", group = " ui" },
        { "<leader>uc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", mode = "n" },
        { "<leader>uh", "<cmd>Telescope highlights<cr>", desc = "Highlights", mode = "n" },
        { "<leader>un", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Dismiss Notifications", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- Help
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>h", group = "󰋖 help" },
        { "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags", mode = "n" },
        { "<leader>hk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", mode = "n" },
        { "<leader>hm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", mode = "n" },
        { "<leader>ho", "<cmd>Telescope vim_options<cr>", desc = "Options", mode = "n" },
        { "<leader>ht", "<cmd>Telescope builtin<cr>", desc = "Telescope", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- Notifications
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>n", group = " notifications" },
        { "<leader>nn", "<cmd>Telescope notify<cr>", desc = "History", mode = "n" },
        { "<leader>nd", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Dismiss All", mode = "n" },
        { "<leader>nc", "<cmd>lua require('notify').clear_history()<cr>", desc = "Clear History", mode = "n" },

        -- ══════════════════════════════════════════════════════════════════════
        -- Quit/Session
        -- ══════════════════════════════════════════════════════════════════════
        { "<leader>q", group = "󰈆 quit/session" },
        { "<leader>qq", "<cmd>q<cr>", desc = "Quit", mode = "n" },
        { "<leader>qQ", "<cmd>qa!<cr>", desc = "Quit All (Force)", mode = "n" },
        { "<leader>qs", "<cmd>lua require('persistence').load()<cr>", desc = "Restore Session", mode = "n" },
        { "<leader>ql", "<cmd>lua require('persistence').load({ last = true })<cr>", desc = "Restore Last", mode = "n" },
        { "<leader>qd", "<cmd>lua require('persistence').stop()<cr>", desc = "Don't Save Session", mode = "n" },
      })
    '';
    extraPackages = with pkgs; [
      # For tree-sitter
      gcc
      lua
      # LSP servers (NixOS way, no Mason needed)
      gopls
      lua-language-server
      nil # Nix LSP
      # Formatters
      nixfmt
      # Telescope dependencies
      ripgrep # For live_grep
      fd # For file search
      # Debugger
      delve # Go debugger (for nvim-dap-go)
      # Search and replace
      gnused # For spectre.nvim
    ];
  };
}
