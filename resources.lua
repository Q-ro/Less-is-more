--	#####################################################
--	# Title:		resources.lua						#
--	# Author:		Andres Mrad (Q-ro)					#
--	# Date:			Dec 01 2017							#
--	# Description:	Load and configure game resources	#
--	#####################################################

local lg = love.graphics

-- Global fonts
font = {}

-- Global SFX
sfx = {}

--- Load all resources including images, quads sound effects etc.
function loadResources()
	-- Load the pixel font from image
	font.normal =
		loadFont("Font2", " abcdefghijklmnopqrstuvwxyz" .. "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" .. '123456789.,!?-+/():;%&`\'*#=[]"')

	font.bold = loadFont("boldfont", " ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!'-:*@<>+/_$&?")

	font.digital = lg.newFont("Assets/Font/digital-7.ttf", 35)

	lg.setFont(font.bold)

	sfx.confirm = loadSound("Thunder", "wav")
	sfx.bork = loadSound("BorkBork", "wav")
	sfx.pop = loadSound("BubblePop", "wav")
end

---
function loadAnimation(image, width, height, duration)
	local animation = {}
	animation.spriteSheet = image
	animation.Quads = {}

	for y = 0, image:getHeight() - height, height do
		for x = 0, image:getWidth() - width, width do
			table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
		end
	end

	animation.duration = duration or 1
	animation.currentTime = 0

	return animation
end

--- Loads sound samples and effects
-- @name: name of the file
-- @ext: the file extension
function loadSound(name, ext)
	return love.audio.newSource("Assets/Sounds/" .. name .. "." .. ext)
end

--- Loads sprite a font file
-- @name: name of the file
-- @chars: the chars on the font file
function loadFont(name, chars)
	return lg.newImageFont(("Assets/Font/" .. name .. ".png"), chars)
end

--- Plays a SFX
-- @name: name of the file
function playSound(name)
	love.audio.play(sfx[name])
end

--- Plays a song
-- @name: name of the file
-- @loop: difines if the song must be looped
function playMusic(name, loop)
	-- Stop previously playing music if any
	if music then
		music:stop()
	end
	-- Play new file
	music_name = name
	music = love.audio.newSource("data/sfx/" .. name .. ".ogg", "stream")
	music:addTags("music")
	if loop ~= nil then
		music:setLooping(loop)
	else
		music:setLooping(true)
	end
	love.audio.tags.music.setVolume(config.music_volume)
	love.audio.play(music)
end

--- Stops the current song playing (if any)
function stopMusic()
	if music then
		music:stop()
	end
end
