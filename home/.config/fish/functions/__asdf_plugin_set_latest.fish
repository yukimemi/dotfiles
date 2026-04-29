function __asdf_plugin_set_latest -a pl
  asdf global $pl (string trim (asdf list $pl latest))
end
