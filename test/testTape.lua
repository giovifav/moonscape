---the tape file always return a table
return {
    title = "A sample TapeFile definition", -- tape title
    author = "Giovanni Favaro", -- optional - tape author
    info = "", -- optional - extra info 
    cover = "cover.png", -- optional - relative path to the cover art (jpeg, png) for the tape
    cover =  { "cover1.png", "cover2.png" }, -- optional - array of relative path to the cover art (jpeg, png) for the tape
    video = "video.ogv", -- optional - relative path to the video ( Ogg Theora video ) for the tape
    video = { "video1.ogv", "video2.ogv" }, -- optional - array of relative path to the video ( Ogg Theora video ) for the tape
    volume = 1, -- set the master volume between 0 and 1 , the master volume is also controllable via gui - optional - default = 1
   
    sounds = {
        -- the sounds table in an array of tables, every subtable contains info for a specific sound
        {
            -- SOUND SOURCE------------------------------------------------------------------------------------------------------------------------------
            -- if sound is a string must be the relative path to the sound file
            source = "firecracker.wav",
            -- the  sound can be a generator -- a generator generate sound noise or pure waves
            source = {waveform = 'sawtooth', frequency = 440},
            --------------------------------------------------------------------------------------
            --LOADING METHOD
            -- the sound can be loaded in different way
            -- stream = load the sound in a streaming way, this is the default method
            -- static = load the sound in a static way, this is useful for short sound
            -- VOLUME---------------------------------------------------------------------------
            -- sound specific volume for the source (between 0,1)
            volume = 1,
            volume = 0.4,
            volume = { 0, 1 }, -- random volume every reproduction between min and max
            volume = {0, 1, 4}, -- tween the volume between 0 an 1 in 4 seconds
            volume = {0, 1, 0}, -- tween the volume between 0 an 1 in the duration of the sound
            --------------------------------------------------------------------------------------
            -- PLAYBACK------------------------------------------------------------------------------
            -- how the sound is reproducted
            playback = { 8, 16 }, -- random playback between 8 and 16 seconds   
            playback = 5, -- playback every 5 seconds 
            playback = "loop", -- the sound will loop forever,
            playback = "playlist", -- the sound will be added to the tape playlist, schedule playback will be ignored 
            ----------------------------------------------------------------------------------------------
            -- SCHEDULE PLAYBACK------------------------------------------------------------------------------------------------------------------------------
            -- set the hours ( in 24H format) in that the sound will played
            -- this is useful for making tape that play differenty in different time of  a day
            schedule = 8, -- the sound is played only at 8 am
            schedule = { 8, 11 }, -- the sound is played only at 8 am and  at 11 am
            schedule = { 8, 9, 10, 11 }, -- the sound is played between 8 and 11 am
            --------------------------------------------------------------------------------------------------------------------------------
            -- POSITION------------------------------------------------------------------------------------------------------------------------------
            -- set the position of sound, only work for mono sounds and generators
            position = { -0.7, 0.9 }, -- set the audio position
            position = { { -1, 1 }, { -1, 1 } }, -- set a random audio position (between range) every time the audio is played
           -- position = { {  -0.7, 0.9 }, {  0.9, -0.7  }, 4  }, -- tween an  audio position (from start position to finish position) in four seconds every time the audio is played
            --position = { {  { -1, 1 }, { -1, 1 }}, {  { -1, 1 }, { -1, 1 } }, 4  }, -- tween an  audio position (from random start position to random finish position) in four seconds every time the audio is played
            --position = { {  { -1, 1 }, { -1, 1 }}, {  { -1, 1 }, { -1, 1 } }, 0  }, -- tween an  audio position (from random start position to random finish position)  in the duration of the sound every time the audio is played
            -------------------------------------------------------------------------------------------------------------------
            -- EFFECTS--------------------------------------------------------------------------------------------------------
            effects = "standard_reverb", -- set effect to standard reverb
            effects = { "small_distortion", "standard_reverb" }, -- set effect to a random choised effect every playback
            -- PITCH---------------------------------------------------------------------
            -- Calculated with regard to 1 being the base pitch. Each reduction by 50 percent equals a pitch shift of -12 semitones (one octave reduction). Each doubling equals a pitch shift of 12 semitones (one octave increase). Zero is not a legal value
            pitch = 0.5, -- One octave lower
            pitch = 2, -- One octave higher
            pitch = 1, -- Reset to normal pitch
            pitch = { 0.5, 2 }, -- a random pitch between one octave lower and one octave higher every time is played
            pitch = { 0.5, 2, 4 }, -- tween a random pitch between one octave lower and one octave higher every time is played
            -----------------------------------------------------------------------------------------------

        },
        {
            --  SECOND SOUND SOURCE
        },
        {
            --  THIRD SOUND SOURCE
        },
    },
    effects = { 
          -- EFFECTS--------------------------------------------------------------------------------------------------
    --[[
        effects are applied in realtime 
        the effects is a table that contain a subtable for each defined effect
    ]]
        {
            name = "small_distortion",
            type = 'distortion',
            gain = 0.5,
            edge = 0.25
        }, 
        { 
            name = "standard_reverb", 
            type = 'reverb'
        },
        {
            name= "chorus1",
            type="chorus",
            waveform="sine",
            phase=53.57,
            rate=2.5,
            depth=.02979,
            feedback=.9298,
            delay=.004081
        },
        {
            name = "flanger1",
            type="flanger",
            volume=1,
            waveform="triangle",
            phase=0,
            rate=.27,
            depth=1,
            feedback=-.5,
            delay=.002
        },
        {
            name = "equalizer1",
            type="equalizer",
            volume=1,
            lowgain=1,
            lowcut=200,
            lowmidgain=1,
            lowmidfrequency=500,
            lowmidbandwidth=1,
            highmidgain=1,
            highmidfrequency=3000,
            highmidbandwidth=1,
            highgain=1,
            highcut=6000
        },
        {
            name = "compressor1",
            type="compressor",
            volume=.63443077339102,
            enable=true
        },
        {
            name = "reverb1",
            type="reverb",
            volume=1,
            density=1,
            diffusion=.3,
            gain=.3162,
            highgain=.7328,
            decaytime=1.49,
            decayhighratio=.86,
            earlygain=.25,
            earlydelay=.007,
            lategain=.9954,
            latedelay=.011,
            airabsorption=.9943,
            roomrolloff=0,
            highlimit=true
        }
    }
}
