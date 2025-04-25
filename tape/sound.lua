local current_folder = (...):gsub('%.[^%.]+$', '')

local Object = require(current_folder .. '.oop')
local Flux = require(current_folder .. ".flux")
local playlist = {}
--------------------------------------------------------------------------------------------------------------------------------
local function clamp(val, lower, upper)
    if lower > upper then
        lower, upper = upper, lower
    end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end

--------------------------------------------------------------------------------------------------------------------------------

local function count(t)
    local count = 0
    for _, _ in pairs(t) do
        count = count + 1
    end
    return count
end
--------------------------------------------------------------------------------------------------------------------------------
local sound = Object:extend()
--------------------------------------------------------------------------------------------------------------------------------
function sound:new(ops, path)
    assert(type(ops) == "table", 'the sound arguments must be  a table')
    assert(ops.source, "no source data found in a sound")
    self.paused = false
    self.volume = ops.volume or 1
    self.schedule = ops.schedule or nil
    self.pitch = ops.pitch or 0
    self.position = ops.position or nil
    self.tween = ops.volumeTween or nil
    self.effects = ops.effects or nil
    self.loading = ops.loading or "stream"
    self.hasFinished = false
    self.effects = ops.effects or nil
    self.effectsCount = count(ops.effects) or 0

    self.sound = love.audio.newSource(path .. ops.source, self.loading)

    if type(self.playback) == "string" then
        if self.playback == "loop" then
            self.sound:setLooping(true)
        elseif self.playback == "playlist" then
            self.sound:setLooping(false)
        end
    elseif type(self.playback) == "table" or type(self.playback) == "number" then
        self.playback = ops.playback
        self.sound:setLooping(false)
    end

    sound:resetTime()
end

--------------------------------------------------------------------------------------------------------------------------------
function sound:update(dt)

    local function playable(schedule)
        if schedule then
            local time = os.date('*t')
            if type(schedule) == "number" then
                if time.hour == schedule then
                    return true
                end
            elseif type(schedule) == "table" then
                for k, v in ipairs(schedule) do
                    if time.hour == v then
                        return true
                    end
                end
            end
        else
            return true
        end
    end
    if not self.playback == "playlist" then
        if not self.paused and not self.loop then
            self.time = self.time + dt
            if self.time > self.soundTimer and playable(self.schedule) then
                self:play()
            end
        end

        if self.loop and playable(self.schedule) and not self.paused and not self.sound:isPlaying() then
            self.sound:play()
        elseif self.loop and self.sound:isPlaying() and not playable(self.schedule) then
            self.sound:stop()
        end
    end

    if self.playback == "playlist" then
        if not self.hasFinished then
            local position = sound:tell()
            local duration = sound:getDuration()

            -- Confronto con una tolleranza piccola per evitare problemi di precisione
            if position >= duration - 0.01 and not sound:isPlaying() then
                self.hasFinished = true
            end
        end
    end

end
--------------------------------------------------------------------------------------------------------------------------------
function sound:resetTime()
    if type(self.playback) == "table" then
        self.soundTimer = love.math.random(self.playback[1], self.playback[2])
    elseif type(self.playback) == "number" then
        self.soundTimer = self.playback
    else
        self.soundTimer = 0
    end
    self.time = 0
end

--------------------------------------------------------------------------------------------------------------------------------
function sound:setVolume()
    if type(self.volume) == "table" then
        local volume = love.math.random(self.volume[1] * 10, self.volume[2] * 10) / 10
        self.sound:setVolume(clamp(volume, 0, 1))
    else
        self.sound:setVolume(clamp(self.volume, 0, 1))
    end
end

--------------------------------------------------------------------------------------------------------------------------------
function sound:setPitch()
    if type(self.pitch) == "table" then
        local pitch = love.math.random(self.pitch[1] * 10, self.pitch[2] * 10) / 10
        self.sound:setPitch(pitch)
    elseif type(self.pitch) == "number" then
        self.sound:setPitch(self.pitch)
    end
end

--------------------------------------------------------------------------------------------------------------------------------
---
function sound:setPosition()
    if type(self.position) == "table" then
        if type(self.position[1]) == "table" and type(self.position[2]) == table and type(self.position[3]) == "table"then
            local x = love.math.random(self.position[1][1] * 10, self.position[1][2] * 10) / 10
            local y = love.math.random(self.position[2][1] * 10, self.position[2][2] * 10) / 10
            local z = love.math.random(self.position[3][1] * 10, self.position[3][2] * 10) / 10
            self.sound:setPosition(x, y, z)
        else
            self.sound:setPosition(self.position[1], self.position[2], self.position[3])
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------

function sound:setEffects()
    if type(self.effects) == "string" then
        self.sound:setEffect(self.effects)
    elseif type(self.effects) == "table" then
        for i, v in ipairs(self.effects) do
            self.sound:setEffect(v, false)
        end
        local effect = love.math.random(1, self.effectsCount)
        self.sound:setEffect(self.effects[effect], true)
    end
end
--------------------------------------------------------------------------------------------------------------------------------
function sound:play()
    self:setVolume()
    self:setPitch()
    self:resetTime()
    self:setEffects()
    self:setPosition()
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
