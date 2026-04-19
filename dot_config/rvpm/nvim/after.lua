-- rvpm: open in terminal buffer, reuse if already running
local rvpm_buf = nil
local function rvpm_open()
    if rvpm_buf and vim.api.nvim_buf_is_valid(rvpm_buf) then
        local chan = vim.bo[rvpm_buf].channel
        local alive = chan and chan > 0 and vim.fn.jobwait({ chan }, 0)[1] == -1
        if alive then
            local wins = vim.fn.win_findbuf(rvpm_buf)
            if #wins > 0 then
                vim.api.nvim_set_current_win(wins[1])
            else
                vim.cmd("enew")
                vim.api.nvim_set_current_buf(rvpm_buf)
            end
            vim.cmd("startinsert")
            return
        end
        pcall(vim.api.nvim_buf_delete, rvpm_buf, { force = true })
        rvpm_buf = nil
    end
    vim.cmd("enew | terminal rvpm list")
    rvpm_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_create_autocmd("BufWipeout", {
        buffer = rvpm_buf,
        once = true,
        callback = function() rvpm_buf = nil end,
    })
    vim.cmd("startinsert")
end
vim.keymap.set("n", "<space>rp", rvpm_open, { silent = true, noremap = true })

