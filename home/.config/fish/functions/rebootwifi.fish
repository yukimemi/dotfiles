function rebootwifi
  networksetup -setairportpower en0 off
  sleep 5
  networksetup -setairportpower en0 on
  networksetup -setdhcp Wi-Fi
end
