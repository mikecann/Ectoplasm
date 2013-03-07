package ectoplasm.systems.game
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	
	import ectoplasm.common.GameConfig;
	import ectoplasm.nodes.game.CameraNode;
	import ectoplasm.nodes.game.GhostMovementNode;
	
	public class GhostFollowingCameraSystem extends System
	{		
		[Inject] public var config : GameConfig;
		
		private var ghosts : NodeList;
		private var cameras : NodeList;
		
		override public function addToEngine( engine : Engine ) : void
		{
			ghosts = engine.getNodeList(GhostMovementNode);
			cameras = engine.getNodeList(CameraNode);
		}
		
		override public function update( time : Number ) : void
		{
			if(ghosts.head && cameras.head)
			{
				var ghost : GhostMovementNode = GhostMovementNode(ghosts.head);
				var cam : CameraNode = CameraNode(cameras.head);
				
				//trace(ghost.position.position.x,cam.position.position.x);
				
				cam.position.position.x = ghost.position.position.x - config.cameraTrailingGhostDistance;
			}
		}
		
	}
}