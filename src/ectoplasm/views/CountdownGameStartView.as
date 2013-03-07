package ectoplasm.views
{
	import ectoplasm.common.GameConfig;
	
	import starling.display.Sprite;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class CountdownGameStartView extends Sprite
	{
		private var countDownTimer :TextField;
		
		public function CountdownGameStartView(assets:AssetManager, config:GameConfig)
		{
			countDownTimer = new TextField(500,500,"0","rabiohead", 300, 0xffffff);
			countDownTimer.hAlign = HAlign.CENTER;
			countDownTimer.vAlign = VAlign.CENTER;
			countDownTimer.filter = BlurFilter.createDropShadow();
			countDownTimer.x = config.halfWidth-countDownTimer.width/2;
			countDownTimer.y = config.halfHeight-countDownTimer.height/2;
			addChild(countDownTimer);
		}
		
		public function updateTime(secondsRemaining:int) : void
		{
			if(secondsRemaining>0)
				countDownTimer.text = secondsRemaining+""
			else
				countDownTimer.text = "GO";
		}
	}
}