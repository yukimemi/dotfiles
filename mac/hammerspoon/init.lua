local function keyCode(key, modifiers)
  modifiers = modifiers or {}
  return function()
    hs.eventtap.event.newKeyEvent(modifiers, key, true):post()
    hs.timer.usleep(1000)
    hs.eventtap.event.newKeyEvent(modifiers, key, false):post()
  end
end

local function keyCodeSet(keys)
  return function()
    for i, keyEvent in ipairs(keys) do
      keyEvent()
    end
  end
end

local function remapKey(modifiers, key, keyCode)
  hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

local eisuu = 0x66

remapKey({ 'ctrl' }, ']',  keyCodeSet({
  keyCode('escape'),
  keyCode(eisuu)
}))

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

