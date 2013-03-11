package ectoplasm.views
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class GhostView extends MovieClip
	{		
		public static const SMALL : String = "small";
		public static const MEDIUM : String = "medium";
		public static const LARGE : String = "large";
		
		private var size : String;
		public var ghostHeight : int;		
		
		public function GhostView(assets:AssetManager, size:String)
		{			
			this.size = size;
			var t : Vector.<Texture> = assets.getTextures("ghost_"+size);
			super(t, 5);
			pivotX = t[0].frame.width/2;
			pivotY = t[0].frame.height/2;
			ghostHeight = t[0].height;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			Starling.juggler.add(this);
		}
		
		private function onRemovedFromStage(e:Event):void
		{
			Starling.juggler.remove(this);
		}
		
		public function getCurrentTextureName() : String
		{
			return "ghost_"+size+"_"+(currentFrame+1);	
		}
	}
}