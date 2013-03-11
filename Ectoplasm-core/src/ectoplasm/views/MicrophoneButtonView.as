package ectoplasm.views
{
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class MicrophoneButtonView extends Sprite
	{		
		public var triggered:Boolean;
		public var microphoneToggle : Button;
		
		private var assets : AssetManager;
		private var _isEnabled : Boolean;
		
		public function MicrophoneButtonView(assets:AssetManager)
		{
			this.assets = assets;
			_isEnabled = true;
			microphoneToggle = new Button(assets.getTexture("volume_00"));
			microphoneToggle.addEventListener(TouchEvent.TOUCH, onMicToggleClicked);
			addChild(microphoneToggle);
		}		

		private function onMicToggleClicked(e:TouchEvent):void
		{
			var t : Touch = e.getTouch(this,TouchPhase.ENDED);
			if(t) triggered = true;
		}
		
		public function setMicLevel(levelPercent:int) : void
		{
			if(_isEnabled)
			{
				var s : String = "volume_0"+int(levelPercent/10);
				if(levelPercent==100) s = "volume_10";
				microphoneToggle.upState = assets.getTexture(s);
			}
		}
		
		public function get isEnabled():Boolean
		{
			return _isEnabled;
		}
		
		public function set isEnabled(value:Boolean):void
		{
			_isEnabled = value;
			microphoneToggle.upState = assets.getTexture(_isEnabled?"volume_00":"microphone_disabled");		
		}
	}
}