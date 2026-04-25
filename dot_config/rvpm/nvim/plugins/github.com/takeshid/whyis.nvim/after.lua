require("whyis.config").setup()

vim.keymap.set("n", "<leader>wf", "<cmd>WhyisOpen float<cr>", { desc = "Whyis (float)" })
vim.keymap.set("n", "<leader>wl", "<cmd>WhyisOpen right<cr>", { desc = "Whyis (right)" })
