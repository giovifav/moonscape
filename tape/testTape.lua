---the tape file always return a table
return {
    title = "", -- tape title
    author = "", -- optional - tape author
    info = "", -- optional - extra info like credits
    cover = "", -- optional - relative path to the cover art (jpeg, png) for the tape
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
            playback = "playlist" -- the sound will be added to the tape playlist, schedule playback will be ignored 
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
            position = { {  -0.7, 0.9 }, {  0.9, -0.7  }, 4  }, -- tween an  audio position (from start position to finish position) in four seconds every time the audio is played
            position = { {  { -1, 1 }, { -1, 1 }}, {  { -1, 1 }, { -1, 1 } }, 4  }, -- tween an  audio position (from random start position to random finish position) in four seconds every time the audio is played
            position = { {  { -1, 1 }, { -1, 1 }}, {  { -1, 1 }, { -1, 1 } }, 0  }, -- tween an  audio position (from random start position to random finish position)  in the duration of the sound every time the audio is played
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
            -- SOUND SOURCE------------------------------------------------------------------------------------------------------------------------------
            -- if sound is a string must be the relative path to the sound file
            source = "firecracker.wav",
            -- the  sound can be a generator -- a generator generate sound noise or pure waves
            source = {waveform = 'sawtooth', frequency = 440},
            --------------------------------------------------------------------------------------
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
            position = { {  -0.7, 0.9 }, {  0.9, -0.7  }, 4  }, -- tween an  audio position (from start position to finish position) in four seconds every time the audio is played
            position = { {  { -1, 1 }, { -1, 1 }}, {  { -1, 1 }, { -1, 1 } }, 4  }, -- tween an  audio position (from random start position to random finish position) in four seconds every time the audio is played
            position = { {  { -1, 1 }, { -1, 1 }}, {  { -1, 1 }, { -1, 1 } }, 0  }, -- tween an  audio position (from random start position to random finish position)  in the duration of the sound every time the audio is played
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
    },
    effects = { 
    {
        name = "small_distortion",
        type = 'distortion',
        gain = 0.5,
        edge = 0.25
    }, 
    { 
        name = "standard_reverb", 
        type = 'reverb' ,
    },
    -- EFFECTS--------------------------------------------------------------------------------------------------
    --[[
        effects are applied in realtime 
        the effects variable is a table that contain a subtable for each effect
        follow a list of type name of an effect with other info about effect options 

        -chorus
        Plays multiple copies of the sound with slight pitch and time variation. Used to make sounds sound "fuller" or "thicker".
        EffectWaveform waveform
        number phase
        number rate
        number depth
        number feedback
        number delay

        -compressor
        Decreases the dynamic range of the sound, making the loud and quiet parts closer in volume, producing a more uniform amplitude throughout time.
        boolean enable

        -distortion
        Alters the sound by amplifying it until it clips, shearing off parts of the signal, leading to a compressed and distorted sound.
        number gain
        number edge
        number lowcut
        number center
        number bandwidth

        -echo
        Decaying feedback based effect, on the order of seconds. Also known as delay; causes the sound to repeat at regular intervals at a decreasing volume.
        number delay
        number tapdelay
        number damping
        number feedback
        number spread

        -equalizer
        Adjust the frequency components of the sound using a 4-band (low-shelf, two band-pass and a high-shelf) equalizer.
        number lowgain
        number lowcut
        number lowmidgain
        number lowmidfrequency
        number lowmidbandwidth
        number highmidgain
        number highmidfrequency
        number highmidbandwidth
        number highgain
        number highcut

        -flanger
        Plays two copies of the sound; while varying the phase, or equivalently delaying one of them, by amounts on the order of milliseconds, resulting in phasing sounds.
        EffectWaveform waveform
        number phase
        number rate
        number depth
        number feedback
        number delay

        -reverb
        Decaying feedback based effect, on the order of milliseconds. Used to simulate the reflection off of the surroundings.
        number gain
        number highgain
        number density
        number diffusion
        number decaytime
        number decayhighratio
        number earlygain
        number earlydelay
        number lategain
        number latedelay
        number roomrolloff
        number airabsorption
        boolean highlimit

        -ringmodulator
        An implementation of amplitude modulation; multiplies the source signal with a simple waveform, to produce either volume changes, or inharmonic overtones.
        EffectWaveform waveform
        number frequency
        number highcut
        ]]
    }
}
