package ectoplasm.systems.game
{
	import flash.geom.Point;
	
	import ash.core.Engine;
	import ash.core.System;
	
	import ectoplasm.common.SystemDisplayLayers;
	import ectoplasm.utils.math.NumberUtils;
	
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class CameraTouchControlSystem extends System
	{
		[Inject] public var displayLayers : SystemDisplayLayers;

		private var touchControlLayer:Sprite;
		
		public function CameraTouchControlSystem(touchControlLayer:Sprite) 
		{
			this.touchControlLayer = touchControlLayer;			
		}
		
		override public function addToEngine(engine:Engine):void
		{
			touchControlLayer.addEventListener(TouchEvent.TOUCH, onStageTouched);
		}		
		
		protected function onStageTouched(event:TouchEvent) : void
		{	
			var touches:Vector.<Touch> = event.getTouches(touchControlLayer, TouchPhase.MOVED);
			
			if (touches.length == 1)
			{
				// one finger touching -> move
				var delta:Point = touches[0].getMovement(touchControlLayer.parent);
				touchControlLayer.x += delta.x;
				touchControlLayer.y += delta.y;
			}        
			if (touches.length == 2)
			{
				// two fingers touching -> rotate and scale
				var touchA:Touch = touches[0];
				var touchB:Touch = touches[1];
				
				var currentPosA:Point  = touchA.getLocation(touchControlLayer.parent);
				var previousPosA:Point = touchA.getPreviousLocation(touchControlLayer.parent);
				var currentPosB:Point  = touchB.getLocation(touchControlLayer.parent);
				var previousPosB:Point = touchB.getPreviousLocation(touchControlLayer.parent);
				
				var currentVector:Point  = currentPosA.subtract(currentPosB);
				var previousVector:Point = previousPosA.subtract(previousPosB);
				
				var currentAngle:Number  = Math.atan2(currentVector.y, currentVector.x);
				var previousAngle:Number = Math.atan2(previousVector.y, previousVector.x);
				var deltaAngle:Number = currentAngle - previousAngle;
				
				// update pivot point based on previous center
				var previousLocalA:Point  = touchA.getPreviousLocation(touchControlLayer);
				var previousLocalB:Point  = touchB.getPreviousLocation(touchControlLayer);
				touchControlLayer.pivotX = (previousLocalA.x + previousLocalB.x) * 0.5;
				touchControlLayer.pivotY = (previousLocalA.y + previousLocalB.y) * 0.5;
				
				// update location based on the current center
				touchControlLayer.x = (currentPosA.x + currentPosB.x) * 0.5;
				touchControlLayer.y = (currentPosA.y + currentPosB.y) * 0.5;
				
				// scale
				var sizeDiff:Number = currentVector.length / previousVector.length;
				touchControlLayer.scaleX *= sizeDiff;
				touchControlLayer.scaleY *= sizeDiff;
				
				touchControlLayer.scaleX = NumberUtils.clamp(0.1,1,touchControlLayer.scaleX);
				touchControlLayer.scaleY = NumberUtils.clamp(0.1,1,touchControlLayer.scaleY);
			}
		}	
		
		override public function removeFromEngine(engine:Engine):void
		{
			touchControlLayer.removeEventListener(TouchEvent.TOUCH, onStageTouched);
		}
	}
}