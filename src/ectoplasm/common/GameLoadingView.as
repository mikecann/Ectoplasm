package ectoplasm.common
{
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class GameLoadingView extends Sprite
	{
		public var progBar : Quad;
		
		public function GameLoadingView(config:GameConfig)
		{
			var outer : Quad = new Quad(config.width,10,0);
			var inner : Quad = new Quad(config.width-2,8,0xffffff);
			progBar = new Quad(config.width-4,6,0);
			
			outer.y = config.halfHeight-5;
			inner.x = 1;
			inner.y = config.halfHeight-4;
			progBar.x = 2;
			progBar.y = config.halfHeight-3;
			
			addChild(outer);
			addChild(inner);
			addChild(progBar);
			
			setProgress(100); 			
		}
		
		public function setProgress(percent:Number) : void
		{
			progBar.scaleX = percent/100;
		}
	}
}