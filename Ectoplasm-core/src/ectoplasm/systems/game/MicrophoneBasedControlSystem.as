package ectoplasm.systems.game
{
	import flash.events.SampleDataEvent;
	import flash.media.Microphone;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.tools.ListIteratingSystem;
	
	import ectoplasm.nodes.game.GameNode;
	import ectoplasm.nodes.states.PlayingGameNode;
	
	public class MicrophoneBasedControlSystem extends ListIteratingSystem
	{
		private var mic : Microphone;
		private var _soundBytes:ByteArray = new ByteArray();
		private var games : NodeList;
		private var _micBytes:ByteArray;
		private var _micSound:Sound;
		
		public function MicrophoneBasedControlSystem()
		{
			super(PlayingGameNode,onUpdate);
		}
		
		override public function addToEngine( engine : Engine ) : void
		{
			super.addToEngine(engine);	
			
			games = engine.getNodeList( GameNode );
			
			mic = Microphone.getMicrophone();
			//var options:MicrophoneEnhancedOptions = new MicrophoneEnhancedOptions();
			//options.mode = MicrophoneEnhancedMode.FULL_DUPLEX;
			//mic.enhancedOptions = options;			
			
			if (mic) {
				mic.rate = 44;
				mic.gain = 80;
				mic.setUseEchoSuppression(true);
				mic.setLoopBack(true);
				//mic.addEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
			}
			
			//_micSound = new Sound();
			//_micSound.addEventListener(SampleDataEvent.SAMPLE_DATA, soundSampleDataHandler);
		}
		
		private function micSampleDataHandler(event:SampleDataEvent) :void {
			_micBytes = event.data;
			_micSound.play();
		}
		
		private function soundSampleDataHandler(event:SampleDataEvent):void {
			
			for (var i:int = 0; i < 8192 && _micBytes.bytesAvailable > 0; i++) {
				var sample:Number = _micBytes.readFloat();
				event.data.writeFloat(sample);
				event.data.writeFloat(sample);
			}
		}
		
		public function onUpdate(node:PlayingGameNode, time:Number):void
		{			
			if(!mic) return;
				
			/*SoundMixer.computeSpectrum(_soundBytes, true);
			if(_soundBytes.bytesAvailable)
			{
			
				var _ctr : int = 0;
				
				var res:Array = new Array();
				while (++_ctr < 512) {						
					if (_soundBytes.readFloat()>0.8)
					{
						res.push(_ctr);
					}
				}
				
				var sum:Number=0;
				for (var i:int =0; i<res.length; i++)
				{
					sum+=res[i];
				}
				var avg:Number = (sum/res.length);
				
				if(!isNaN(avg)) {		
					
					trace(avg);
					
					var pitchMin : Number = 128;
					var pitchMax : Number = 140;
					var range : Number = pitchMax - pitchMin;
					
					var pitch : Number = NumberUtils.clamp(pitchMin,pitchMax,avg)-pitchMin;
					pitch = pitch / range;
					
					trace(avg,pitch*100);
					
					var g : GameState = GameNode(games.head).state;
					g.pitch = pitch;
					
					
				}
				
				//var g : GameState = GameNode(games.head).state;
				//g.pitch = mic.activityLevel/100;
			}*/
			
			node.state.inputForce = mic.activityLevel/100;
		}
	}
}