package ectoplasm.systems.game
{
	import flash.utils.getTimer;
	
	import ash.core.Engine;
	import ash.tools.ListIteratingSystem;
	
	import ectoplasm.common.Assets;
	import ectoplasm.common.EntityCreator;
	import ectoplasm.common.GameLoadingView;
	import ectoplasm.common.GameStates;
	import ectoplasm.nodes.game.GameLoadingNode;
	import ectoplasm.nodes.game.GameNode;
	import ectoplasm.nodes.states.PlayingGameNode;
	
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	public class AppLoadingSystem extends ListIteratingSystem
	{
		[Inject] public var assets : AssetManager;
		[Inject] public var engine : Engine;		
		[Inject] public var creator : EntityCreator;
		
		private var steps : Array = [
			{n:"Init assets", f:initAssets},
			{n:"Init feathers", f:initFeathers},
			{n:"Start game", f:startGame},
		];

		private var container:Sprite;
		
		public function AppLoadingSystem(container:Sprite)
		{
			super(GameLoadingNode,onUpdate,onNodeAdded,onNodeRemoved);
			this.container = container;
		}
		
		private function  onNodeAdded(node:GameLoadingNode) : void
		{
			container.addChild(node.loading.view);
		}
		
		private function  onNodeRemoved(node:GameLoadingNode) : void
		{
			container.removeChild(node.loading.view);
		}
		
		private function onUpdate(node:GameLoadingNode, time:Number) : void
		{				
			if(!node.loading.loadingProgress!=100)
			{
				// Execute the loading step (and time it)
				var start : int = getTimer();
				var o : Object = steps[node.loading.step];
				o.f();
				trace(o.n,"took",getTimer()-start,"ms");					
				
				// Set the appropriate value
				node.loading.loadingProgress = (node.loading.step/steps.length)*100;
				
				// Update the loading bar
				node.loading.view.setProgress(node.loading.loadingProgress);
	
				// If we are done loading
				if(++node.loading.step>steps.length-1)
					creator.destroyEntity(node.entity);
			}			
		}	
		
		private function initAssets() : void
		{
			Assets.initManager(assets);
		}
		
		private function initFeathers() : void
		{
			new MetalWorksMobileTheme(Starling.current.stage);
		}
				
		private function startGame() : void
		{
			creator.createBackground();
			creator.createCamera();
			creator.createGame(GameStates.PRE_GAME);
		}	
				
	}
}