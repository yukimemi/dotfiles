function __pack_list
  pack list | __filter_command | string split "=>" | head -1 | string trim
end

