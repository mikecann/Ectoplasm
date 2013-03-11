package ectoplasm.systems.game
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	
	import ectoplasm.data.Assets;
	import ectoplasm.components.game.Invulnerable;
	import ectoplasm.nodes.game.CameraNode;
	import ectoplasm.nodes.game.GameNode;
	import ectoplasm.nodes.game.GhostCollisionNode;
	import ectoplasm.nodes.game.ObstacleNode;
	import ectoplasm.nodes.states.PlayingGameNode;
	import ectoplasm.views.GhostView;
	
	import starling.core.Starling;
	import starling.utils.AssetManager;
	
	public class GhostCollisionSystem extends System
	{		
		[Inject] public var engine : Engine;
		[Inject] public var assets : AssetManager;
						
		private var obstacles : NodeList;
		
		//private var b1 : Bitmap = new Bitmap();
		
		override public function addToEngine( engine : Engine ) : void
		{
			obstacles = engine.getNodeList( ObstacleNode ) ;
			
			//b1.filters = [new GlowFilter(0xff0000)];
			//Starling.current.nativeOverlay.addChild(b1);
		}				
		
		override public function update( time : Number ) : void
		{
			// First grab the single nodes we need
			var ghost : GhostCollisionNode = engine.getNodeList(GhostCollisionNode).head;
			var game : GameNode = engine.getNodeList(GameNode).head;
			var cam : CameraNode = engine.getNodeList(CameraNode).head;
			var playing : PlayingGameNode = engine.getNodeList(PlayingGameNode).head;
			if(!ghost || !game || !cam || !playing) return;							
				
			// Cant collide if you are invulnrable!
			if(!ghost.entity.has(Invulnerable))
			{							
				// The ghost flashes when invulnerable
				ghost.display.container.alpha = 1;
				
				// Collision works on pixel-perfect BMD checking, so go grab the ghost
				var ghostView : GhostView = ghost.display.container.getChildAt(0) as GhostView;				
				var ghostBMD : BitmapData = Assets.collisionData[ghostView.getCurrentTextureName()];
				var gv : GhostView = ghost.display.container.getChildAt(0) as GhostView;
				var p : Point = new Point(ghost.position.position.x-gv.pivotX,ghost.position.position.y-gv.pivotY);
				
				/*b1.bitmapData = ghostBMD;
				b1.x = p.x-cam.position.position.x;
				b1.y = p.y-cam.position.position.y;*/
				
				for(var node : ObstacleNode = obstacles.head; node; node = node.next )
				{				
					// Test the ghost against this obstacle, ensuring they are in the correct space coords
					var obstacleBMD : BitmapData = Assets.collisionData[node.obstacle.type.name];
					var b : Boolean = ghostBMD.hitTest(p,250,obstacleBMD,node.position.position,250);
					
					// There was a hit!
					if(b)
					{			
						// What happens if we run out of lives is managed in another system
						playing.state.lives--;
						
						// Ghost gets larger as it looses lives
						ghost.display.container.removeChild(ghostView);
						if(playing.state.lives==2) ghost.display.container.addChild(new GhostView(assets,GhostView.MEDIUM));
						else ghost.display.container.addChild(new GhostView(assets,GhostView.LARGE));
						
						// The ghost becomes invulnerable now for a period of time 
						ghost.entity.add(new Invulnerable(3));
						
						// There can only be one collision per frame
						break;
					}
				}
			}
			else // the ghost is invulnerable so no collision checking should occur
			{	
				// Make the ghost flash to indicate that its invilnerable
				var invul : Invulnerable = ghost.entity.get(Invulnerable);
				ghost.display.container.alpha = 0.5+Math.sin(invul.timeRemaining*50)/2;
				invul.timeRemaining -= time;
				
				if(invul.timeRemaining<=0) ghost.entity.remove(Invulnerable);
			}
		}		
	}
}