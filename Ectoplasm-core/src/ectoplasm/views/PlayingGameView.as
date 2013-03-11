package ectoplasm.views
{
	import ectoplasm.common.GameConfig;
	
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	public class PlayingGameView extends Sprite
	{
		private var currentScore : ScoreView;
		private var highScore : ScoreView;
		private var assets : AssetManager;		
		
		public function PlayingGameView(assets:AssetManager, config:GameConfig)
		{
			this.assets = assets;
			
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
		}
		
		public function updateScores(current:Number, high:Number) : void
		{
			currentScore.setScore(current);
			highScore.setScore(high);
		}		
	}
}