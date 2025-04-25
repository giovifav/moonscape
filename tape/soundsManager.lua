local current_folder = (...):gsub('%.[^%.]+$', '')
local Object = require(current_folder .. '.oop')
local sound = require(current_folder .. ".sound")
local soundManager = Object:extend()
--------------------------------------------------------------------------------------------------------------------------------

local function count(t)
    local count = 0
    for _, _ in pairs(t) do
        count = count + 1
    end
    return count
end
--------------------------------------------------------------------------------------------------------------------------------
function soundManager:new(tape)
    self.sounds = {}
    self.playlist = {}
    self.playedsounds = 0
    love.filesystem.mount(tape, "tape")

    assert(love.filesystem.getInfo("tape/tape.lua") ~= nil)
    local tape = love.filesystem.load("tape/tape.lua")()
    for i, v in ipairs(tape.sounds) do
        if v.playback == "playlist" then
            table.insert(self.playlist, sound(v, "tape/"))
        else
            table.insert(self.sounds, sound(v, "tape/"))
        end
    end

    self.playlistCount = count(self.playlist)

    if self.playlistCount > 0 then
        self.playlist[1].sound:play()
    end

    -- load audio effects
    if type(tape.effects) == "table" then
        for i, v in ipairs(tape.effects) do
            local name = v.name
            v.name = nil
            love.audio.setEffect(name, v)
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------

function soundManager:update(dt)
    for i, v in ipairs(self.sounds) do
        v:update(dt)
    end

    self.playedsounds = 0
    for i, v in ipairs(self.playlist) do
        v:update(dt)
        if v.hasFinished then
            self.playedsounds = self.playedsounds + 1
        end
    end

    -- check if the playlist is finished
    if self.playedsounds == self.playlistCount then
        for i, v in ipairs(self.playlist) do
            v.hasFinished = false
        end
        self.playlist[1].sound:play()
    end
end

--------------------------------------------------------------------------------------------------------------------------------
return soundManager
