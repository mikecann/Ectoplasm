package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import ectoplasm.Ectoplasm;
	
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.core.Starling;
	
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#ffffff")]
	public class Main extends Sprite
	{
		public function Main()
		{
			if(stage) init();
			else addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( event : Event=null ) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//MetalWorksMobileTheme.globalScale = 1.3;
			
			//Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;						
			
			var st : Starling = new Starling(Ectoplasm, stage, new Rectangle(0,0,stage.stageWidth,stage.stageHeight) );
			st.antiAliasing = 0;
			//st.simulateMultitouch = true;
			//st.showStats = true;
			st.start();
		}
	}
}