package ectoplasm.utils.rendering
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class RasterDebugTextUtil
	{		
		// Protected
		protected static var _tf : TextField;
		protected static var _m : Matrix;
		protected static var _format : TextFormat;
		
		public static function writeText(target:BitmapData, x:int, y:int, txt:String, colour:int=0xffffff, bgColor:uint=0) : void
		{
			if(!_tf){ makeTextField(); }
			_tf.defaultTextFormat = new TextFormat("_sans",9,colour);
			_tf.backgroundColor = bgColor;
			_tf.text = txt;	
			_tf.background = bgColor!=0;
			_m.tx = x;
			_m.ty = y;
			target.draw(_tf,_m);
		}
		
		protected static function makeTextField() : void
		{
			_m = new Matrix();	
			_tf = new TextField();			
			_tf.autoSize = TextFieldAutoSize.LEFT;
		}
	}
}