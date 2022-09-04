local sone = require("libs.sone")
local generator = require("libs.generator")
local flux = require("libs.flux")

--------------------------------------------------------------------------------------------------------------------------------
local function clamp(val, lower, upper)
    if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end
--------------------------------------------------------------------------------------------------------------------------------
local sound = Object:extend()
--------------------------------------------------------------------------------------------------------------------------------
function sound:new(ops)
    assert(type(ops) == "table", 'the sound arguments must be  a table')
    assert(ops.source, "no source data found a sound")
    self.paused = false
    self.volume = ops.volume or 1
    self.schedule = ops.schedule or nil
    self.pitch = ops.pitch or 0
    self.filters = ops.filters or nil
    self.source = ops.source
    self.position = ops.position or nil
    self.tween = ops.volumeTween or nil

    if self.source:typeOf("SoundData") then
        self.soundData = self.source
    elseif type(self.source) == "table" and not self.source:typeOf("SoundData") then -- se  è una tabella enon un sounddata allora creare un generatore
        self.soundData = generator(self.source)
    else
        self.soundData = love.sound.newSoundData(self.source)
    end

    if type(self.filters) == "table" then self:applyFilters() end

    self.sound = love.audio.newSource(self.soundData, "stream")

    if type(self.playback) == "string" then
        self.loop = true
        self.sound:setLooping(true)
    elseif type(self.playback) == "table" or type(self.playback) == "number" then
        self.playback = ops.playback
        self.sound:setLooping(false)
    end

    sound:resetTime()
    self:play()
end
--------------------------------------------------------------------------------------------------------------------------------
function sound:applyFilters()
    if self.filters.amplify then
        sone.amplify(self.soundData, self.filters.amplify)
    end
    if self.filters.pan then sone.pan(self.soundData, self.filters.pan) end
    if self.filters.fadeIn then
        if type(self.filters.fadeIn) == "table" then
            sone.fadeIn(self.soundData, self.filters.fadeIn[1],
                        self.filters.fadeIn[2])
        else
            sone.fadeIn(self.soundData, self.filters.fadeIn)
        end
    end
    if self.filters.fadeInOut then
        if type(self.filters.fadeInOut) == "table" then
            sone.fadeIn(self.soundData, self.filters.fadeInOut[1],
                        self.filters.fadeInOut[2])
        else
            sone.fadeIn(self.soundData, self.filters.fadeInOut)
        end
    end
    if self.filters.fadeOut then
        if type(self.filters.fadeOut) == "table" then
            sone.fadeIn(self.soundData, self.filters.fadeOut[1],
                        self.filters.fadeOut[2])
        else
            sone.fadeIn(self.soundData, self.filters.fadeOut)
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------
function sound:update(dt)
    local function playable()
        if self.schedule then
            local time = os.date('*t')
            if type(self.schedule) == "number" then
                if time.hour == self.schedule then return true end
            elseif type(self.schedule) == "table" then
                for k, v in ipairs(self.schedule) do
                    if time.hour == v[k] then return true end
                end
            end
        else
            return true
        end
    end

    if not self.paused and not self.loop then
        if self.time > self.soundTimer and playable() then
            self.time = self.time + dt
            self:play()
        end
    end

    if self.loop and not self.sound:isPlaying() and playable() then
        self:play()
    elseif self.loop and not playable() and not self.paused then
        self:pause()
    end
end
--------------------------------------------------------------------------------------------------------------------------------
function sound:resetTime()
    if type(self.playback) == "table" then
        self.soundTimer = love.math.random(self.playback[1], self.playback[2])
    elseif type(self.playback) == "number" then
        self.soundTimer = love.math.random(self.playback)
    else
        self.soundTimer = 0
    end
    self.time = 0
end
--------------------------------------------------------------------------------------------------------------------------------
function sound:setVolume()
    if type(self.volume) == "table" then
        local volume = love.math
                           .random(self.volume[1] * 10, self.volume[2] * 10) /
                           10
        self.sound:setVolume(clamp(volume, 0, 1))
    else
        self.sound:setVolume(clamp(self.volume, 0, 1))
    end
end
--------------------------------------------------------------------------------------------------------------------------------
function sound:setPitch()
    if type(self.pitch) == "table" then
        local pitch = love.math.random(self.pitch[1] * 10, self.pitch[2] * 10) /
                          10
        self.sound:setPitch(pitch)
    elseif type(self.pitch) == "number" then
        self.sound:setPitch(self.pitch)
    end
end
--------------------------------------------------------------------------------------------------------------------------------
function sound:play()
    self:setVolume()
    self:setPitch()
    self:resetTime()
    self.sound:play()
    self.paused = false
end
--------------------------------------------------------------------------------------------------------------------------------
function sound:pause()
    self.sound:pause()
    self.paused = true
end
--------------------------------------------------------------------------------------------------------------------------------
return sound
