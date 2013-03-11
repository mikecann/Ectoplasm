package ectoplasm.utils.starling
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class AtlasToBitmapsHelper
	{
		public static function getBitmaps(atlas:TextureAtlas, spriteSheet:BitmapData, addTo:Dictionary=null) : Dictionary
		{
			var d : Dictionary = addTo?addTo:new Dictionary();
			
			var names : Vector.<String> = atlas.getNames();			
			for each (var s : String in names)
			{
		
				var tex : Texture = atlas.getTexture(s);
				var region : Rectangle = atlas.getRegion(s);
				var frame : Rectangle = tex.frame;
				
				var bmd : BitmapData = new BitmapData(frame.width,frame.height,true,0);
				bmd.copyPixels(spriteSheet,region,new Point(-frame.x,-frame.y));
				
				
		
				
				d[s] = bmd;
				/*
				var b : Bitmap = new Bitmap(bmd);
				b.x = 500 * Math.random();
				b.y = 500 * Math.random();				
				Starling.current.nativeOverlay.addChild(b);
				trace(s,frame,tex.width,tex.height);
								*/
			}
			
			return d;
		}
	}
}