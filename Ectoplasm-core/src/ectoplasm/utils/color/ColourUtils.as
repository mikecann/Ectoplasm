package ectoplasm.utils.color
{
	import flash.geom.ColorTransform;

	public class ColourUtils
	{
		public static function interp(c1:uint, c2:uint, interp:Number, min:Number, max:Number):uint 
		{
			interp -= min;
			interp /= max - min;
			var c3:uint = ((c1 >> 24 & 0xFF) * (1-interp) + (c2 >> 24 & 0xFF) * interp) << 24;
			c3 |= ((c1 >> 16 & 0xFF) * (1-interp) + (c2 >> 16 & 0xFF) * interp) << 16;
			c3 |= ((c1 >> 8 & 0xFF) * (1-interp) + (c2 >> 8 & 0xFF) * interp) << 8;
			c3 |= ((c1 & 0xFF) * (1-interp) + (c2 & 0xFF) * interp);
			return c3;
		}
		
		public static function interp2(f:uint, t:uint, interp:Number):uint 
		{
			var fa:uint, fr:uint, fg:uint, fb:uint;
			var ta:uint, tr:uint, tg:uint, tb:uint;
			var da:uint, dr:uint, dg:uint, db:uint;
			
			fa = (f >> 24) & 0xFF;
			fr = (f >> 16) & 0xFF;
			fg = (f >> 8) & 0xFF
			fb = (f & 0xFF)*interp;
				
			ta = (f >> 24) & 0xFF
			tr = (f >> 16) & 0xFF;
			tg = (f >> 8) & 0xFF
			tb = (f & 0xFF)*interp;
			
			da = ta-fa;
			dr = tr-fr;
			dg = tg-fg;
			db = tb-fb;			
				
			da = fa+da*interp;
			dr = fr+dr*interp;
			dg = fg+dg*interp;
			db = fb+db*interp;
			
			return (da<<24 | dr<<16 | dg<<8 | db)
		}	

		public static function rgb2hex(r:Number, g:Number, b:Number):Number 
		{
			return(r<<16 | g<<8 | b);
		}	

		public static function hex2rgb (hex:Number):Object
		{
			var red : Number = hex>>16;
			var greenBlue : Number = hex-(red<<16)
			var green : Number = greenBlue>>8;
			var blue : Number = greenBlue - (green << 8);
			return({r:red, g:green, b:blue});
		}
	}
}