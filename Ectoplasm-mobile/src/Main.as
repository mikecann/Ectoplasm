package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import ectoplasm.Ectoplasm;
	
	import starling.core.Starling;
	
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#ffffff")]
	public class Main extends Sprite
	{
		public function Main()
		{
			addEventListener( Event.ENTER_FRAME, init );
		}
		
		private function init( event : Event ) : void
		{
			removeEventListener( Event.ENTER_FRAME, init );
			if( stage.stageWidth && stage.stageHeight )
			{				
				Starling.multitouchEnabled = true;
				Starling.handleLostContext = true;				
				
				var isPad:Boolean = (stage.fullScreenWidth == 1024 || stage.fullScreenWidth == 2048);
				
				var st : Starling = new Starling( Ectoplasm, stage, new Rectangle(0,0,stage.fullScreenWidth,stage.fullScreenHeight) );
				st.antiAliasing = 0;
				st.stage.stageWidth  = isPad?1024:960;
				st.stage.stageHeight = isPad?768:640;
				//st.simulateMultitouch = true;
				//st.showStats = true;
				st.start();
			}
		}
	}
}