package ectoplasm.components.game
{
	import ash.fsm.EntityStateMachine;
	
	import starling.filters.FragmentFilter;

	public class Game
	{		
		public var states : EntityStateMachine;
		public var score : int;
		public var renderFilter : FragmentFilter;
		
		public function Game(states:EntityStateMachine)
		{
			this.states = states;		
		}	
	}
}
