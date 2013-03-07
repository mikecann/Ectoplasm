package ectoplasm.utils.input
{
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;

	public class KeyboardUtils
	{
		public static const FUNCTION_KEYS : Vector.<uint> = new <uint>[Keyboard.F1,Keyboard.F2,Keyboard.F3,Keyboard.F4,Keyboard.F5,Keyboard.F6,Keyboard.F7,Keyboard.F8,Keyboard.F9,Keyboard.F10,Keyboard.F11,Keyboard.F12];
	
		private static var _keyLookups : Dictionary;	
				
		public static function fromKeycodeToString(code:uint) : String			
		{
			if(!_keyLookups) populateLookups();
			return _keyLookups[code];
		}
		
		private static function populateLookups() : void
		{
			_keyLookups = new Dictionary();
			_keyLookups[Keyboard.F1] = "F1";
			_keyLookups[Keyboard.F2] = "F2";
			_keyLookups[Keyboard.F3] = "F3";
			_keyLookups[Keyboard.F4] = "F4";
			_keyLookups[Keyboard.F5] = "F5";
			_keyLookups[Keyboard.F6] = "F6";
			_keyLookups[Keyboard.F7] = "F7";
			_keyLookups[Keyboard.F8] = "F8";
			_keyLookups[Keyboard.F9] = "F9";
			_keyLookups[Keyboard.F10] = "F10";
			_keyLookups[Keyboard.F11] = "F11";
			_keyLookups[Keyboard.F12] = "F12";
		}
	}
}