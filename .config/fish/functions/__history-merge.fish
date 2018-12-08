# https://qiita.com/yoshiori/items/f1c01dd94bb5f0489cf6
function __history-merge --on-event fish_preexec
  history --save
  history --merge
end
