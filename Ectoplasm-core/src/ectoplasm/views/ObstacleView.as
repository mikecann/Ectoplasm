package ectoplasm.views
{
	import ectoplasm.data.ObstacleTypeVO;
	
	import starling.display.Image;
	import starling.utils.AssetManager;
	
	public class ObstacleView extends Image
	{
		public function ObstacleView(assets:AssetManager, type:ObstacleTypeVO)
		{
			super(assets.getTexture(type.name));
		}
	}
}