package ectoplasm.utils.rendering
{
	import com.playdemic.core.utils.geom.Pt;
	import com.playdemic.core.utils.geom.transformations.IAxonometricTransformation;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;

	public class BlittingUtils
	{
		// Performance shazz
		protected static const ORIGIN : Point = new Point();
		protected static var __r : Rectangle = new Rectangle();
		
		public static function cloneBMD(inpBMD:BitmapData, paddingX:int=0, paddingY:int=0) : BitmapData
		{
			var outBMD : BitmapData = new BitmapData(inpBMD.width+(paddingX*2),inpBMD.height+(paddingY*2),inpBMD.transparent,0);
			outBMD.copyPixels(inpBMD,inpBMD.rect, new Point(paddingX,paddingY));
			return outBMD;
		}
		
		public static function measureFrame(symbol:Sprite, scaleX:Number, scaleY:Number) : Rectangle
		{
			if(!symbol) return new Rectangle();
			var r : Rectangle = symbol.getBounds(symbol);
			r.width = 2+r.width*scaleX;
			r.height = 2+r.height*scaleY;
			return r;
		}

		public static function renderFrame(symbol:Sprite, scaleX:Number, scaleY:Number, transparrent:Boolean, bgColour:uint, offsetOut:Pt, frameBMD:BitmapData=null, frameBounds:Rectangle=null) : BitmapData 
		{			
			// Work out the bounds of this mc
			var r : Rectangle = frameBounds?frameBounds:symbol.getBounds(symbol);
			
			r.x = int(r.x);
			r.y = int(r.y);		
				
			// Make a matrix for the draw
			var m : Matrix = new Matrix();
			m.scale(scaleX, scaleY);
			m.translate( Math.round(1 - r.x * scaleX), Math.round(1 - r.y * scaleY));				
			
			// Make the BMD and draw
			var idealW : int = 2+r.width*scaleX;
			var idealH : int = 2+ r.height*scaleY;
			var bmd : BitmapData = frameBMD?frameBMD:new BitmapData(idealW, idealH, transparrent, bgColour);					
			//var bmd : BitmapData = new BitmapData(idealW, idealH, transparrent, bgColour);					
			
			m.translate(bmd.width-idealW, bmd.height-idealH);			
			bmd.draw(symbol,m);
			
			// Record the centre point offset for this frame
			offsetOut.x = m.tx;
			offsetOut.y = m.ty;
				
			return bmd;
		}
		
		static public function getRealBounds(clip:DisplayObject, margin:int=0):Rectangle {
			var bounds:Rectangle = clip.getBounds(clip.parent);
			bounds.x = Math.floor(bounds.x);
			bounds.y = Math.floor(bounds.y);
			bounds.height = Math.ceil(bounds.height);
			bounds.width = Math.ceil(bounds.width);
			
			var realBounds:Rectangle = new Rectangle(0, 0, bounds.width + margin * 2, bounds.height + margin * 2);
			
			// Checking filters in case we need to expand the outer bounds
			if (clip.filters.length > 0)
			{
				// filters
				var j:int = 0;
				//var clipFilters:Array = clipChild.filters.concat();
				var clipFilters:Array = clip.filters;
				var clipFiltersLength:int = clipFilters.length;
				var tmpBData:BitmapData;
				var filterRect:Rectangle;
				
				tmpBData = new BitmapData(realBounds.width, realBounds.height, false);
				filterRect = tmpBData.generateFilterRect(tmpBData.rect, clipFilters[j]);
				tmpBData.dispose();
				
				while (++j < clipFiltersLength)
				{
					tmpBData = new BitmapData(filterRect.width, filterRect.height, true, 0);
					filterRect = tmpBData.generateFilterRect(tmpBData.rect, clipFilters[j]);
					realBounds = realBounds.union(filterRect);
					tmpBData.dispose();
				}
			}
			
			realBounds.offset(bounds.x, bounds.y);
			realBounds.width = Math.max(realBounds.width, 1);
			realBounds.height = Math.max(realBounds.height, 1);
			
			tmpBData = null;
			return realBounds;
		}
		
		public static function applyFilters(filters : Array, bmd:BitmapData, applyArea:Rectangle=null) : void
		{
			// Checky checky
			if(!filters || !bmd){ return; }
			
			// Work out what area to apply to
			__r = applyArea?applyArea:bmd.rect;
			
			// Loop through each filter then apply it
			for each(var filter : BitmapFilter in filters)
			{
				bmd.applyFilter(bmd,__r,ORIGIN,filter);
			}
		}
		
		public static function debugCircle(bmd:BitmapData, x:int, y:int, c:int) : void
		{			
			var s : Shape = new Shape();
			s.graphics.beginFill(c);
			s.graphics.drawCircle(0,0,6);
			s.graphics.endFill();
			
			var m : Matrix = new Matrix();
			m.tx = x; m.ty = y;
			bmd.draw(s, m);
		}	
	}
}