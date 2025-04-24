
local current_folder = (...):gsub('%.[^%.]+$', '')

local Object = require(current_folder .. '.oop')

local soundManager = Object:extend()



return soundManager
