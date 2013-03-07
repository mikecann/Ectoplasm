package ectoplasm.common
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import ectoplasm.utils.starling.AtlasToBitmapsHelper;
	
	import starling.core.Starling;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;

	public class Assets
	{
		[Embed(source="/assets/images/ceiling.xml", mimeType="application/octet-stream")] public static const CEILING_XML : Class;		
		[Embed(source="/assets/images/ceiling.png")] public static const CEILING_PNG : Class;
		
		[Embed(source="/assets/images/ceiling@2x.xml", mimeType="application/octet-stream")] public static const CEILING_XML2 : Class;		
		[Embed(source="/assets/images/ceiling@2x.png")] public static const CEILING_PNG2 : Class;
		
		[Embed(source="/assets/images/floor.xml", mimeType="application/octet-stream")] public static const FLOOR_XML : Class;		
		[Embed(source="/assets/images/floor.png")] public static const FLOOR_PNG : Class;
		
		[Embed(source="/assets/images/floor@2x.xml", mimeType="application/octet-stream")] public static const FLOOR_XML2 : Class;		
		[Embed(source="/assets/images/floor@2x.png")] public static const FLOOR_PNG2 : Class;
		
		[Embed(source="/assets/images/objects.xml", mimeType="application/octet-stream")] public static const OBJECTS_XML : Class;		
		[Embed(source="/assets/images/objects.png")] public static const OBJECTS_PNG : Class;
		
		[Embed(source="/assets/images/objects@2x.xml", mimeType="application/octet-stream")] public static const OBJECTS_XML2 : Class;		
		[Embed(source="/assets/images/objects@2x.png")] public static const OBJECTS_PNG2 : Class;
		
		[Embed(source="/assets/fonts/rabiohead.fnt", mimeType="application/octet-stream")]	public static const RABIOHEAD_XML : Class;		
		[Embed(source = "/assets/fonts/rabiohead_0.png")] public static const RABIOHEAD_PNG : Class;		
				
		public static const PNGS : Array = [CEILING_PNG,FLOOR_PNG,OBJECTS_PNG];
		public static const PNGS2 : Array = [CEILING_PNG2,FLOOR_PNG2,OBJECTS_PNG2];
		
		public static const XMLS : Array = [CEILING_XML,FLOOR_XML,OBJECTS_XML];
		public static const XMLS2 : Array = [CEILING_XML2,FLOOR_XML2,OBJECTS_XML2];
		
		public static const NAMES : Array = ["Ceiling", "Floor", "Objects"];
		
		public static var bmdCache : Dictionary = new Dictionary();
		
		public static function initManager(manager:AssetManager) : void
		{			
			var isHD : Boolean = Starling.contentScaleFactor==2;
			trace("Starling.contentScaleFactor",Starling.contentScaleFactor);
			trace("isHD",isHD);
			
			var pngs : Array = isHD?PNGS2:PNGS;
			var xmls : Array = isHD?XMLS2:XMLS;			
					
			for(var i : int=0; i<pngs.length; i++)
			{
				var bitmap : Bitmap = new (pngs[i])();
				var tex : Texture = Texture.fromBitmap(bitmap,false,false,Starling.contentScaleFactor);
				var xml : XML = XML(new (xmls[i])());
				var atlas :TextureAtlas = new TextureAtlas(tex, xml);
				bmdCache = AtlasToBitmapsHelper.getBitmaps(atlas,bitmap.bitmapData,bmdCache);
				manager.addTextureAtlas(NAMES[i],atlas);
				
			}
			
			TextField.registerBitmapFont(new BitmapFont(Texture.fromBitmap(new RABIOHEAD_PNG()), XML(new RABIOHEAD_XML())),"rabiohead");
			
			trace();
		}	
	}
}