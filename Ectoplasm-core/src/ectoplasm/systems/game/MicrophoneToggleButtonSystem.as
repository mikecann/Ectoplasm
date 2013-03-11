package ectoplasm.systems.game
{
	import ash.core.Engine;
	import ash.tools.ListIteratingSystem;
	
	import ectoplasm.common.GameConfig;
	import ectoplasm.components.game.Microphone;
	import ectoplasm.nodes.game.GameNode;
	import ectoplasm.nodes.game.MicrophoneButtonNode;
	import ectoplasm.nodes.game.MicrophoneNode;
	
	import starling.display.Sprite;
	
	public class MicrophoneToggleButtonSystem extends ListIteratingSystem
	{
		[Inject] public var engine : Engine;
		[Inject] public var config : GameConfig;
		
		private var container : Sprite;
		
		public function MicrophoneToggleButtonSystem(container:Sprite)
		{
			this.container = container;
			super(MicrophoneButtonNode, onUpdate, onNodeAdded, onNodeRemoved);
		}
		
		private function onNodeAdded(node:MicrophoneButtonNode) : void
		{
			node.view.x = 20;
			node.view.y = config.height-node.view.height-40;
			container.addChild(node.view);
		}
		
		private function onNodeRemoved(node:MicrophoneButtonNode) : void
		{
			container.removeChild(node.view);
		}
		
		private function onUpdate(node:MicrophoneButtonNode,time:Number):void
		{
			var game : GameNode = engine.getNodeList(GameNode).head;
			var mic : MicrophoneNode = engine.getNodeList(MicrophoneNode).head;
			
			if(mic) node.view.setMicLevel(mic.mic.activityLevel*100);
			
			if(node.view.triggered)
			{
				node.view.triggered = false;				
				
				var micEnabled : Boolean = game.entity.has(Microphone);
				micEnabled?game.entity.remove(Microphone):game.entity.add(new Microphone());
				node.view.isEnabled = !micEnabled;
			}
		}
	}
}