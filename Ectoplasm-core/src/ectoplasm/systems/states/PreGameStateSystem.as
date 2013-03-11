package ectoplasm.systems.states
{
	import ash.core.Engine;
	import ash.tools.ListIteratingSystem;
	
	import ectoplasm.common.EntityCreator;
	import ectoplasm.common.GameConfig;
	import ectoplasm.common.GameStates;
	import ectoplasm.components.game.Microphone;
	import ectoplasm.nodes.game.BackgroundNode;
	import ectoplasm.nodes.game.CameraNode;
	import ectoplasm.nodes.game.GameNode;
	import ectoplasm.nodes.game.ObstacleNode;
	import ectoplasm.nodes.states.PreGameNode;
	
	import starling.display.Sprite;
	
	public class PreGameStateSystem extends ListIteratingSystem
	{
		[Inject] public var engine : Engine;
		[Inject] public var config : GameConfig;
		[Inject] public var creator : EntityCreator;

		private var container:Sprite;
		
		public function PreGameStateSystem(container:Sprite)
		{
			super(PreGameNode,onUpdate,onNodeAdded, onNodeRemoved);
			this.container = container;
		}	
		
		private function  onNodeAdded(node:PreGameNode) : void
		{
			container.addChild(node.state.view);
		}
		
		private function  onNodeRemoved(node:PreGameNode) : void
		{
			container.removeChild(node.state.view);
		}
		
		private function onUpdate(node:PreGameNode, time:Number) : void
		{		
			// Grab some nodes we need
			var game : GameNode = engine.getNodeList(GameNode).head;
			var cam : CameraNode = engine.getNodeList(CameraNode).head;	
			
			config.renderLayerBlurAmount = 2;
					
			// Scroll the background to make things look pretty
			cam.position.position.x += time * 30;
			
			// Tap to start
			if(node.state.view.startGameTriggered)
			{
				// Reset these things so we start a new game
				creator.destroyAll(ObstacleNode);
				creator.destroyAll(BackgroundNode);
				creator.createBackground();
				
				// When we create the ghost it isnt given the movement component
				// so it cant be controlled by the player
				creator.createGhost(0,config.halfHeight-100);				
				cam.position.position.x = -config.cameraTrailingGhostDistance;				
				
				node.state.view.startGameTriggered = false;
				config.renderLayerBlurAmount = 0;
				
				game.game.states.changeState(GameStates.COUNTDOWN);
			}
		}
	}
}