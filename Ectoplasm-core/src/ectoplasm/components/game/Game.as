package ectoplasm.components.game
{
	import ash.fsm.EntityStateMachine;
	
	import starling.filters.BlurFilter;

	public class Game
	{		
		public var states : EntityStateMachine;
		public var score : int;
		
		public function Game(states:EntityStateMachine)
		{
			this.states = states;		
		}	
	}
}
