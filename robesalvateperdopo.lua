function love.load()
    -- Carica il file audio (in stereo)
    local originalSource = love.audio.newSource("audio/miosuono_stereo.ogg", "static")

    -- Ottieni i dati del suono
    local soundData = originalSource:getSoundData()

    -- Creiamo un nuovo SoundData mono
    local monoData = love.sound.newSoundData(soundData:getSampleCount() / 2, soundData:getSampleRate(), 1, soundData:getBitDepth())

    -- Convertiamo i dati stereo in mono (media dei due canali)
    for i = 0, soundData:getSampleCount() - 1 do
        local left = soundData:getSample(i * 2)   -- Canale sinistro (stereo)
        local right = soundData:getSample(i * 2 + 1) -- Canale destro (stereo)
        
        -- Media dei due canali per ottenere un suono mono
        local mono = (left + right) / 2

        -- Impostiamo il valore nel nuovo SoundData mono
        monoData:setSample(i, mono)
    end

    -- Creiamo un nuovo Source con il suono mono
    local monoSource = love.audio.newSource(monoData)

    -- Riproduciamo il suono mono
    monoSource:play()
end
