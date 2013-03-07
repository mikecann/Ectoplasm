package ectoplasm.systems.game
{
	import ash.core.Engine;
	import ash.tools.ListIteratingSystem;
	
	import ectoplasm.nodes.states.PlayingGameNode;
	
	import starling.display.Stage;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class TouchBasedControlsSystem extends ListIteratingSystem
	{
		[Inject] public var stage : Stage;
		
		private var touchId : int;
		
		public function TouchBasedControlsSystem()
		{
			super(PlayingGameNode, onUpdate);
		}
		
		override public function addToEngine( engine : Engine ) : void
		{
			super.addToEngine(engine);
			touchId = -1;
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var began : Touch = e.getTouch(stage, TouchPhase.BEGAN);
			var ended : Touch = e.getTouch(stage, TouchPhase.ENDED);
			
			if(began && touchId==-1) touchId = began.id;
			if(ended && touchId==ended.id) touchId = -1;
		}
		
		private function onUpdate(node:PlayingGameNode, time:Number):void
		{
			//if(touchId!=-1) GameNode(games.head).game.inputForce = 1;
			//node.state.inputForce = 1;
		}
	}
}