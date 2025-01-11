require("config.keymaps")
require("config.opts")

-- autocmd
local augroup = vim.api.nvim_create_augroup
local AshGroup = augroup("Ash", {})

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", {
    group = AshGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
    group = AshGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("i", "<C-q>", function()
            vim.lsp.buf.signature_help()
        end, opts)
    end,
})
