package ectoplasm.nodes.game
{
	import ash.core.Node;
	
	import ectoplasm.components.game.Display;
	import ectoplasm.components.game.Obstacle;
	import ectoplasm.components.game.Position;
	
	public class ObstacleNode extends Node
	{
		public var obstacle : Obstacle;
		public var position : Position;
		public var display : Display;
	}
}