package ectoplasm.views
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class GhostView extends MovieClip
	{
		public function GhostView(assets:AssetManager)
		{			
			var t : Vector.<Texture> = assets.getTextures("ghost_small");
			super(t, 5);
			Starling.juggler.add(this);
		}
		
		public function getCurrentTextureName() : String
		{
			return "ghost_small_"+(currentFrame+1);	
		}
	}
}