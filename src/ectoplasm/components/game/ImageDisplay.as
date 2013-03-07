package ectoplasm.components.game
{
	import starling.display.Image;

	public class ImageDisplay
	{
		public var image : Image;
		
		public function ImageDisplay(image:Image, pivotX:Number, pivotY:Number)
		{
			this.image = image;
			image.pivotX = pivotX;
			image.pivotY = pivotY;
		}
	}
}