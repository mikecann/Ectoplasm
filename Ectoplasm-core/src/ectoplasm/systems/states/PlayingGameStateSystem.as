package ectoplasm.systems.states
{
	import ash.core.Engine;
	import ash.tools.ListIteratingSystem;
	
	import ectoplasm.common.EntityCreator;
	import ectoplasm.common.GameConfig;
	import ectoplasm.common.GameStates;
	import ectoplasm.nodes.game.GameNode;
	import ectoplasm.nodes.game.GhostNode;
	import ectoplasm.nodes.states.PlayingGameNode;
	
	import org.swiftsuspenders.Injector;
	
	import starling.display.Sprite;
	
	public class PlayingGameStateSystem extends ListIteratingSystem
	{
		[Inject] public var creator : EntityCreator;
		[Inject] public var injector : Injector;
		[Inject] public var config : GameConfig;
		[Inject] public var engine : Engine;
		
		private var container : Sprite;
				
		public function PlayingGameStateSystem(container:Sprite)
		{
			this.container = container;
			super(PlayingGameNode,onUpdate,onNodeAdded, onNodeRemoved);
		}		
		
		private function  onNodeAdded(node:PlayingGameNode) : void
		{
			node.state.reset();
			container.addChild(node.state.view);
		}
		
		private function  onNodeRemoved(node:PlayingGameNode) : void
		{
			container.removeChild(node.state.view);
		}
		
		private function onUpdate(node:PlayingGameNode, time:Number) : void
		{		
			// Grab some nodes we need			
			var game : GameNode = engine.getNodeList(GameNode).head;
			var ghost : GhostNode = engine.getNodeList(GhostNode).head;
			
			// Difficulty just a function of time				
			node.state.difficulty += time * 10;
			
			// Score is a function of the difficulty
			game.game.score = node.state.difficulty;
			
			// Update the view
			node.state.view.updateScore(game.game.score);
			
			// No more lifes, game over sukka
			if(node.state.lives==0)
			{
				creator.destroyEntity(ghost.entity);
				game.game.states.changeState(GameStates.POST_GAME);	
			}
		}
	}
}