package ectoplasm.utils.starling
{		
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class StarlingDraggingHelper
	{
		private var _dragTarget: DisplayObject;
		private var _lockX : Boolean;
		private var _lockY : Boolean;
		private var _targetStartPos : Point;
		private var _touchStartPos : Point;
		
		public function StarlingDraggingHelper(dragTarget:DisplayObject, lockX:Boolean=false, lockY:Boolean=false)
		{
			_dragTarget = dragTarget;		
			_lockX = lockX;
			_lockY = lockY;
		}
		
		public function startListening() : StarlingDraggingHelper
		{
			_dragTarget.addEventListener(TouchEvent.TOUCH, onTouch);
			return this;
		}			
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_dragTarget.stage);
			if(!touch) return;
			
			var position:Point = touch.getLocation(_dragTarget.stage);		
			
			if(touch.phase == TouchPhase.BEGAN )
			{
				_touchStartPos = position.clone();
				_targetStartPos = new Point(_dragTarget.x,_dragTarget.y);
			}
			else if(touch.phase == TouchPhase.MOVED )
			{
				if(!_lockX) _dragTarget.x = _targetStartPos.x+(position.x-_touchStartPos.x); 
				if(!_lockY) _dragTarget.y = _targetStartPos.y+(position.y-_touchStartPos.y);
			}		
		}	
		
		public function stopListening() : StarlingDraggingHelper
		{			
			_dragTarget.removeEventListener(TouchEvent.TOUCH, onTouch);
			return this;
		}
		
		public function stopListeningWhenHandleRemovedFromStage() : StarlingDraggingHelper
		{
			_dragTarget.addEventListener(Event.REMOVED_FROM_STAGE, onHandleRemovedFromStage);
			return this;
		}
		
		protected function onHandleRemovedFromStage(event:Event):void
		{
			_dragTarget.removeEventListener(Event.REMOVED_FROM_STAGE, onHandleRemovedFromStage);
			stopListening();
		}
	}
}