package ectoplasm.views
{
	import ectoplasm.common.GameConfig;
	import ectoplasm.utils.string.StringUtils;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class PostGameView extends Sprite
	{
		public var againTriggered : Boolean;
		
		private var againButton:Button;
		private var titleImage:Image;
		private var currentScore : ScoreView;
		private var highScore : ScoreView;
		private var qmarkBtn:Button;
		private var tutorialPage : Image;
			
		public function PostGameView(assets : AssetManager, config:GameConfig)
		{
			againButton = new Button(assets.getTexture("again_up"));
			againButton.x = config.halfWidth-againButton.width/2;
			againButton.y = 50+config.halfHeight-againButton.height/2;
			addChild(againButton);
			
			var s : Sprite = new Sprite();				
			
			currentScore = new ScoreView(assets,config);
			currentScore.y = 21;
			s.addChild(currentScore);	
			
			highScore = new ScoreView(assets,config);
			highScore.scaleX = highScore.scaleY = 0.5;
			highScore.x = 230;			
			s.addChild(highScore);	
			
			s.x = config.width-s.width+180;
			addChild(s);
			
			qmarkBtn = new Button(assets.getTexture("helpicon"));
			qmarkBtn.x = config.width-qmarkBtn.width-20;
			qmarkBtn.y = config.height-qmarkBtn.height-20;
			addChild(qmarkBtn);			
					
			tutorialPage = new Image(assets.getTexture("tutorial"));
			tutorialPage.x = config.halfWidth-tutorialPage.width/2;
			tutorialPage.y = config.halfHeight-tutorialPage.height/2;
			tutorialPage.visible = false;
			addChild(tutorialPage);
			
			titleImage = new Image(assets.getTexture("ectoplasm_stamp"));
			titleImage.filter = BlurFilter.createDropShadow();
			titleImage.x = 20+ config.halfWidth-titleImage.width/2;
			titleImage.y = 200;
			addChild(titleImage);
			
			againButton.addEventListener(TouchEvent.TOUCH,onAgainTouched);
			qmarkBtn.addEventListener(TouchEvent.TOUCH,onQMarkTouched);	
		}
		
		private function onQMarkTouched(e:TouchEvent):void
		{
			var t : Touch = e.getTouch(this,TouchPhase.ENDED);
			if(t) {
				tutorialPage.visible = !tutorialPage.visible;
				againButton.visible = !againButton.visible;
				titleImage.visible = !titleImage.visible;
			}
		}
		
		private function onAgainTouched(e:TouchEvent):void
		{
			var t : Touch = e.getTouch(this,TouchPhase.ENDED);
			if(t) againTriggered = true;				
		}
		
		public function updateScores(current:Number, high:Number) : void
		{
			currentScore.setScore(current);
			highScore.setScore(high);
		}
	}
}