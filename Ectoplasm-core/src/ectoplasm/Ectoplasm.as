package ectoplasm
{
	import ash.core.Engine;
	import ash.core.System;
	import ash.integration.starling.StarlingFrameTickProvider;
	import ash.integration.swiftsuspenders.SwiftSuspendersEngine;
	
	import ectoplasm.common.Assets;
	import ectoplasm.common.EntityCreator;
	import ectoplasm.common.GameConfig;
	import ectoplasm.common.GameStates;
	import ectoplasm.common.SystemDisplayLayers;
	import ectoplasm.common.SystemPriorities;
	import ectoplasm.systems.game.AppLoadingSystem;
	import ectoplasm.systems.game.BackgroundScrollingSystem;
	import ectoplasm.systems.game.DebugMenuSystem;
	import ectoplasm.systems.game.GameScoringSystem;
	import ectoplasm.systems.game.GhostCollisionSystem;
	import ectoplasm.systems.game.GhostFollowingCameraSystem;
	import ectoplasm.systems.game.GhostMovementSystem;
	import ectoplasm.systems.game.HUDSystem;
	import ectoplasm.systems.game.MicrophoneBasedControlSystem;
	import ectoplasm.systems.game.ObstacleSystem;
	import ectoplasm.systems.game.ParticleTrailSystem;
	import ectoplasm.systems.game.RenderSystem;
	import ectoplasm.systems.game.TouchBasedControlsSystem;
	import ectoplasm.systems.states.CountdownGameStartStateSystem;
	import ectoplasm.systems.states.LoadingStateSystem;
	import ectoplasm.systems.states.PlayingGameStateSystem;
	import ectoplasm.systems.states.PostGameStateSystem;
	import ectoplasm.systems.states.PreGameStateSystem;
	import ectoplasm.utils.input.KeyPoll;
	
	import feathers.themes.MetalWorksMobileTheme;
	
	import org.swiftsuspenders.Injector;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.utils.AssetManager;

	/**
	 * An arena based zombie shooter
	 */
	public class Ectoplasm extends Sprite
	{
		private var engine : SwiftSuspendersEngine;
		private var assets : AssetManager;
		private var injector : Injector;
		private var creator : EntityCreator;
		private var displayLayers : SystemDisplayLayers;
				
		public function Ectoplasm()
		{
			addEventListener( Event.ADDED_TO_STAGE, startGame );
		}
		
		private function startGame( event : Event ) : void
		{
			prepareInjector();			
			addSystems();
			start();
		}
		
		private function prepareInjector() : void
		{
			injector = new Injector();	
			injector.map( Injector ).toValue( injector ) ;
			injector.map( Engine ).toValue(engine = new SwiftSuspendersEngine(injector));			
			injector.map( Stage ).toValue( Starling.current.stage );
			injector.map( SystemDisplayLayers ).toValue( displayLayers = new SystemDisplayLayers(Starling.current.stage) );
			injector.map( Starling ).toValue( Starling.current );
			injector.map( KeyPoll ).toValue( new KeyPoll( Starling.current.nativeStage ) );
			injector.map( AssetManager ).toValue(assets = new AssetManager());
			injector.map( GameConfig ).toValue( new GameConfig(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight));
			injector.map( EntityCreator ).toValue(creator = injector.getInstance(EntityCreator))
		}
		
		private function addSystems() : void
		{
			// App
			engine.addSystem(new AppLoadingSystem(displayLayers.hud),SystemPriorities.PRE_UPDATE);
			
			// State systems
			engine.addSystem(new PreGameStateSystem(displayLayers.hud),SystemPriorities.PRE_UPDATE);
			engine.addSystem(new CountdownGameStartStateSystem(displayLayers.hud),SystemPriorities.PRE_UPDATE);
			engine.addSystem(new PlayingGameStateSystem(displayLayers.hud),SystemPriorities.PRE_UPDATE);
			engine.addSystem(new PostGameStateSystem(displayLayers.hud),SystemPriorities.PRE_UPDATE);
			
			// Game systems
			engine.addSystem(new DebugMenuSystem(displayLayers.debug),SystemPriorities.UPDATE);
			engine.addSystem(new MicrophoneBasedControlSystem(),SystemPriorities.POST_UPDATE);
			engine.addSystem(new TouchBasedControlsSystem(),SystemPriorities.UPDATE);
			engine.addSystem(new ObstacleSystem(),SystemPriorities.UPDATE);
			engine.addSystem(new GhostFollowingCameraSystem(),SystemPriorities.UPDATE_CAMERA);
			engine.addSystem(new GhostMovementSystem(),SystemPriorities.UPDATE);
			engine.addSystem(new ParticleTrailSystem(),SystemPriorities.UPDATE);
			engine.addSystem(new BackgroundScrollingSystem(),SystemPriorities.UPDATE);
			//engine.addSystem(new HUDSystem(displayLayers.hud,displayLayers.render),SystemPriorities.UPDATE);
			engine.addSystem(new GhostCollisionSystem(),SystemPriorities.RESOLVE_COLLISIONS);
			engine.addSystem(new RenderSystem(displayLayers.render),SystemPriorities.RENDER);
			//engine.addSystem(new CameraTouchControlSystem(displayLayers.render),SystemPriorities.RENDER);
		}
		
		/**
		 * A little helper function
		 */
		private function addSystem(systemType:Class, priority:int) : void
		{
			var system : System = new systemType();
			injector.injectInto(system);
			engine.addSystem(system,priority);
		}
		
		private function start() : void
		{			
			creator.createGameLoader();
			
			var tickProvider : StarlingFrameTickProvider = new StarlingFrameTickProvider( Starling.current.juggler );
			tickProvider.add( engine.update );
			tickProvider.start();
		}
	}
}