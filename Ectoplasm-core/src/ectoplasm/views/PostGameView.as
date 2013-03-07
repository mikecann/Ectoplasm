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
		private var scoreTF :TextField;
			
		public function PostGameView(assets : AssetManager, config:GameConfig)
		{
			againButton = new Button(assets.getTexture("again_up"));
			againButton.x = config.halfWidth-againButton.width/2;
			againButton.y = 50+config.halfHeight-againButton.height/2;
			addChild(againButton);
			
			scoreTF = new TextField(600,200,"000000124","rabiohead", 130, 0xffffff);
			scoreTF.hAlign = HAlign.LEFT;
			scoreTF.vAlign = VAlign.TOP;
			scoreTF.filter = BlurFilter.createDropShadow();
			scoreTF.x = config.width-scoreTF.width+180;
			scoreTF.y = -10;
			addChild(scoreTF);
			
			titleImage = new Image(assets.getTexture("ectoplasm_stamp"));
			titleImage.filter = BlurFilter.createDropShadow();
			titleImage.x = 20+ config.halfWidth-titleImage.width/2;
			titleImage.y = 200;
			addChild(titleImage);
			
			addEventListener(TouchEvent.TOUCH,onAgainTouched);	
		}
		
		private function onAgainTouched(e:TouchEvent):void
		{
			var t : Touch = e.getTouch(this,TouchPhase.ENDED);
			if(t) againTriggered = true;				
		}
		
		public function updateScore(score:Number) : void
		{
			scoreTF.text = StringUtils.padLeft(score+"","0",8);
		}
	}
}