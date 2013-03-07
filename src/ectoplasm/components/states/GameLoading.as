package ectoplasm.components.states
{
	import ectoplasm.common.GameLoadingView;

	public class GameLoading
	{
		public var loadingProgress:Number;
		public var step : int;
		public var view:GameLoadingView;
		
		public function GameLoading(view:GameLoadingView)
		{
			this.view = view;
			loadingProgress = 0;
			step = 0;
		}
	}
}