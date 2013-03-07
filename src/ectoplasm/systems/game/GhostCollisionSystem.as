package ectoplasm.systems.game
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	
	import ectoplasm.common.Assets;
	import ectoplasm.components.game.Invulnerable;
	import ectoplasm.nodes.game.CameraNode;
	import ectoplasm.nodes.game.GameNode;
	import ectoplasm.nodes.game.GhostCollisionNode;
	import ectoplasm.nodes.game.GhostNode;
	import ectoplasm.nodes.game.ObstacleNode;
	import ectoplasm.nodes.states.PlayingGameNode;
	import ectoplasm.views.GhostView;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	
	public class GhostCollisionSystem extends System
	{		
		[Inject] public var engine : Engine;
		
		// The ratio between the number of lives remaining and the amount the ghost should grow
		// when it is hit (bigger number equals smaller ghost)
		public static const LIVES_SCALE_FACTOR : Number = 5;
		
		private var obstacles : NodeList;
		
		override public function addToEngine( engine : Engine ) : void
		{
			obstacles = engine.getNodeList( ObstacleNode ) ;
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
				
				// Collision works on pixel-perfect BMD checking, so go grab the ghost (it can scale)
				var ghostBMD : BitmapData = getGhostBMD(ghost,playing);					
				
				var p : Point = new Point();				
				for( var node : ObstacleNode = obstacles.head; node; node = node.next )
				{				
					// Test the ghost against this obstacle, ensuring they are in the correct space coords
					var obstacleBMD : BitmapData = Assets.bmdCache[node.obstacle.type.name];					
					var b : Boolean = ghostBMD.hitTest(ghost.position.position,250,obstacleBMD,node.position.position,250);
					
					// There was a hit!
					if(b)
					{			
						// What happens if we run out of lives is managed in another system
						playing.state.lives--;					
						
						// The ghost becomes invulnerable now for a period of time 
						ghost.entity.add(new Invulnerable(3));
						
						// Temp! Scale up the ghost over a period of time
						var t : Tween = new Tween(ghost.display.container,1,"easeOut");
						t.scaleTo((3-playing.state.lives)/LIVES_SCALE_FACTOR+1);
						Starling.juggler.add(t);						
						
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
		
		// Because we simply scale the ghost up when it collides we need a way of getting a scaled
		// version of the original BMD so we can perform accurace pixel-perfect collision checks
		private function getGhostBMD(ghost:GhostCollisionNode, playing:PlayingGameNode) : BitmapData
		{
			var ghostView : GhostView = ghost.display.container.getChildAt(0) as GhostView;				
			var ghostBMD : BitmapData = Assets.bmdCache[ghostView.getCurrentTextureName()];	
			
			// If we are bigger we need a bigger BMD
			if(playing.state.lives!=3)
			{
				// Grab the current frame that is being displayed on screen
				var id : String = ghostView.getCurrentTextureName()+"_"+playing.state.lives;
				var biggerBMD : BitmapData = Assets.bmdCache[id];
				if(!biggerBMD)
				{
					// Render a correctly scaled version
					var scale : Number = (3-playing.state.lives)/LIVES_SCALE_FACTOR+1;
					biggerBMD = new BitmapData(ghostBMD.width*scale,ghostBMD.height*scale, true, 0);					
					var m : Matrix = new Matrix();
					m.scale(scale,scale);					
					biggerBMD.draw(ghostBMD,m);
					
					// Cache it for next time
					Assets.bmdCache[id] = biggerBMD;					
				}
				ghostBMD = biggerBMD;
			}		
			return ghostBMD;
		}
	}
}