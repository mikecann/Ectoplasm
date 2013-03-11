package ectoplasm.components.states
{
	import ectoplasm.views.PlayingGameView;
	

	public class PlayingGameState
	{		
		public var gravity : Number;
		public var lives : int;
		public var startingTimer : Number;
		public var difficulty:Number;
		public var obstacleWaveValue:Number;
		public var view:PlayingGameView;
		
		public function PlayingGameState(view:PlayingGameView)
		{
			this.view = view;
			reset();
		}
		
		public function reset():void
		{			
			lives = 3;
			gravity = 9.8;
			obstacleWaveValue = 0;
			difficulty = 100;
			startingTimer = 2;
		}
	}
}