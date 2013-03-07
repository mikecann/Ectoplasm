package ectoplasm.nodes.game
{
	import ash.core.Node;
	
	import ectoplasm.components.game.ImageDisplay;
	import ectoplasm.components.game.Position;
	
	public class ImageRenderNode extends Node
	{
		public var position : Position;
		public var display : ImageDisplay;
	}
}