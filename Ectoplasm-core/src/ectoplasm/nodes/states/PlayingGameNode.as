package ectoplasm.nodes.states
{
	import ash.core.Node;
	
	import ectoplasm.components.game.Display;
	import ectoplasm.components.game.Game;
	import ectoplasm.components.states.PlayingGameState;
	
	public class PlayingGameNode extends Node
	{
		public var game : Game;
		public var state : PlayingGameState;
	}
}