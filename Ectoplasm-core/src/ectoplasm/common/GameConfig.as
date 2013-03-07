package ectoplasm.common
{
	public class GameConfig
	{
		public var width : Number;
		public var halfWidth : Number;
		public var height : Number;
		public var halfHeight : Number;
		
		public var cameraTrailingGhostDistance : Number;
		public var renderLayerBlurAmount : Number;
		
		public function GameConfig(w:Number, h:Number)
		{
			width = w;
			halfWidth = w/2;
			height = h;
			halfHeight = h/2;
			
			renderLayerBlurAmount = 0;
			
			cameraTrailingGhostDistance = halfWidth * 0.5
		}
	}
}
