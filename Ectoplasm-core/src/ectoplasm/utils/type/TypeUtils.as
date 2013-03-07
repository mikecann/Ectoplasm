package ectoplasm.utils.type
{
	import flash.utils.Proxy;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class TypeUtils
	{
		public static function getClassName(instance:*) : String
		{
			var a : Array = getQualifiedClassName(instance).split("::");
			if(a.length>1){return a[1]; }
			return "unknown";
		}
		
		public static function getObjectParts(instance:Object) : Vector.<String>
		{
			var a : Array = getQualifiedClassName(instance).split("::");
			return Vector.<String>(String(a[0]).split(".").concat(a[1]));
		}
		
		public static function getClass(value:*):Class
		{
			if(value is Class){ return value; }
			
			/*
			There are several types for which the 'constructor' property doesn't work:
			- instances of Proxy, XML and XMLList throw exceptions when trying to access 'constructor'
			- int and uint return Number as their constructor
			For these, we have to fall back to more verbose ways of getting the constructor.
			
			Additionally, Vector instances always return Vector.<*> when queried for their constructor.
			Ideally, that would also be resolved, but the SwiftSuspenders wouldn't be compatible with
			Flash Player < 10, anymore.
			*/
			if (value is Proxy || value is Number || value is XML || value is XMLList)
			{
				var fqcn : String = getQualifiedClassName(value);
				return Class(getDefinitionByName((fqcn)));
			}
			return value.constructor;
		}
	}
}