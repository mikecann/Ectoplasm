package ectoplasm.utils.filters
{
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;

	public class FilterUtils
	{
		public static function filterToString(filter:BitmapFilter) : String
		{	
			if(filter is ColorMatrixFilter)
			{
				return "[ColorMatrixFilter Values:"+(filter as ColorMatrixFilter).matrix.join(",")+"]";
			}
			return filter + "";
		}
	}
}