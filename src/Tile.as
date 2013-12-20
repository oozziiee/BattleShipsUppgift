package  
{
	import flash.display.Bitmap;
	import flash.geom.ColorTransform;

	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ozzie
	 */
	public class Tile extends Sprite
	{
		//The image for how it looks when you bomb a tile and don't hit a ship.
		[Embed(source="../lib/waterMiss.jpg")]
		private var missImage:Class;
		//The image for ordinary water
		[Embed(source="../lib/water.jpg")]
		private var waterImage:Class;
		//The image for how it will look when you bomb and hit a ship.
		[Embed(source="../lib/waterHit.jpg")]
		private var hitImage:Class
		//These have to be different else they will give weird values.
		public static const MISS:int = 1;
		public static const HIT:int = 2;
		//This is about the boats coordinations and making a var ship for later use in a function.
		public var xCoord:int;
		public var yCoord:int;
		public var ship:Boolean = false;
		public var state:String = new String;
		public var clickedOn:Boolean = false;
		

		public function Tile() 
		{
			//drawing the normal tiles that is just water
			this.graphics.beginBitmapFill(Bitmap(new waterImage()).bitmapData);
			this.graphics.drawRect(0, 0, 32,32)
			this.graphics.endFill();
		}
		
		public function resetTile():void 
		{
			//setting all the misses and hits to normal water again.
			this.graphics.clear()
			this.graphics.beginBitmapFill(Bitmap(new waterImage()).bitmapData);
			this.graphics.drawRect(0, 0, 32, 32);
			this.graphics.endFill();
		}
		public function bombIt():int
		{
			if (!this.clickedOn) 
			{
				this.graphics.clear()
				if (ship) 
				{
					//giving the ship a hit image 
					this.graphics.clear();
					this.graphics.beginBitmapFill(Bitmap(new hitImage()).bitmapData);
					this.graphics.drawRect(0, 0, 32, 32);
					this.graphics.endFill();
					this.clickedOn = true;
					return HIT
					
				}
				else 
				{
					//giving the misses a miss image 
					this.graphics.clear();
					this.graphics.beginBitmapFill(Bitmap(new missImage()).bitmapData);
					this.graphics.drawRect(0, 0, 32, 32);
					this.graphics.endFill();
					this.clickedOn = true;
					return MISS
					
				}
			}
			else 
			{
				return 0 //just so it return "something"
			}
		}
		//used to make the boats in Main.as.
		public function makeBoat():void 
		{
			this.ship = true;
		}
	}
}