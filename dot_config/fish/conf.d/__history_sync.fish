# https://qiita.com/yoshiori/items/f1c01dd94bb5f0489cf6
function __history_sync --on-event fish_preexec
  history save
  history merge
end
