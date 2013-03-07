package ectoplasm.nodes.game
{
	import ash.core.Node;
	
	import ectoplasm.components.game.Controllable;
	import ectoplasm.components.game.Display;
	import ectoplasm.components.game.Ghost;
	import ectoplasm.components.game.Position;
	import ectoplasm.components.game.Velocity;
	
	public class GhostMovementNode extends Node
	{
		public var ghost : Ghost;
		public var velocity : Velocity;
		public var position : Position;
		public var display : Display;
		public var controllable : Controllable;
	}
}