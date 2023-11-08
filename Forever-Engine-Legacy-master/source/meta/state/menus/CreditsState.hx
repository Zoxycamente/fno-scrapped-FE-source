package meta.state.menus;

// modified code from psych engine, credits to shadow mario lol!
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.utils.Assets;
import meta.MusicBeat.MusicBeatState;
import meta.data.dependency.AttachedSprite;
import meta.data.font.Alphabet;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = 1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Dynamic> = [];

	var bg:FlxSprite;
	var descText:FlxText;

	override function create()
	{
		super.create();

		bg = new FlxSprite().loadGraphic(Paths.image('menus/base/menuCredits'));
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		// should be updated with the actual team later
		var pisspoop = [
			// Name - Icon name - Description - Link
			['FNO team'],
			[
				'Ketak',
				'tur',
				'Creator Musician and Voice actor',
				'https://twitter.com/Turmoiol',
			],
			[
				'Arvarin',
				'arvarin',
				'Creator Artist, Animator and Musician',
				'https://twitter.com/arvarin_',
			],
			[
				'Zoxy',
				'ploxy',
				'Co Director, Coder, Artist, Animator and Charter',
				'https://twitter.com/Ploxycamente2',
			],
			[
				'VINI!!11111!!!11',
				'vini',
				'Co Director, Artist',
				'https://www.youtube.com/channel/UC6MCAJ5vcWHgpfGjF7nfNXQ'
			],
			[
				'Square9',
				'square',
				'Charter',
				'https://twitter.com/Square_917',
			],
			[
				'Deko',
				'deko',
				'Charter',
				'https://www.youtube.com/channel/UCNCAVPRQKDs1osZT-sR5mcA',
			],
			[
				'Vyrox',
				'cat',
				'Charter',
				'',
			],
			[
				'Yupam',
				'yupam_icone_legal',
				'Musician',
				'https://www.youtube.com/channel/UCgrVlJBKDSc8fUWy7S_PV1A',
			],
			[
				'Sar',
				'',
				'Musician',
				'',
			],
			[
				'Sloow',
				'sloow',
				'Coder',
				'',
			],
			[
				'Nerdin',
				'nerd',
				'Musician',
				'https://www.youtube.com/channel/UCe1SMkzjchAJPdAoLhZjd8Q',
			]
		];

		for (i in pisspoop)
		{
			creditsStuff.push(i);
		}

		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			if (isSelectable)
			{
				optionText.x -= 70;
			}
			// optionText.xTo = Std.int(optionText.x);
			// optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if (isSelectable && (creditsStuff[i][1] != ''))
			{
				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;

				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
			}
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		changeSelection();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			Main.switchState(this, new MainMenuState());
		}
		if (controls.ACCEPT && (creditsStuff[curSelected][3] != ''))
		{		}
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do
		{
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		}
		while (unselectableCheck(curSelected));

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if (!unselectableCheck(bullShit - 1))
			{
				item.alpha = 0.6;
				if (item.targetY == 0)
				{
					item.alpha = 1;
				}
			}
		}
		descText.text = creditsStuff[curSelected][2];
	}

	private function unselectableCheck(num:Int):Bool
	{
		return creditsStuff[num].length <= 1;
	}
}
