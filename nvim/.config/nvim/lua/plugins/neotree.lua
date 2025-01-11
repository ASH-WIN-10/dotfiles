return {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        { "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
    },
    opts = {
        filesystem = {
            window = {
                mappings = {
                    ["\\"] = "close_window",
                },
            },
        },
        filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                ".git",
                ".github",
            },
            always_show = { -- remains visible even if visible is toggled to true
                ".gitignore",
            },
        },

        event_handlers = {
            {
                event = "file_open_requested",
                handler = function()
                    -- auto close
                    -- vim.cmd("Neotree close")
                    -- OR
                    require("neo-tree.command").execute({ action = "close" })
                end,
            },
        },
    },
}
