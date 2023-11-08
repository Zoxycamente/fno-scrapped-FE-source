animsseta= {}

local defaultstrumy
local noteoffset

animas = {}
tempoidle = -1.0

function makeAnimationList()
	animas[0] = 'singLEFT';
	animas[1] = 'singDOWN';
	animas[2] = 'singUP';
	animas[3] = 'singRIGHT';
    	animas[4] = 'idle';
end

function makeAnimationListk()
	animsseta[0] = 'keyArrow' -- idle
	animsseta[1] = 'keyConfirm' -- key confirmed
	animsseta[2] = 'keyPressed' -- key miss
end

offsets = {};

offsetsnija = {};
function makeOffsets()
	offsetsnija[0] = {x = 340, y = 0}; --left
	offsetsnija[1] = {x = 270, y = -90}; --down
	offsetsnija[2] = {x = 230, y = 50}; --up
	offsetsnija[3] = {x = 150, y = -5}; --right
    	offsetsnija[4] = {x = 210, y = 10}; --idle
end

function makeOffsetsk(object)
	offsets[0] = {x=36, y=36}
	offsets[1] = {x=61, y=59}
	offsets[2] = {x=34, y=34}
end

function onCreate()
	makeAnimationList();
	makeOffsets();

	makeAnimatedLuaSprite('ninjacu', 'characters/ninja_vermelhonew',  500, 340);
	addAnimationByPrefix('ninjacu', 'idle', 'idle ver', 24, false);
	addAnimationByPrefix('ninjacu', 'singLEFT', 'left ver', 24, false);
	addAnimationByPrefix('ninjacu', 'singDOWN', 'down ver', 24, false);
	addAnimationByPrefix('ninjacu', 'singUP', 'up ver', 24, false);
	addAnimationByPrefix('ninjacu', 'singRIGHT', 'right ver', 24, false);

	scaleObject('ninjacu', 1.4, 1.4)
	setObjectOrder('ninjacu', 6)


	playAnimationc('ninjacu', 4, true);
end

function onCreatePost()	
	defaultstrumy = 673
	noteoffset = -500

	if not downscroll then
		defaultstrumy = -50
		noteoffset = 80
	end

	directions = {'left', 'down', 'up', 'right'}
	makeAnimationListk()
	makeOffsetsk()

	for i=1, #directions do
		makeAnimatedLuaSprite('strum'..directions[i], 'NOTE_assets', getPropertyFromGroup('opponentStrums', i-1, 'x') + 322--[[screenWidth / 2 - 2*177 + 105 * i--]], defaultstrumy - 100)
		if not downscroll then
			setProperty('strum'..directions[i]..'.y', defaultstrumy+100)
		end		

		addAnimationByPrefix('strum'..directions[i], 'keyConfirm', directions[i]..' confirm', 24, false)
		addAnimationByPrefix('strum'..directions[i], 'keyPressed', directions[i]..' press', 24, false)
		addAnimationByPrefix('strum'..directions[i], 'keyArrow', 'arrow'..directions[i]:upper(), 24, false)

		setObjectCamera('strum'..directions[i], 'camHUD')
		scaleObject('strum'..directions[i], 0.68, 0.68)
		
		setProperty('strum'..directions[i]..'.alpha', 0)

		if not middlescroll then
		setProperty('strum'..directions[i]..'.x', -600)
		else
		setProperty('strum'..'left'..'.x', -600)
		setProperty('strum'..'down'..'.x', -600)
		setProperty('strum'..'up'..'.x', 2000)
		setProperty('strum'..'right'..'.x', 2000)
		end

		
		addLuaSprite('strum'..directions[i])

		playAnimationk('strum'..directions[i], 0, true)
	end

end



