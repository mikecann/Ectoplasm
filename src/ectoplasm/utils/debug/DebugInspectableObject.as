package ectoplasm.utils.debug
{
	import com.playdemic.core.framework.base.CoreModel;
	
	import flash.utils.describeType;

	public class DebugInspectableObject extends CoreModel
	{
		// Consts
		public static const IGNORED_PROPERTIES : Array = ["logger","eventbus","injector","entity"];
		
		protected var _children : Vector.<DebugInspectableObject>;
		protected var _key:String;		
		protected var _value:*;
		protected var _parentObject : Object;
		protected var _description : XML;
		protected var _isPrimitive : Boolean;
		protected var _readOnly : Boolean;
		
		public function init(parent:Object,key:String,readOnly:Boolean) : void
		{
			_readOnly = readOnly;
			_parentObject = parent;
			_key = key;
			_description = describeType(value);
			_isPrimitive = value is int || value is Number || value is String || value is uint || value is Boolean;
		}
		
		public function getChildren() : Vector.<DebugInspectableObject>
		{
			if(!_children)
			{			
				_children = new Vector.<DebugInspectableObject>();			
				addToChildren(_description.variable);
				addToChildren(_description.accessor);					
			}			
			return _children;
		}			
		
		protected function addToChildren(propsXML:XMLList) : void
		{
			for each(var property : XML in propsXML)
			{
				if(IGNORED_PROPERTIES.indexOf(String(property.@name).toLocaleLowerCase())!=-1){ continue; }
				var o : DebugInspectableObject = new DebugInspectableObject();
				var ro : Boolean = String(property.name())=="accessor" && String(property.@access)=="readonly";			
				o.init(value, property.@name,ro);
				_children.push(o);
			}
		}

		public function get key():String
		{
			return _key;
		}

		public function set key(value:*):void
		{
			_key = value;
		}

		public function get value():*
		{
			return _parentObject[_key];
		}

		public function set value(value:*):void
		{
			_parentObject[_key] = value;
		}

		public function get isPrimitive():Boolean
		{
			return _isPrimitive;
		}		

		public function get readOnly():Boolean
		{
			return _readOnly;
		}
	}
}