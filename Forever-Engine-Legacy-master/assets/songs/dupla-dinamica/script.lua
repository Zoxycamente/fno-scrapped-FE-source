function onCreate()
	forca = 20
	tempo = 0.1

	--deu mo preguica de faze isso de forca kkkkkkkk
end

function onBeatHit()

end

function onUpdatePost(elapsed)
	setProperty('vocals.volume', 1)
	setProperty('healthBar.alpha', 0)
	setProperty('iconP1.alpha', 0)
	setProperty('iconP2.alpha', 0)
	songPos = getSongPosition()
	local currentBeat = (songPos/5000)*(curBpm/60)

	if a > 0 then a = a - 0.1 else a = 1 end

	setProperty('vocals.volume', a)

	noteTweenY('defaultOpponentStrumY0', 0, defaultPlayerStrumY0 - 50*math.sin((currentBeat+2*0.25)*math.pi), 0.5)
	noteTweenY('defaultOpponentStrumY1', 1, defaultPlayerStrumY1 - 50*math.sin((currentBeat+4*0.25)*math.pi), 0.5)
	noteTweenY('defaultOpponentStrumY2', 2, defaultPlayerStrumY2 - 50*math.sin((currentBeat+1*0.25)*math.pi), 0.5)
	noteTweenY('defaultOpponentStrumY3', 3, defaultPlayerStrumY3 - 50*math.sin((currentBeat+3*0.25)*math.pi), 0.5)
	noteTweenY('defaultPlayerStrumY0', 4, defaultPlayerStrumY0 - 50*math.sin((currentBeat+4*0.25)*math.pi), 0.5)
	noteTweenY('defaultPlayerStrumY1', 5, defaultPlayerStrumY1 - 50*math.sin((currentBeat+5*0.25)*math.pi), 0.5)
	noteTweenY('defaultPlayerStrumY2', 6, defaultPlayerStrumY2 - 50*math.sin((currentBeat+6*0.25)*math.pi), 0.5)
	noteTweenY('defaultPlayerStrumY3', 7, defaultPlayerStrumY3 - 50*math.sin((currentBeat+7*0.25)*math.pi), 0.5)
	noteTweenY('defaultPlayerStrumY0', 4, defaultPlayerStrumY0 - 50*math.sin((currentBeat+4*0.25)*math.pi), 0.5)
	noteTweenY('defaultPlayerStrumY1', 5, defaultPlayerStrumY1 - 50*math.sin((currentBeat+5*0.25)*math.pi), 0.5)
	noteTweenY('defaultPlayerStrumY2', 6, defaultPlayerStrumY2 - 50*math.sin((currentBeat+6*0.25)*math.pi), 0.5)
	noteTweenY('defaultPlayerStrumY3', 7, defaultPlayerStrumY3 - 50*math.sin((currentBeat+7*0.25)*math.pi), 0.5)
	doTweenY('modc0', 'strum'..'left', defaultPlayerStrumY3 + forca*math.sin((currentBeat+8*0.25)*math.pi), tempo)
	doTweenY('modc1', 'strum'..'down', defaultPlayerStrumY3 + forca*math.sin((currentBeat+9*0.45)*math.pi), tempo)
	doTweenY('modc2', 'strum'..'up', defaultPlayerStrumY3 + forca*math.sin((currentBeat+10*0.25)*math.pi), tempo)
	doTweenY('modc3', 'strum'..'right', defaultPlayerStrumY3 + forca*math.sin((currentBeat+11*0.45)*math.pi), tempo)
end