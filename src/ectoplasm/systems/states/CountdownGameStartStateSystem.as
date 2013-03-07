package ectoplasm.systems.states
{
	import ash.core.Engine;
	import ash.tools.ListIteratingSystem;
	
	import ectoplasm.common.EntityCreator;
	import ectoplasm.common.GameConfig;
	import ectoplasm.common.GameStates;
	import ectoplasm.components.game.Controllable;
	import ectoplasm.nodes.game.GameNode;
	import ectoplasm.nodes.game.GhostNode;
	import ectoplasm.nodes.states.CountdownGameStartStateNode;
	
	import starling.display.Sprite;
	
	public class CountdownGameStartStateSystem extends ListIteratingSystem
	{
		[Inject] public var engine : Engine;
		[Inject] public var config : GameConfig;
		[Inject] public var creator : EntityCreator;

		private var container:Sprite;
		
		public function CountdownGameStartStateSystem(container:Sprite)
		{
			super(CountdownGameStartStateNode, onUpdate,onNodeAdded, onNodeRemoved);
			this.container = container;
		}
		
		private function  onNodeAdded(node:CountdownGameStartStateNode) : void
		{
			container.addChild(node.state.view);
		}
		
		private function  onNodeRemoved(node:CountdownGameStartStateNode) : void
		{
			container.removeChild(node.state.view);
		}
		
		private function onUpdate(node:CountdownGameStartStateNode, time:Number) : void
		{
			var ghost : GhostNode = engine.getNodeList(GhostNode).head;
			var game : GameNode = engine.getNodeList(GameNode).head;
			
			node.state.timeRemaining-=time;
			
			node.state.view.updateTime(node.state.timeRemaining);
			
			if(node.state.timeRemaining<0)
			{
				// Make the player controllable now
				ghost.entity.add(new Controllable());
				game.game.states.changeState(GameStates.PLAYING);
			}
		}
	}
}