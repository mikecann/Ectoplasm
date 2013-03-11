package ectoplasm.components.game
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;

	public class Display
	{
		public var container : Sprite = null;
		public var depth : Number = 0;
		
		public function Display(displayObject : DisplayObject=null, depth:Number=0)
		{
			this.container = new Sprite();
			this.depth = depth;
			if(displayObject) this.container.addChild(displayObject);					
		}
	}
}