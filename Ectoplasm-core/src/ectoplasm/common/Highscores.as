package ectoplasm.common
{
	import flash.net.SharedObject;

	public class Highscores
	{		
		public var highscore : int;
		private var so : SharedObject;
		
		public function Highscores()
		{
			so = SharedObject.getLocal("ecoplasm-scores");
			load();
		}
		
		public function load() : void
		{
			if(so.data) highscore = so.data.score;
		}
		
		public function save() : void
		{
			so.data.score = highscore;
			so.flush();
		}
	}
}