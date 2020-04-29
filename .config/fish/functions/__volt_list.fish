function __volt_list
  volt list | grep -e '^\s' | __filter_command | string trim
end

