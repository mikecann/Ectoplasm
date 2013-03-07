package ectoplasm.utils.misc
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

	public class DelayCall
	{
		public static var activeSprites : Vector.<Sprite> = new  Vector.<Sprite>();
		
		public static function frames(f:Function,numFrames:int=1) : void
		{
			var s : Sprite = new Sprite();
			var tmpF : Function = function(e:Event) : void
			{
				if(--numFrames<=0) 
				{
					s.removeEventListener(Event.ENTER_FRAME, tmpF);
					activeSprites.splice(activeSprites.indexOf(s),1);
					f();					
				}
			};
			s.addEventListener(Event.ENTER_FRAME,tmpF);
			activeSprites.push(s);
		}
		
		public static function milliseconds(f:Function,ms:int=1000) : void
		{
			var s : Sprite = new Sprite();
			var startT : Number = getTimer();
			var tmpF : Function = function(e:Event) : void
			{
				if(getTimer()-startT>ms) 
				{
					s.removeEventListener(Event.ENTER_FRAME, tmpF);
					activeSprites.splice(activeSprites.indexOf(s),1);
					f();					
				}
			};
			s.addEventListener(Event.ENTER_FRAME,tmpF);
			activeSprites.push(s);
		}
			
	}
}