return {
    -- copilot
    {
        "github/copilot.vim",
        config = function()
            vim.keymap.set("i", "<C-L>", 'copilot#Accept("\\<CR>")', {
                expr = true,
                silent = true,
                replace_keycodes = false,
            })
            vim.g.copilot_no_tab_map = true
        end,
    },

    --code screenshot
    {
        "mistricky/codesnap.nvim",
        build = "make",
        opts = {
            save_path = "~/Pictures/CodeSnap/",
            watermark = "",
            bg_x_padding = 80,
            bg_y_padding = 60,
            bg_theme = "grape",
        },
    },

    -- Markdown preview
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },

    -- Typing
    {
        "nvzone/typr",
        dependencies = "nvzone/volt",
        opts = {},
        cmd = { "Typr", "TyprStats" },
    },
}
