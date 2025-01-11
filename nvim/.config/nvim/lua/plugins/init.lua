return {
    "nvim-lua/plenary.nvim",
    "eandrju/cellular-automaton.nvim",

    -- copilot
    "github/copilot.vim",

    --code screenshot
    "segeljakt/vim-silicon",

    -- Markdown preview
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },
}
