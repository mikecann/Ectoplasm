package ectoplasm.views
{
	import ectoplasm.common.GameConfig;
	import ectoplasm.utils.string.StringUtils;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class ScoreView extends Sprite
	{
		private var scoreTF :TextField;
		private var scoreBG : Image;
		
		public function ScoreView(assets:AssetManager, config:GameConfig)
		{
			var s : Sprite = new Sprite();			
			
			scoreBG = new Image(assets.getTexture("score_tab"));
			s.addChild(scoreBG);
			
			scoreTF = new TextField(600,200,"00000000","sarcasticrobot", 100, 0xffffff);
			scoreTF.hAlign = HAlign.LEFT;
			scoreTF.vAlign = VAlign.TOP;
			scoreTF.x = 60;
			scoreTF.y = 23;
			scoreTF.filter = BlurFilter.createDropShadow();
			s.addChild(scoreTF);			
			
			addChild(s);
		}
		
		public function setScore(score:int) : void
		{
			scoreTF.text = StringUtils.padLeft(score+"","0",8);
		}
	}
}