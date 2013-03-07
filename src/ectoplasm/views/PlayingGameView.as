package ectoplasm.views
{
	import ectoplasm.common.GameConfig;
	import ectoplasm.utils.string.StringUtils;
	
	import starling.display.Sprite;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class PlayingGameView extends Sprite
	{
		private var scoreTF :TextField;
		
		public function PlayingGameView(assets:AssetManager, config:GameConfig)
		{
			scoreTF = new TextField(600,200,"000000124","rabiohead", 130, 0xffffff);
			scoreTF.hAlign = HAlign.LEFT;
			scoreTF.vAlign = VAlign.TOP;
			scoreTF.filter = BlurFilter.createDropShadow();
			scoreTF.x = config.width-scoreTF.width+180;
			scoreTF.y = -10;
			addChild(scoreTF);
		}
		
		public function updateScore(score:Number) : void
		{
			scoreTF.text = StringUtils.padLeft(score+"","0",8);
		}
	}
}