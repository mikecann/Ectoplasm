package ectoplasm.utils.math
{
	public class NumberUtils
	{
		// Protecteds
		//protected static var _formatter : CurrencyFormatter;
		
		public static function clamp(min:Number, max:Number, val:Number) :Number
		{
			if (val < min) { val = min; }
			if (val > max) { val = max; }
			return val;
		}
		
		public static function wrap(num:Number,min:Number,max:Number) :Number
		{			
			var diff : Number = num;			
			
			if (min - max == 0) 
			{
				diff = min; 
			}
			else if (num < min)
			{
				diff = min - num;
				diff -= (int(diff / (max - min)) * (max - min));
				diff = max - diff;
			}
			else if (num >= max)
			{
				diff = num - max;
				diff -= (int(diff / (max - min)) * (max - min));
				diff = min + diff;
			}
			
			return diff;
		}	
		
		/*
		public static function currencyify(num:Number) : String
		{
			if(!_formatter) { _formatter = new CurrencyFormatter(); }
			_formatter.decimalSeparatorFrom = ".";
			_formatter.decimalSeparatorTo = ".";
			_formatter.currencySymbol = "";
			_formatter.useThousandsSeparator = true;
			_formatter.precision = 0;
			return _formatter.format(num);
		}
		*/
	
		public static function ensureLeadingZeros(number:int, numDigits:int) : String
		{
			var s : String = number+"";
			var l : int = s.length;
			var outS : String = s;
			for(var i:int=0; i<numDigits-l; i++){ outS = "0"+outS; }
			return outS;
		}
		
		
		/**
		 * http://as3lib.googlecode.com/svn/trunk/src/org/as3lib/math/getNumberAsHexString.as
		 * 
		 * Converts a uint into a string in the format â€œ0x123456789ABCDEFâ€.
		 * This function is quite useful for displaying hex colors as text.
		 *
		 * @author Mims H. Wright (modified by Pimm Hogeling)
		 *
		 * @example 
		 * <listing version="3.0">
		 * getNumberAsHexString(255); // 0xFF
		 * getNumberAsHexString(0xABCDEF); // 0xABCDEF
		 * getNumberAsHexString(0x00FFCC); // 0xFFCC
		 * getNumberAsHexString(0x00FFCC, 6); // 0x00FFCC
		 * getNumberAsHexString(0x00FFCC, 6, false); // 00FFCC
		 * </listing>
		 *
		 *
		 * @param number The number to convert to hex. Note, numbers larger than 0xFFFFFFFF may produce unexpected results.
		 * @param minimumLength The smallest number of hexits to include in the output.
		 * 					   Missing places will be filled in with 0â€™s.
		 * 					   e.g. getNumberAsHexString(0xFF33, 6); // results in "0x00FF33"
		 * @param showHexDenotation If true, will append "0x" to the front of the string.
		 * @return String representation of the number as a string starting with "0x"
		 */
		public static function getNumberAsHexString(number:uint, minimumLength:uint = 1, showHexDenotation:Boolean = true):String {
			// The string that will be output at the end of the function.
			var string:String = number.toString(16).toUpperCase();
			
			// While the minimumLength argument is higher than the length of the string, add a leading zero.
			while (minimumLength > string.length) {
				string = "0" + string;
			}
			
			// Return the result with a "0x" in front of the result.
			if (showHexDenotation) { string = "0x" + string; }
			
			return string;
		}
		
		public static function rotate1DArray(input:Vector.<int>, rectW:int, rectH:int, rotation:int) : Vector.<int>
		{
			var v : Vector.<int> = input
			var w : int = rectW;
			var h : int = rectH;
			var yi:int, xi:int, i:int;
			
			if(rotation==90)
			{
				v = new Vector.<int>(input.length);
				i = 0;
				for (xi=0; xi<w; xi++)
				{
					for (yi=h-1; yi>=0; yi--)
					{
						v[i++] = input[yi*w+xi];	
					}
				}
			}
			else if(rotation==180)
			{
				v = new Vector.<int>(input.length);
				i = 0;
				for (yi=h-1; yi>=0; yi--)
				{
					for (xi=w-1; xi>=0; xi--)
					{						
						v[i++] = input[yi*w+xi];							
					}
				}
			}
			else if(rotation==270)
			{
				v = new Vector.<int>(input.length);
				i = 0;
				for (xi=w-1; xi>=0; xi--)
				{
					for (yi=0; yi<h; yi++)
					{
						v[i++] = input[yi*w+xi];	
					}
				}
			}
			
			return v;
		}
		
		/**
		 * Truncate efficiently without casting to string
		 * http://www.actionscript-flash-guru.com/blog/32-truncating-a-number-setting-the-precision-of-a-float-actionscript-3-as3
		 *  - this will fail gloriously after int.MAX_VALUE - JakeR
		 */
		public static function truncate(val:Number, decimalPlaces:uint):Number{
			var multiplier:uint = Math.pow(10, decimalPlaces);
			var truncatedVal:Number = val*multiplier;
			return int(truncatedVal)/multiplier;
		}
	}
}