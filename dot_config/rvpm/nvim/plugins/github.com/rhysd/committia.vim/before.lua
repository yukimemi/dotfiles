vim.g.committia_hooks = {
  edit_open = function(info)
    -- 追加設定: スペルチェックを有効化
    vim.opt_local.spell = true

    -- コミットメッセージが空の場合、インサートモードで開始
    if info.vcs == "git" and vim.fn.getline(1) == "" then
      vim.cmd("startinsert")
    end

    -- インサートモードでの diff ウィンドウスクロール用マッピング
    local opts = { buffer = true, silent = true }
    vim.keymap.set("i", "<C-n>", "<Plug>(committia-scroll-diff-down-half)", opts)
    vim.keymap.set("i", "<C-p>", "<Plug>(committia-scroll-diff-up-half)", opts)
  end,
}
