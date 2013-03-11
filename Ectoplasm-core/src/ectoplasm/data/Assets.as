package ectoplasm.data
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import br.com.stimuli.loading.BulkLoader;
	
	import ectoplasm.utils.starling.AtlasToBitmapsHelper;
	
	import starling.core.Starling;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;

	public class Assets
	{
		public static var collisionData : Dictionary = new Dictionary();
		
		public static const spriteSheetDir : String = "assets/spritesheets/";
		public static const spriteSheets : Array = ["floor","objects","backgrounds","menus","tiles2","ceiling"];
		public static const collideableSpriteSheets : Array = ["ceiling","floor","objects","tiles2"];
		
		public static function addAssets(loader:BulkLoader) : void
		{
			var isHD : Boolean = Starling.contentScaleFactor==2;
			for each (var spriteSheetName : String in spriteSheets)
			{
				loader.add(spriteSheetDir+spriteSheetName+".xml");
				loader.add(spriteSheetDir+spriteSheetName+".png");
				
				// If we are running in HD then we need those too. 
				if(isHD)
				{
					loader.add(spriteSheetDir+spriteSheetName+"-hd.xml");
					loader.add(spriteSheetDir+spriteSheetName+"-hd.png");
				}
			}
			
			// Add fonts
			loader.add("assets/fonts/sarcasticrobot.xml");
			loader.add("assets/fonts/sarcasticrobot_0.png");
		}
		
		public static function populateAssetManager(assets:AssetManager, loader:BulkLoader):void
		{
			var isHD : Boolean = Starling.contentScaleFactor==2;
			for each (var spriteSheetName : String in spriteSheets)
			{				
				var bitmap : Bitmap = loader.getBitmap(spriteSheetDir+spriteSheetName+(isHD?"-hd":"")+".png");
				var xml : XML = loader.getXML(spriteSheetDir+spriteSheetName+(isHD?"-hd":"")+".xml");

				var tex : Texture = Texture.fromBitmap(bitmap,false,false,Starling.contentScaleFactor);
				var atlas :TextureAtlas = new TextureAtlas(tex, xml);
				assets.addTextureAtlas(spriteSheetName,atlas);
			}
		}
		
		public static function registerFonts(loader:BulkLoader) : void
		{
			var bitmap : Bitmap = loader.getBitmap("assets/fonts/sarcasticrobot_0.png");
			var xml : XML = loader.getXML("assets/fonts/sarcasticrobot.xml");
			TextField.registerBitmapFont(new BitmapFont(Texture.fromBitmap(bitmap), xml),"sarcasticrobot");			
		}
		
		public static function constructCollisionData(loader:BulkLoader):void
		{
			for each (var spriteSheetName : String in collideableSpriteSheets)
			{				
				var bitmap : Bitmap = loader.getBitmap(spriteSheetDir+spriteSheetName+".png");
				var xml : XML = loader.getXML(spriteSheetDir+spriteSheetName+".xml");
				
				var tex : Texture = Texture.fromBitmap(bitmap,false,false,1);
				var atlas :TextureAtlas = new TextureAtlas(tex, xml);
				AtlasToBitmapsHelper.getBitmaps(atlas,bitmap.bitmapData,collisionData);
				atlas.dispose();
			}
		}		
	}
}