package ectoplasm.common
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;

	public class SystemDisplayLayers
	{
		public var render : Sprite;
		public var hud : Sprite;
		public var debug : Sprite;
		
		public function SystemDisplayLayers(container:DisplayObjectContainer)
		{
			container.addChild(render = new Sprite());
			container.addChild(hud = new Sprite());
			container.addChild(debug = new Sprite());
		}
	}
}