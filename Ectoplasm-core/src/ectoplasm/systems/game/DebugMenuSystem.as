package ectoplasm.systems.game
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	
	import ectoplasm.common.EntityCreator;
	
	import feathers.controls.ButtonGroup;
	
	import org.swiftsuspenders.Injector;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.display.Stage;
	
	public class DebugMenuSystem extends System
	{
		[Inject] public var stage : Stage;
		[Inject] public var engine : Engine;
		[Inject] public var creator : EntityCreator;
		[Inject] public var injector : Injector;
		
		private var container : Sprite;
		private var buttons : ButtonGroup;
		private var pitchLevelContainer : Sprite;
		private var pitchBar : Quad;
		private var games : NodeList;
		
		public function DebugMenuSystem(container:Sprite)
		{
			this.container = container;
		}
		
		override public function addToEngine(engine:Engine):void
		{
			//container.addChild(buttons = new ButtonGroup());	
			
			//buttons.dataProvider = new ListCollection(
				//[
			
				//]);	
			//buttons.gap = 1;
			//buttons.width = 150;
			//buttons.validate();
			//buttons.x = stage.width-buttons.width - 5;
			//buttons.y = 5;
						
			//makePitchLevelMeter();		
			
			////games = engine.getNodeList( GameNode );
		}		
		
		override public function update(time:Number):void
		{
			//var game : GameNode = engine.getNodeList(GameNode).head;
			//if(game) setPitch(game.game.inputForce);				
		}
		
		/*private function makePitchLevelMeter():void
		{
			pitchLevelContainer = new Sprite();
			
			var outer : Quad = new Quad(10,200);
			var inner : Quad = new Quad(8,198,0);
			pitchBar = new Quad(6,196);
			
			inner.x = 1;
			inner.y = 1;
			pitchBar.x = 2;
			pitchBar.y = 2;
			
			pitchLevelContainer.addChild(outer);
			pitchLevelContainer.addChild(inner)
			pitchLevelContainer.addChild(pitchBar)
			pitchLevelContainer.x = 5;
			pitchLevelContainer.y = stage.stageHeight-205;			
						
			container.addChild(pitchLevelContainer);
		}
		
		private function setPitch(val:Number) : void
		{
			pitchBar.scaleY = val;
			pitchBar.y = 198-pitchBar.height;
		}		*/		
	}
}