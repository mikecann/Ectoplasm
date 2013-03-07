package ectoplasm.components.states
{
	import ectoplasm.views.CountdownGameStartView;

	public class CountdownGameStartState
	{
		public var timeRemaining:Number;
		public var view:CountdownGameStartView;
		
		public function CountdownGameStartState(view:CountdownGameStartView, maxTime:Number=4)
		{
			this.view = view;
			this.timeRemaining = maxTime;
		}
	}
}