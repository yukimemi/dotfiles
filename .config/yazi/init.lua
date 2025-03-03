-- =============================================================================
-- File        : init.lua
-- Author      : yukimemi
-- Last Change : 2025/03/02 23:53:11.
-- =============================================================================

-- https://github.com/hankertrix/augment-command.yazi
require("augment-command"):setup({
  prompt = true,
})
-- https://github.com/MasouShizuka/projects.yazi
require("projects"):setup({})

-- https://github.com/h-hg/yamb.yazi
require("yamb"):setup({})

function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%b %d %H:%M", time)
	else
		time = os.date("%b %d  %Y", time)
	end

	local size = self._file:size()
	return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end
