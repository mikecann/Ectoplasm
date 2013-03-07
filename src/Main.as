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
		public static var forcedFullScreenWidth : Number = -1;
		public static var forcedFullscreenHeight : Number = -1;
		
		private var st : Starling;
		
		public function Main()
		{
			addEventListener( Event.ENTER_FRAME, init );
		}
		
		private function init( event : Event ) : void
		{
			if( stage.stageWidth && stage.stageHeight )
			{
				removeEventListener( Event.ENTER_FRAME, init );
				Starling.multitouchEnabled = true;
				Starling.handleLostContext = true;				
				
				var fsw : Number = forcedFullScreenWidth==-1?stage.fullScreenWidth:forcedFullScreenWidth;
				var fsh : Number = forcedFullscreenHeight==-1?stage.fullScreenHeight:forcedFullscreenHeight;
				
				var isPad:Boolean = (fsw == 1024 || fsw == 2048);
				var r : Number = fsw*fsh;
				
				st = new Starling( Ectoplasm, stage, new Rectangle(0,0,fsw,fsh) );
				st.antiAliasing = 0;
				st.stage.stageWidth  = isPad?1024:960;
				st.stage.stageHeight = isPad?768:640;
				st.simulateMultitouch = true;
				st.showStats = true;
				st.start();
			}
		}
	}
}