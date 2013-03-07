package ectoplasm.utils.debug
{
	import com.playdemic.core.framework.base.CoreGlobals;
	
	import flash.utils.getTimer;

	public class DebugTimer
	{
		// Protecteds
		protected var _startTime : int;
		protected var _running : Boolean = false;
		protected var _delta : int;
		
		public function start(reporter:Object=null,logMsg:String=null) : DebugTimer
		{
			// We are running
			_running = true;
			
			// Log if we need to
			if(reporter && logMsg){ CoreGlobals.logger.debug(reporter,logMsg); }
			
			// Record when timing starts
			_startTime = getTimer();		
			
			// Return this for some chaining goodness
			return this;
		}
		
		public function stop(reporter:Object=null,logMsg:String=null) : int
		{
			// Work out the delta
			_delta = getTimer()-_startTime;
			
			// Report if we need to
			if(reporter){ CoreGlobals.logger.debug(reporter,(logMsg ? logMsg + ". " : "") + "Time taken: " + delta + "ms"); }
			
			// Stick it back in the pool 
			_freeTimerPool.push(this);
			
			// No longer running
			_running = false;
			
			// Return the time if needed
			return _delta;
		}
		
		public function get delta():int
		{
			return _delta;
		}
		
		// A simple object pool for our timers
		protected static var _freeTimerPool : Array = [];
		public static function getT() : DebugTimer
		{
			var t : DebugTimer;
			while(!t){ t=_freeTimerPool.pop(); if(!t){break;} if(t._running){t=null;}}
			return t ||= new DebugTimer();
		}
	}
}