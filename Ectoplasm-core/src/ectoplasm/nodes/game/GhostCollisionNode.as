package ectoplasm.nodes.game
{
	import ash.core.Node;
	
	import ectoplasm.components.game.Collideable;
	import ectoplasm.components.game.Display;
	import ectoplasm.components.game.Ghost;
	import ectoplasm.components.game.Position;
	
	public class GhostCollisionNode extends Node
	{
		public var ghost : Ghost;
		public var collideable : Collideable;
		public var position : Position;
		public var display : Display;
	}
}