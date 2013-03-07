package ectoplasm.systems.states
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.tools.ListIteratingSystem;
	
	import ectoplasm.common.EntityCreator;
	import ectoplasm.common.GameConfig;
	import ectoplasm.common.GameStates;
	import ectoplasm.nodes.game.BackgroundNode;
	import ectoplasm.nodes.game.CameraNode;
	import ectoplasm.nodes.game.GameNode;
	import ectoplasm.nodes.game.ObstacleNode;
	import ectoplasm.nodes.game.ParticleNode;
	import ectoplasm.nodes.states.PlayingGameNode;
	import ectoplasm.nodes.states.PostGameNode;
	import ectoplasm.views.PostGameView;
	
	import starling.display.Sprite;
	
	public class PostGameStateSystem extends ListIteratingSystem
	{
		[Inject] public var engine : Engine;
		[Inject] public var creator : EntityCreator;
		[Inject] public var config : GameConfig;

		private var container:Sprite;
		
		public function PostGameStateSystem(container:Sprite)
		{
			this.container = container;
			super(PostGameNode,onUpdate,onNodeAdded, onNodeRemoved);
		}
		
		private function  onNodeAdded(node:PostGameNode) : void
		{
			container.addChild(node.state.view);
		}
		
		private function  onNodeRemoved(node:PostGameNode) : void
		{
			container.removeChild(node.state.view);
		}
		
		private function onUpdate(node:PostGameNode, time:Number) : void
		{
			// Grab some nodes we need
			var game : GameNode = engine.getNodeList(GameNode).head;
			var cam : CameraNode = engine.getNodeList(CameraNode).head;		
			
			// Scroll the background to make things look pretty
			cam.position.position.x += time * 30;
			
			// Update the view
			node.state.view.updateScore(game.game.score);
			
			// Tap to start
			if(node.state.view.againTriggered)
			{
				creator.destroyAll(ObstacleNode);
				creator.destroyAll(ParticleNode);
				
				// Lazy
				creator.destroyAll(BackgroundNode);
				creator.createBackground();
				
				// When we create the ghost it isnt given the movement component
				// so it cant be controlled by the player
				creator.createGhost(0,config.halfHeight/2);
				
				cam.position.position.x = -config.cameraTrailingGhostDistance;
				node.state.view.againTriggered = false;
				game.game.states.changeState(GameStates.COUNTDOWN);
			}
		}
	}
}