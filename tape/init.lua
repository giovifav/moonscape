local current_folder = (...):gsub('%.init$', '')
local sound = require(current_folder .. '.sound')
local Object = require(current_folder .. '.oop')

local tape = Object:extend()

local sound = require(current_folder .. '.sound')
tape.soundsManager = require(current_folder .. '.soundsManager')

function tape:new(file)
    self._VERSION = 'moontape v0.0.0.1'
    self._DESCRIPTION = 'a libry to make ambienta sounds composition'
    self._URL   = 'http://foobar.page.or.repo.com'
    self._LICENSE     = [[
    ... (license text, or name/url for long licenses)
    ]]
end



function tape:draw()

end


return tape