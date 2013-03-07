package ectoplasm.views
{
	import ectoplasm.common.GameConfig;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.utils.AssetManager;
	
	public class PreGameView extends Sprite
	{
		public var startGameTriggered : Boolean;
		
		private var startBtn:Button;
		private var titleImage:Image;
			
		public function PreGameView(assets : AssetManager, config:GameConfig)
		{
			startBtn = new Button(assets.getTexture("start_up"));
			startBtn.x = config.halfWidth-startBtn.width/2;
			startBtn.y = 50+config.halfHeight-startBtn.height/2;
			addChild(startBtn);
			
			titleImage = new Image(assets.getTexture("ectoplasm_stamp"));
			titleImage.filter = BlurFilter.createDropShadow();
			titleImage.x = 20+ config.halfWidth-titleImage.width/2;
			titleImage.y = 200;
			addChild(titleImage);
			
			addEventListener(TouchEvent.TOUCH,onStartTouched);	
		}
		
		private function onStartTouched(e:TouchEvent):void
		{
			var t : Touch = e.getTouch(this,TouchPhase.ENDED);
			if(t) startGameTriggered = true;				
		}
	}
}