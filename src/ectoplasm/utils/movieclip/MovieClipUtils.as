package ectoplasm.utils.movieclip
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public class MovieClipUtils
	{
		public static function massStop(target:DisplayObjectContainer, frame:Object = 1):void
		{
			if (target is MovieClip)
				MovieClip(target).gotoAndStop(frame);
			var n:int = target.numChildren;
			for (var i:int = 0; i < n; i++)
			{
				var child:DisplayObjectContainer = target.getChildAt(i) 
					as DisplayObjectContainer;
				if (child)
					massStop(child, frame);
			}
		}
		
		public static function getFrontToBackListOfChildren(target:DisplayObjectContainer, list:Vector.<DisplayObject>=null) : Vector.<DisplayObject>
		{
			if(list==null) list = new Vector.<DisplayObject>();
			for (var i : int=0; i<target.numChildren; i++)
			{
				var c : DisplayObject = target.getChildAt(i);
				list.push(c);
				if(c is DisplayObjectContainer) getFrontToBackListOfChildren(c as DisplayObjectContainer, list);				
			}
			return list;
		}
		
		public static function massPlay(target:DisplayObjectContainer):void
		{
			if (target is MovieClip)
				MovieClip(target).play();
			var n:int = target.numChildren;
			for (var i:int = 0; i < n; i++)
			{
				var child:DisplayObjectContainer = target.getChildAt(i) 
					as DisplayObjectContainer;
				if (child)
					massPlay(child);
			}
		}
		
		public static function findMaxFrames(parent:Sprite, currentMax:int):int
		{
			if(parent is MovieClip){ currentMax = Math.max(currentMax, (parent as MovieClip).totalFrames); }
			for (var i:int=0; i < parent.numChildren; i++)
			{
				var o : DisplayObject = parent.getChildAt(i);
				if(o is Sprite){ currentMax = findMaxFrames(o as Sprite, currentMax); }			
			}			
			return currentMax;
		}
		
		public static function gotoAndStop(parent:MovieClip, frame:int):void
		{
			parent.gotoAndStop(frame);
			for (var j:int=0; j<parent.numChildren; j++)
			{
				var mc:MovieClip = parent.getChildAt(j) as MovieClip;
				if(!mc) { continue; }
				
				if (mc.totalFrames >= frame)
					mc.gotoAndStop(frame);
				else
					mc.gotoAndStop(mc.totalFrames);
				
				gotoAndStop(mc, frame);
			}
		}
				
		
		public static function gotoAndPlay(parent:MovieClip, frame:int):void
		{
			parent.gotoAndPlay(frame);
			for (var j:int=0; j<parent.numChildren; j++)
			{
				var mc:MovieClip = parent.getChildAt(j) as MovieClip;
				if(!mc) { continue; }
				
				if (mc.totalFrames >= frame)
					mc.gotoAndPlay(frame);
				else
					mc.gotoAndPlay(mc.totalFrames);
				
				gotoAndPlay(mc, frame);
			}
		}
		
		// Recurses through a container looking for all children that match the given name
		public static function getChildrenByName(parent:DisplayObjectContainer, name:String, sprites:Vector.<Sprite>=null) : Vector.<Sprite>
		{
			if(!sprites){ sprites = new Vector.<Sprite>(); }
			if (parent.name==name){sprites.push(parent);}
			for (var i:int=0; i<parent.numChildren; i++)
			{
				var child : DisplayObject = parent.getChildAt(i);
				if(!(child is DisplayObjectContainer)){ continue; }
				getChildrenByName(child as Sprite, name, sprites);
			}
			return sprites;
		}
		
		// Recursively extracs all the non-null and non-empty named symbols from a display object container
		public static function getAllNamedSymbols(parent:DisplayObjectContainer, symbols:Vector.<DisplayObject>=null) : Vector.<DisplayObject>
		{
			if(!symbols){ symbols = new Vector.<DisplayObject>(); }
			if(parent.name!=null && parent.name!="") symbols.push(parent);
			for (var i:int=0; i<parent.numChildren; i++)
			{
				var child : DisplayObject = parent.getChildAt(i);
				if(child is DisplayObjectContainer){ getAllNamedSymbols(child as DisplayObjectContainer,symbols); }
				else { if(child && child.name!=null && child.name!="") symbols.push(parent); }
			}
			return symbols;
		}
		
		// Recurses through a container looking for the first child that matches the given name
		public static function getChildByName(parent:DisplayObjectContainer, name:String) : Sprite
		{
			for (var i:int=0; i<parent.numChildren; i++)
			{
				var child : DisplayObject = parent.getChildAt(i);
				if(!(child is Sprite)){ continue; }
				if(child.name==name){ return child as Sprite; }
				var s : Sprite = getChildByName(child as Sprite, name);
				if(s){ return s; }
			}
			return null;
		}
		
		public static function getFrameSceneIndicies(mc:MovieClip) : Array
		{
			var o : Array = [];			
			var sceneIndex : int = 0;
			var currentScene : Scene = mc.scenes[sceneIndex];
			var currentFrameIndex : int = 1;
			for (var i:int=1; i<mc.totalFrames+1; i++)
			{				
				o[i] = {s:currentScene,f:currentFrameIndex};
				if(++currentFrameIndex>currentScene.numFrames)
				{
					currentFrameIndex = 1;
					currentScene = mc.scenes[++sceneIndex];
				}				
			}
			return o;
		}
		
		public static function preventEventPropegation(target:IEventDispatcher, eventTypes:Array) : void
		{
			for each (var et : String in eventTypes) target.addEventListener(et,function(e:Event) : void { e.stopImmediatePropagation();  }, false, 0, true);			
		}
	}
}