package ectoplasm.systems.game
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	
	import ectoplasm.common.EntityCreator;
	import ectoplasm.common.GameConfig;
	import ectoplasm.common.GameStates;
	import ectoplasm.nodes.game.BackgroundNode;
	import ectoplasm.nodes.game.GameNode;
	import ectoplasm.nodes.game.GhostNode;
	import ectoplasm.nodes.game.ObstacleNode;
	import ectoplasm.utils.math.NumberUtils;
	import ectoplasm.utils.string.StringUtils;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class HUDSystem extends System
	{
		public static const STATE_TRANS_TIME : Number = 1;
		
		[Inject] public var config : GameConfig;
		[Inject] public var assets : AssetManager;
		[Inject] public var creator : EntityCreator;
		
		private var games : NodeList;
		private var ghosts : NodeList;
		
		private var container:Sprite;
		private var renderContainer:Sprite;
		private var scoreTF :TextField;
		
		private var darkener : Quad;
		private var titleImage : Image;
		private var startBtn :Button;
		
		private var lastState : int;
		private var gameBlurFilter : BlurFilter;
		private var stateTransitionTimer : Number;
		
		public function HUDSystem(container:Sprite, renderContainer:Sprite)
		{
			this.container = container;
			this.renderContainer = renderContainer;
		}
		
		override public function addToEngine( engine : Engine ) : void
		{
			ghosts = engine.getNodeList( GhostNode ) ;
			games = engine.getNodeList( GameNode ) ;
			
			
			
			
			
			
				
			darkener = new Quad(config.width,config.height,0);
			container.addChild(darkener);
			
			
			
			var rw : Number = Math.min(256/Starling.current.viewPort.width,1);
			var rh : Number = Math.min(256/Starling.current.viewPort.height,1);
			var r : Number = Math.min(rw,rh);
			
			trace(rw,rh,r);
			
			gameBlurFilter = new BlurFilter(5,5,r);
									
			lastState = GameStates.END;
			stateTransitionTimer = 0;
		}
		
		
		
		override public function update( time : Number ) : void
		{
			var ghost : GhostNode = ghosts.head;
			var game : GameNode = games.head;
			if(!game) return;
			
			if(lastState!=game.state.state) stateTransitionTimer = 0;
			
			var stateTransitionRatio : Number = NumberUtils.clamp(0,1,(stateTransitionTimer/STATE_TRANS_TIME))
			
			if(game.state.state==GameStates.START)
			{				
				scoreTF.visible = false;	
				darkener.visible = true;
				startBtn.visible = true;
				countDownTimer.visible = false;
				darkener.alpha= stateTransitionRatio/5;
				renderContainer.filter = gameBlurFilter;
				gameBlurFilter.blurX = 5*stateTransitionRatio;
				gameBlurFilter.blurY = 5*stateTransitionRatio;
			}
			else if(game.state.state==GameStates.STARTING_GAME)
			{
				titleImage.visible = false;
				startBtn.visible = false;
				
				renderContainer.filter = gameBlurFilter;
				gameBlurFilter.blurX = 5*(1-stateTransitionRatio);
				gameBlurFilter.blurY = 5*(1-stateTransitionRatio);
				darkener.alpha = (1-stateTransitionRatio)/5;
				
				if (stateTransitionRatio==1) renderContainer.filter = null;
				else renderContainer.filter = gameBlurFilter;
				
				if(game.state.startingTimer>1)
				{
					countDownTimer.visible = true;
					countDownTimer.text = int(game.state.startingTimer)+""
				}
				else if(game.state.startingTimer>0)
				{
					countDownTimer.visible = true;
					countDownTimer.text = "GO";
				}
				else
				{
					countDownTimer.visible = false;
				}		
			}
			else if(game.state.state==GameStates.GAME)
			{				
				renderContainer.filter=null;
				scoreTF.visible = true;
				darkener.visible = false;
				countDownTimer.visible = false;					
				
				scoreTF.text = StringUtils.padLeft(game.state.score+"","0",8);
			}
			else if(game.state.state==GameStates.END)
			{
				scoreTF.visible = true;
				darkener.visible = true;
				titleImage.visible = true;
				startBtn.visible = true;
				startBtn.upState = assets.getTexture("again_up");
				darkener.alpha= stateTransitionRatio/5;
				renderContainer.filter = gameBlurFilter;
				gameBlurFilter.blurX = 5*stateTransitionRatio;
				gameBlurFilter.blurY = 5*stateTransitionRatio;
			}			
					
			lastState = game.state.state;
			stateTransitionTimer+=time;				
		}		
	}
}