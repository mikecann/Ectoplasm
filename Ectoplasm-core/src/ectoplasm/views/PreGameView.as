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
		private var qmarkBtn:Button;
		private var tutorialPage : Image;
		
		private var titleImage:Image;
			
		public function PreGameView(assets : AssetManager, config:GameConfig)
		{
			startBtn = new Button(assets.getTexture("start_up"));
			startBtn.x = config.halfWidth-startBtn.width/2;
			startBtn.y = 50+config.halfHeight-startBtn.height/2;
			addChild(startBtn);
			
			qmarkBtn = new Button(assets.getTexture("helpicon"));
			qmarkBtn.x = config.width-qmarkBtn.width-20;
			qmarkBtn.y = config.height-qmarkBtn.height-20;
			addChild(qmarkBtn);
			
			titleImage = new Image(assets.getTexture("ectoplasm_stamp"));
			titleImage.filter = BlurFilter.createDropShadow();
			titleImage.x = 20+ config.halfWidth-titleImage.width/2;
			titleImage.y = 200;
			addChild(titleImage);
			
			tutorialPage = new Image(assets.getTexture("tutorial"));
			tutorialPage.x = config.halfWidth-tutorialPage.width/2;
			tutorialPage.y = config.halfHeight-tutorialPage.height/2;
			tutorialPage.visible = false;
			addChild(tutorialPage);
			
			startBtn.addEventListener(TouchEvent.TOUCH,onStartTouched);
			qmarkBtn.addEventListener(TouchEvent.TOUCH,onQMarkTouched);	
		}
		
		private function onQMarkTouched(e:TouchEvent):void
		{
			var t : Touch = e.getTouch(this,TouchPhase.ENDED);
			if(t) {
				tutorialPage.visible = !tutorialPage.visible;
				startBtn.visible = !startBtn.visible;
				titleImage.visible = !titleImage.visible;
			}
		}
		
		private function onStartTouched(e:TouchEvent):void
		{
			var t : Touch = e.getTouch(this,TouchPhase.ENDED);
			if(t) startGameTriggered = true;				
		}
	}
}