function onEvent(n, v1, v2)
    if n == 'ninja vermeio strum k' then
		if not middlescroll then
			offset = 0
			for i = 0, 3 do
				noteTweenX('bf'..i, i+4, 850 + offset, 1, 'cubeInOut')

				noteTweenX('dad'..i, i, 440 + offset, 1, 'cubeInOut')

				offset = offset + 100
			end

			doTweenX('cu0', 'strum'..'left', 30, 1.5, 'elasticInOut')
			doTweenX('cu1', 'strum'..'down', 130, 1.5, 'elasticInOut')
			doTweenX('cu2', 'strum'..'up', 230, 1.5, 'elasticInOut')
			doTweenX('cu3', 'strum'..'right', 330, 1.5, 'elasticInOut')

			doTweenAlpha('cuu0', 'strum'..'left', 1, 1.5, 'elasticInOut')
			doTweenAlpha('cuu1', 'strum'..'down', 1, 1.5, 'elasticInOut')
			doTweenAlpha('cuu2', 'strum'..'up', 1, 1.5, 'elasticInOut')
			doTweenAlpha('cuu3', 'strum'..'right', 1, 1.5, 'elasticInOut')

		else
			noteTweenX('bunda0', 0, 206, 1, 'cubeInOut')
			noteTweenX('bunda1', 1, 306, 1, 'cubeInOut')
			noteTweenX('bunda2', 2, 860, 1, 'cubeInOut')
			noteTweenX('bunda3', 3, 960, 1, 'cubeInOut')

			doTweenX('cu0', 'strum'..'left', -6, 1.5, 'elasticInOut')
			doTweenX('cu1', 'strum'..'down', 96, 1.5, 'elasticInOut')
			doTweenX('cu2', 'strum'..'up', 1070, 1.5, 'elasticInOut')
			doTweenX('cu3', 'strum'..'right', 1170, 1.5, 'elasticInOut')

			doTweenAlpha('cuu0', 'strum'..'left', 0.5, 1.5, 'elasticInOut')
			doTweenAlpha('cuu1', 'strum'..'down', 0.5, 1.5, 'elasticInOut')
			doTweenAlpha('cuu2', 'strum'..'up', 0.5, 1.5, 'elasticInOut')
			doTweenAlpha('cuu3', 'strum'..'right', 0.5, 1.5, 'elasticInOut')
		end
	end
end

function playAnimationc(character, animId, forced)
	animName = animas[animId];
	if character == 'ninjacu' then
		objectPlayAnimation('ninjacu', animName, forced)
		setProperty('ninjacu.offset.x', offsetsnija[animId].x);
		setProperty('ninjacu.offset.y', offsetsnija[animId].y);
	end
end

function playAnimationk(character, animId, forced)
	animName = animsseta[animId]

	objectPlayAnimation(character, animName, forced);
	
	setProperty(character..'.offset.x', offsets[animId].x);
	setProperty(character..'.offset.y', offsets[animId].y);
	
	if animId == 1 then
		runTimer('stopanim'..character, 0.1)
	end
end

function onTimerCompleted(tag)
	if(string.sub(tag,1,8) == "stopanim") then
        	playAnimationk(string.sub(tag,9), 0, true)
    	end
end

function onUpdate(elapsed)
	holdCap = stepCrochet * 0.004;
	if tempoidle >= 0 then
		tempoidle = tempoidle + elapsed;
		if tempoidle >= holdCap then
			playAnimationc('ninjacu', 4, false);
			tempoidle = -1;
		end
	end
end

function onCountdownTick(counter)
	beatHitDance(counter);
end

function onBeatHit()
	beatHitDance(curBeat);
end

function beatHitDance(counter)
	if counter % 1 == 0 then
		if tempoidle < 0 then
			playAnimationc('ninjacu', 4, false);
		end
	end
end
function onUpdatePost()
	for i=0, getProperty('notes.length')-1 do
		if getPropertyFromGroup('notes', i, 'noteType') == 'rednote' or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' then

			noteX = getPropertyFromGroup('notes', i, 'x');
			noteY = getPropertyFromGroup('notes', i, 'y');

			setPropertyFromGroup('notes', i, 'ignoreNote', true)	

			hitbox = 50;
			isSustainNote = getPropertyFromGroup('notes', i, 'isSustainNote');
			
			noteData = getPropertyFromGroup('notes', i, 'noteData');
			
			strumY = getProperty('strum'..directions[noteData + 1]..'.y')	

			noteX = getProperty('strum'..directions[noteData + 1]..'.x')

			if isSustainNote then
				noteX = noteX + 38;
			end
			
			setPropertyFromGroup('notes', i, 'x', noteX)
			setPropertyFromGroup('notes', i, 'y', noteY)

			if math.abs(noteY - strumY) <= hitbox then
				if getProperty('SONG.needsVoices') then
					setProperty('vocals.volume', 1)
				end
				playAnimationk('strum'..directions[noteData+1], 1, false)
				tempoidle = 0;
				if getPropertyFromGroup('notes', i, 'noteType') == 'rednote' then
					playAnimationc('ninjacu', noteData, true);
				end
				removeFromGroup('notes', i)
			end
		end
	end
end