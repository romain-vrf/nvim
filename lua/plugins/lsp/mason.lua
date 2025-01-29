return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- import de mason
    local mason = require("mason")

    -- import de mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- import de lspconfig
    local lspconfig = require("lspconfig")

    -- active mason et personnalise les icônes
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- Liste des serveurs à installer par défaut
      -- List des serveurs possibles : https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
      -- Vous pouvez ne pas en mettre ici et tout installer en utilisant :Mason
      -- Mais au lieu de passer par :Mason pour installer, je vous recommande d'ajouter une entrée à cette liste
      -- Ça permettra à votre configuration d'être plus portable
      ensure_installed = {
        "clangd",
        "graphql",
        "html",
        "lua_ls",
        "pylsp",
        "ruff",
        "rust_analyzer",
        "sqlls",
        "svelte",
        "yamlls",
      },
      handlers = {
        -- Fonction appelée au chargement de chaque LSP de la liste ensure_installed
        function(server_name)
          -- On active tous les LSP de ensure_installed avec sa configuration par défaut
          lspconfig[server_name].setup({})
        end,

        -- On peut ensuite configurer chaque LSP comme on veut
        -- Les détails des configurations possibles sont disponibles ici :
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
        -- Quelques exemples avec Python (pylsp et ruff) ainsi que Rust ci-dessous
        --
        -- Pour désactiver un LSP il suffit de faire
        -- mon_lsp = require("lsp-zero").noop,

        -- le nom du lsp avant le `= function()` doit être le même que celui après `lspconfig.`
        -- le premier est la clé utilisée par mason_lspconfig, le deuxième est celle utilisée par lspconfig (ce sont les mêmes)
        -- ils correspondent aux entrées du ensure_installed

        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#pylsp
        pylsp = function()
          lspconfig.pylsp.setup({
            settings = {
              pylsp = {
                plugins = {
                  pyflakes = { enabled = false },
                  pycodestyle = {
                    enabled = true,
                    ignore = { "E501" },
                  },
                },
              },
            },
          })
        end,

        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#
         ruff = function()
          lspconfig.ruff.setup({
            init_options = {
              settings = {
                -- Arguments par défaut de la ligne de commande "ruff server"
                -- (on ajoute les warnings pour le tri des imports)
                args = { "--extend-select", "I" },
              },
            },
          })
        end,
        lua_ls = function()
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  -- Force le LSP à reconnaître la variable globale `vim`
                  globals = { "vim" },
                },
              },
            },
          })
        end,

        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#rust_analyzer
        rust_analyzer = function()
          lspconfig.rust_analyzer.setup({
            settings = {
              ["rust-analyzer"] = {
                diagnostics = {
                  enable = true,
                  styleLints = {
                    enable = true,
                  },
                },
              },
            },
          })
        end,
      },
    })
  end,
}

