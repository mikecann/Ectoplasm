package ectoplasm.systems.game
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	
	import ectoplasm.common.GameConfig;
	import ectoplasm.nodes.game.BackgroundNode;
	import ectoplasm.nodes.game.CameraNode;
	import ectoplasm.utils.math.Rand;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class BackgroundScrollingSystem extends System
	{
		[Inject] public var config : GameConfig;
		[Inject] public var assetsMan : AssetManager;
		
		private var backgrounds : NodeList;
		private var cameras : NodeList;
		
		private static const ALT_BGS : Array = ["bg_tile_blood","bg_tile_ghost_family","bg_tile_ghost_portrait1","bg_tile_ghost_portrait2"];
		private var timeSinceLastAltBG : Number=0;
		
		override public function addToEngine( engine : Engine ) : void
		{
			backgrounds = engine.getNodeList( BackgroundNode ) ;
			cameras = engine.getNodeList( CameraNode ) ;
		}
		
		override public function update( time : Number ) : void
		{
			var bg : BackgroundNode = backgrounds.head;
			var cam : CameraNode = cameras.head;
			if(bg && cam)
			{							
				var x : int = -config.width;
				if(bg.display.container.numChildren!=0)
				{
					var last : DisplayObject = bg.display.container.getChildAt(bg.display.container.numChildren-1);
					x = last.x + last.width-1;
				}
				
				timeSinceLastAltBG+=time;
				
				var tex : Texture = assetsMan.getTexture("bg_tile_plain");
				while(x-cam.position.position.x*bg.position.position.z<config.width)
				{
					var nextIsAlt : Boolean = Math.random()>1-(timeSinceLastAltBG/10);
					if(nextIsAlt) timeSinceLastAltBG = 0;					
					tex = assetsMan.getTexture(nextIsAlt?ALT_BGS[Rand.integer(0,ALT_BGS.length)]:"bg_tile_plain");
					var img : Image = new Image(tex);
					img.x = x;
					bg.display.container.addChild(img);
					x += tex.width-1;			
				}
				
				for (var i:int=0; i<bg.display.container.numChildren; i++)
				{
					var child : DisplayObject = bg.display.container.getChildAt(i);
					if(child.x-cam.position.position.x*bg.position.position.z+child.width<0)
					{
						bg.display.container.removeChildAt(i);
						i--;
					}
				}
				
				
			}
		}	
	}
}