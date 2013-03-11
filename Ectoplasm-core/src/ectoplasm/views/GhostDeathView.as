package ectoplasm.views
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class GhostDeathView extends MovieClip
	{		
		public function GhostDeathView(assets:AssetManager,deathTime:Number)
		{			
			var t : Vector.<Texture> = assets.getTextures("ghost_dead");
			super(t, 4);
			pivotX = t[0].frame.width/2;
			pivotY = t[0].frame.height/2;
			
			Starling.juggler.tween(this,deathTime,{alpha:0, currentFrame:numFrames-1});
		}
	}
}