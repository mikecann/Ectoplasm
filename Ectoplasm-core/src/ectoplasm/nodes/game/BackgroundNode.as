package ectoplasm.nodes.game
{
	import ash.core.Node;
	
	import ectoplasm.components.game.Background;
	import ectoplasm.components.game.Display;
	import ectoplasm.components.game.Position;
	
	public class BackgroundNode extends Node
	{
		public var background : Background;
		public var display : Display;
		public var position : Position;
	}
}