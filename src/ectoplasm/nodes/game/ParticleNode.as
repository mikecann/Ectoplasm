package ectoplasm.nodes.game
{
	import ash.core.Node;
	
	import ectoplasm.components.game.Display;
	import ectoplasm.components.game.Particle;
	import ectoplasm.components.game.Position;
	
	public class ParticleNode extends Node
	{
		public var particle : Particle;
		public var position : Position;
		public var display : Display;;
	}
}