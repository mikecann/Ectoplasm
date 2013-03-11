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
		private var currentScore : ScoreView;
		private var highScore : ScoreView;
		private var countDownTimer :TextField;
		
		public function CountdownGameStartView(assets:AssetManager, config:GameConfig)
		{
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
			
			countDownTimer = new TextField(500,500,"0","sarcasticrobot", 300, 0xffffff);
			countDownTimer.hAlign = HAlign.CENTER;
			countDownTimer.vAlign = VAlign.CENTER;
			countDownTimer.filter = BlurFilter.createDropShadow();
			countDownTimer.x = config.halfWidth-countDownTimer.width/2;
			countDownTimer.y = config.halfHeight-countDownTimer.height/2;
			addChild(countDownTimer);
		}
		
		public function updateScores(current:Number, high:Number) : void
		{
			currentScore.setScore(current);
			highScore.setScore(high);
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