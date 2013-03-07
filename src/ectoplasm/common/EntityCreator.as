package ectoplasm.common
{
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.core.Node;
	import ash.core.NodeList;
	import ash.fsm.EntityStateMachine;
	
	import ectoplasm.components.game.Background;
	import ectoplasm.components.game.Camera;
	import ectoplasm.components.game.Display;
	import ectoplasm.components.game.Game;
	import ectoplasm.components.game.Ghost;
	import ectoplasm.components.game.Obstacle;
	import ectoplasm.components.game.Particle;
	import ectoplasm.components.game.Position;
	import ectoplasm.components.game.Velocity;
	import ectoplasm.components.states.CountdownGameStartState;
	import ectoplasm.components.states.GameLoading;
	import ectoplasm.components.states.PlayingGameState;
	import ectoplasm.components.states.PostGameState;
	import ectoplasm.components.states.PreGameState;
	import ectoplasm.data.ObstacleTypeVO;
	import ectoplasm.views.CountdownGameStartView;
	import ectoplasm.views.GhostView;
	import ectoplasm.views.ObstacleView;
	import ectoplasm.views.PlayingGameView;
	import ectoplasm.views.PostGameView;
	import ectoplasm.views.PreGameView;
	
	import starling.display.Image;
	import starling.utils.AssetManager;

	public class EntityCreator
	{
		[Inject] public var engine : Engine;
		[Inject] public var assetMan : AssetManager;
		[Inject] public var config : GameConfig;
		
		public function destroyEntity( entity : Entity ) : void
		{
			engine.removeEntity( entity );
		}
		
		public function destroyAll(nodeType:Class):void
		{
			var list : NodeList = engine.getNodeList(nodeType);
			for( var node : Node = list.head; node; node = node.next ) 
				destroyEntity(node.entity);
		}	
		
		public function createGameLoader() : Entity
		{
			var e : Entity = new Entity();
			e.add(new GameLoading(new GameLoadingView(config)));
			engine.addEntity( e );
			return e;
		}
		
		public function createGame(startingState:String) : Entity
		{
			var e : Entity = new Entity();
			
			var fsm : EntityStateMachine = new EntityStateMachine(e);			
			e.add( new Game(fsm) );
			
			fsm.createState(GameStates.COUNTDOWN)
				.add(CountdownGameStartState)
				.withInstance(new CountdownGameStartState(new CountdownGameStartView(assetMan,config)));
			
			fsm.createState(GameStates.PRE_GAME)
				.add(PreGameState)
				.withInstance(new PreGameState(new PreGameView(assetMan,config)));
			
			fsm.createState(GameStates.PLAYING)
				.add(PlayingGameState)
				.withInstance(new PlayingGameState(new PlayingGameView(assetMan,config)));
			
			fsm.createState(GameStates.POST_GAME)
				.add(PostGameState)
				.withInstance(new PostGameState(new PostGameView(assetMan,config)));
			
			fsm.changeState(startingState);
						
			engine.addEntity( e );
			return e;
		}		
		
		public function createObstacle(type:ObstacleTypeVO, north:Boolean, x:Number, y:Number):Entity
		{
			var e : Entity = new Entity();
			e.add( new Obstacle(type, north) );
			e.add( new Position(x,y,1) );
			e.add( new Display(new ObstacleView(assetMan,type),DisplayDepths.OBSTACLE) );
			engine.addEntity( e );
			return e;
		}
		
		public function createGhost(x:Number, y:Number):Entity
		{
			var e : Entity = new Entity()		
				.add(new Ghost())
				.add(new Position(x,y,1))
				.add(new Velocity())
				.add(new Display(new GhostView(assetMan),DisplayDepths.GHOST));
			
			engine.addEntity( e );			
			return e;
		}
		
		public function createBackground():Entity
		{
			var e : Entity = new Entity();
			e.add( new Background() );
			e.add( new Position(0,0,0.5) );
			e.add( new Display(null,DisplayDepths.BACKGROUND));
			engine.addEntity( e );
			return e;
		}
		
		public function createCamera() : Entity
		{
			var e : Entity = new Entity();
			e.add( new Camera() );
			e.add( new Position(-config.cameraTrailingGhostDistance,0) );
			engine.addEntity( e );
			return e;
		}
		
		public function createTrailParticle(textureName:String, x:Number, y:Number, rotation:Number) : Entity
		{
			var e : Entity = new Entity();
			e.add( new Particle() );
			e.add( new Position(x,y,1) );			
			var i : Image = new Image(assetMan.getTexture(textureName));
			i.pivotX = i.width/2;
			i.pivotY = i.height/2;
			var d : Display = new Display(i,DisplayDepths.TRAIL);
			d.container.rotation = rotation;
			e.add( d );
			engine.addEntity( e );
			return e;
		}		
	}
}
