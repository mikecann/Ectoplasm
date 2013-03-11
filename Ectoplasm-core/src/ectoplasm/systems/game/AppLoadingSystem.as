package ectoplasm.systems.game
{
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import ash.core.Engine;
	import ash.tools.ListIteratingSystem;
	
	import br.com.stimuli.loading.BulkLoader;
	
	import ectoplasm.common.EntityCreator;
	import ectoplasm.common.GameStates;
	import ectoplasm.data.Assets;
	import ectoplasm.nodes.game.GameLoadingNode;
	
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
			{n:"Load assets", f:initAssets},
			{n:"Init feathers", f:initFeathers},
			{n:"Start game", f:startGame},
		];

		private var container:Sprite;
		private var stepStartTime : int;
		private var assetLoader : BulkLoader;
		private var assetsLoaded : Boolean;
		
		public function AppLoadingSystem(container:Sprite)
		{
			super(GameLoadingNode,onUpdate,onNodeAdded,onNodeRemoved);
			this.container = container;
			stepStartTime = -1;
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
				if(stepStartTime==-1) stepStartTime = getTimer();
				var o : Object = steps[node.loading.step];
				var prog : int = o.f();
				
				// Set the appropriate value
				node.loading.loadingProgress = ((node.loading.step/steps.length)*100)+(prog/steps.length);
				
				// Update the loading bar
				node.loading.view.setProgress(node.loading.loadingProgress);
				
				if(prog==100)
				{
					node.loading.step++;
					trace(o.n,"took",getTimer()-stepStartTime,"ms");
					stepStartTime = -1;
				}
				
				// If we are done loading
				if(node.loading.step>steps.length-1)
					creator.destroyEntity(node.entity);
			}			
		}	
		
		private function initAssets() : int
		{
			if(!assetLoader)
			{
				assetLoader = new BulkLoader("main-asset-loader");
				assetLoader.addEventListener(BulkLoader.COMPLETE, onAllLoaded);
				Assets.addAssets(assetLoader);		
				assetsLoaded = false;
				assetLoader.start();
			}
			else
			{				
				// Theres a wierd thing with BulkLoader where the percent loaded can be 100
				// but the last item hasnt been loaded so to ensure everything has been
				// loaded I have to wait for BulkLoader.COMPLETE
				if(assetsLoaded)
				{
					Assets.populateAssetManager(assets,assetLoader);
					Assets.registerFonts(assetLoader);
					Assets.constructCollisionData(assetLoader);					
				}
				var prog : int = assetLoader.weightPercent*100;
				if(!assetsLoaded) return prog-1;
				else return 100;
			}			
			return 0;
		}
		
		protected function onAllLoaded(event:Event):void
		{
			assetsLoaded = true;
		}
		
		private function initFeathers() : int
		{
			new MetalWorksMobileTheme(Starling.current.stage);
			return 100;
		}
				
		private function startGame() : int
		{
			creator.createBackground();
			creator.createCamera();
			creator.createGame(GameStates.PRE_GAME);
			return 100;
		}	
				
	}
}