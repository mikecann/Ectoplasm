package ectoplasm.components.states
{
	import ectoplasm.views.CountdownGameStartView;

	public class CountdownGameStartState
	{
		public var timeRemaining:Number;
		public var view:CountdownGameStartView;
		public var maxTime:Number;
		
		public function CountdownGameStartState(view:CountdownGameStartView, maxTime:Number=4)
		{
			this.maxTime = maxTime;
			this.view = view;
			this.timeRemaining = maxTime;
		}
		
		public function reset():void
		{
			timeRemaining = maxTime;
		}
	}
}