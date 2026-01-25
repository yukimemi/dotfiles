function __filter_command_rhq
  rhq list | __filter_command | read -l line
  and __echo "Change directory" $line
  and cd $line
end

