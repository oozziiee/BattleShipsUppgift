package 
{
	import flash.geom.ColorTransform;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Ozzie 
	 */
	public class Main extends Sprite 
	{
		//The constant boxWH stands for the box's Width and Height. So the sides on the boxes will be the same.
		public static const boxWH:int = 32;
		//This variable will always varrie, depending on how many misses you have. 
		private var miss:int;
		private var hit:int;
		//This is named missesAndHits just because it is what it will keep contol of. It will show our amount of hits and misses.
		private var missesAndHits:TextField = new TextField();
		
		public var randomX:int = Math.random() * 9;
		public var randomY:int = Math.random() * 9;
		
		//This will be a important vector for the code. Since we will use this to push the "X" row cubes inside this one
		//so that we get all of our cubes in the right position.
		public var gridY:Vector.<Vector.<Tile>> = new Vector.<Vector.<Tile>>();
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//Giving the stage a border where you will see your amount of misses and/or hits. Eventually which kind of boats
			//that you have sank. Using a light dark for the background and a black border becuase it gives a nice theme to the 
			//whole game with sinking ships.
			missesAndHits.background = true;
			missesAndHits.border = true;
			missesAndHits.backgroundColor = (0xC0C0C0);
			missesAndHits.borderColor = (0x000000);
			addChild(missesAndHits);
			setGameBoard();
			//I've decided to put all the EventListeners here since it's easy to keep an eye on them and better to have them all in 
			//one place. We have the ones that resets and the one that makes us able to click the boxes and the one that keeps
			//count on how many misses we have.
			stage.addEventListener(MouseEvent.CLICK, clickToRemove)
			stage.addEventListener(KeyboardEvent.KEY_UP, spaceToReset)
			stage.addEventListener(Event.ENTER_FRAME, yourScore)
		}
		//clickToRemove let's us click the boxes, and removes them from the stage.
		private function clickToRemove(e:MouseEvent):void 
		{
			if (e.target != stage)
			{
				var hitOrMiss:int = Tile(e.target).bombIt();
				if (hitOrMiss == Tile.MISS) 
					miss++;
				
				if (hitOrMiss == Tile.HIT) 
					hit++;
			}
		}
		private function setGameBoard():void 
		{
			for each (var gridX:Vector.<Tile> in gridY) 
			{
				for each (var newTile:Tile in gridX) 
				{
					removeChild(newTile);
					
				}
				gridX = null;
			}
			gridY = null;
			
			gridY = new Vector.<Vector.<Tile>>;
			for (var randomY:int = 0; randomY < 10; randomY++) 
			{
				var gridX:Vector.<Tile> = new Vector.<Tile>();
				for (var randomX:int = 0; randomX < 10; randomX++) 
				{
					//Drawing the boxes with the bitmap I'm using, since the battlefield is out on water. The box size is nothing special
					//just a size that I thought will do good for it's purpose.
					var newTile:Tile = new Tile();
					newTile.x = 50 + randomX * (boxWH + 3);
					newTile.y = 125 + randomY * (boxWH + 3);
					addChild(newTile);
					gridX.push(newTile);
				}
				gridY.push(gridX);
			}
			
			for (var i:int = 0; i < 10; i++)
				miss = 0;
				hit = 0;
				//Making 4 ships onto the field with the bitmpa type I'm using. Very clear image of a hit.
				for (var k:int = 0; k < 10; k++) 
					{
						randomX = Math.random() * 9; //selecting which X coord. it will have.
						randomY = Math.random() * 9; //selecting which Y coord. it will have.
						Tile(gridY[randomY][randomX]).makeBoat(); 
					}
			}
		//This function resets all the boxes to their starting X and Y position. It also resets the amount of misses that we have.
		private function spaceToReset(e:KeyboardEvent):void 
		{
			if (e.keyCode == 32) 
			{
				setGameBoard();
			}
		}
		//This adds the text "Misses: X" inside our textfield we declared earlier in the code.
		//Where X is equal to how many misses you have.
		private function yourScore(e:Event):void 
		{
			//text box shows amount of hits and misses next to the grid/battlefield. 
			missesAndHits.text = String("Misses: " + miss + "\n" + "Hits: " + hit + "\n" + "------------------------" + "\n" + "There's 10 boats to find. They are all just 1 tile big!")
			missesAndHits.x = 400;
			missesAndHits.y = 125;
			missesAndHits.wordWrap = true;
			addChild(missesAndHits);
		}
	}
}