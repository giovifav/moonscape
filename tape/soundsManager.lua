local current_folder = (...):gsub('%.[^%.]+$', '')
local Object = require(current_folder .. '.oop')
local sound = require(current_folder .. ".sound")
local sandbox = require(current_folder .. ".sandbox")
local soundsManager = Object:extend()
--------------------------------------------------------------------------------------------------------------------------------
local function count(t)
    local count = 0
    for _, _ in pairs(t) do
        count = count + 1
    end
    return count
end
--------------------------------------------------------------------------------------------------------------------------------
local function clamp(val, lower, upper)
    if lower > upper then
        lower, upper = upper, lower
    end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end
--------------------------------------------------------------------------------------------------------------------------------
function soundsManager:new(tape)
    self.sounds = {}
    self.playlist = {}
    self.currentTrack = 1
    love.filesystem.mount(tape, "tape")

    assert(love.filesystem.getInfo("tape/tape.lua") ~= nil)
    local tape = sandbox(love.filesystem.load("tape/tape.lua"))()
    for i, v in ipairs(tape.sounds) do
        if v.playback == "playlist" then
            table.insert(self.playlist, sound(v, "tape/"))
        else
            table.insert(self.sounds, sound(v, "tape/"))
            v:play()
        end
    end
    self.title = tape.title or "tape"
    self.author = tape.author or "unknown"
    self.info = tape.info or "no info"
    self.cover = tape.cover or nil
    self.video = tape.video or nil
    self.volume = tape.volume or 1

    love.audio.setVolume(clamp(self.volume, 0,1))

    self.playlistCount = count(self.playlist)

    if self.playlistCount > 0 then
        self:playCurrentTrack()
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

function soundsManager:update(dt)
    for i, v in ipairs(self.sounds) do
        v:update(dt)
    end
    if self.playlistCount > 0 then
        if self.playlist[self.currentTrack].hasFinished then
            -- Traccia finita, passa alla prossima
            self.currentTrack = self.currentTrack + 1
            if self.currentTrack <= self.playlistCount then
                self:playCurrentTrack()
            else

                self.currentTrack = 1
                self:playCurrentTrack()
            end
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------

function soundsManager:playCurrentTrack()
    if self.playlist[self.currentTrack] then
        self.playlist[self.currentTrack]:play()
    end
end
--------------------------------------------------------------------------------------------------------------------------------

function soundsManager:nextTrack()
    self.playlist[self.currentTrack]:pause()
    if self.currentTrack < self.playlistCount then
        self.currentTrack = self.currentTrack + 1
    else
        self.currentTrack = 1
    end
    self:playCurrentTrack()
end
--------------------------------------------------------------------------------------------------------------------------------

function soundsManager:previousTrack()
    self.playlist[self.currentTrack]:pause()
    if self.currentTrack > 1 then
        self.currentTrack = self.currentTrack - 1
    else
        self.currentTrack = self.playlistCount
    end
    self:playCurrentTrack()
end
--------------------------------------------------------------------------------------------------------------------------------

function soundsManager:pause()
    for i, v in ipairs(self.sounds) do
        v:pause()
    end
    for i, v in ipairs(self.playlist) do
        v:pause()
    end
end
--------------------------------------------------------------------------------------------------------------------------------

function soundsManager:play()
    for i, v in ipairs(self.sounds) do
        v:play()
    end
    if self.playlistCount > 0 then
        self.playlist[self.currentTrack]:play()
    end
end
--------------------------------------------------------------------------------------------------------------------------------
return soundsManager
