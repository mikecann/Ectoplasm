package ectoplasm
{
	import ash.core.Engine;
	import ash.core.System;
	import ash.integration.starling.StarlingFrameTickProvider;
	import ash.integration.swiftsuspenders.SwiftSuspendersEngine;
	
	import ectoplasm.common.EntityCreator;
	import ectoplasm.common.GameConfig;
	import ectoplasm.common.Highscores;
	import ectoplasm.common.SystemDisplayLayers;
	import ectoplasm.common.SystemPriorities;
	import ectoplasm.nodes.game.MicrophoneButtonNode;
	import ectoplasm.systems.game.AppLoadingSystem;
	import ectoplasm.systems.game.BackgroundScrollingSystem;
	import ectoplasm.systems.game.DebugMenuSystem;
	import ectoplasm.systems.game.GhostCollisionSystem;
	import ectoplasm.systems.game.GhostFollowingCameraSystem;
	import ectoplasm.systems.game.GhostMovementSystem;
	import ectoplasm.systems.game.GhostTouchControlsSystem;
	import ectoplasm.systems.game.MicrophoneSystem;
	import ectoplasm.systems.game.MicrophoneToggleButtonSystem;
	import ectoplasm.systems.game.ObstacleSystem;
	import ectoplasm.systems.game.ParticleTrailSystem;
	import ectoplasm.systems.game.RenderSystem;
	import ectoplasm.systems.states.CountdownGameStartStateSystem;
	import ectoplasm.systems.states.PlayingGameStateSystem;
	import ectoplasm.systems.states.PostGameStateSystem;
	import ectoplasm.systems.states.PreGameStateSystem;
	import ectoplasm.utils.input.KeyPoll;
	
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
			injector.map( Highscores ).toValue(new Highscores());			
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
			//engine.addSystem(new DebugMenuSystem(displayLayers.debug),SystemPriorities.UPDATE);
			engine.addSystem(new MicrophoneSystem(),SystemPriorities.MIC_INPUT);
			engine.addSystem(new GhostTouchControlsSystem(),SystemPriorities.TOUCH_INPUT);
			engine.addSystem(new ObstacleSystem(),SystemPriorities.UPDATE);
			engine.addSystem(new GhostFollowingCameraSystem(),SystemPriorities.UPDATE_CAMERA);
			engine.addSystem(new GhostMovementSystem(),SystemPriorities.UPDATE);
			engine.addSystem(new ParticleTrailSystem(),SystemPriorities.UPDATE);
			engine.addSystem(new BackgroundScrollingSystem(),SystemPriorities.UPDATE);
			engine.addSystem(new GhostCollisionSystem(),SystemPriorities.RESOLVE_COLLISIONS);
			engine.addSystem(new RenderSystem(displayLayers.render),SystemPriorities.RENDER);
			engine.addSystem(new MicrophoneToggleButtonSystem(displayLayers.hud),SystemPriorities.UPDATE);
			//engine.addSystem(new CameraTouchControlSystem(displayLayers.render),SystemPriorities.RENDER);
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