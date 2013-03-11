package ectoplasm.systems.game
{
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.core.Node;
	import ash.core.NodeList;
	import ash.core.System;
	
	import ectoplasm.common.EntityCreator;
	import ectoplasm.common.GameConfig;
	import ectoplasm.components.game.Display;
	import ectoplasm.components.game.Position;
	import ectoplasm.data.ObstacleTypeVO;
	import ectoplasm.data.ObstacleTypes;
	import ectoplasm.nodes.game.CameraNode;
	import ectoplasm.nodes.game.ObstacleNode;
	import ectoplasm.nodes.states.PlayingGameNode;
	import ectoplasm.utils.math.Rand;
	
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class ObstacleSystem extends System
	{
		[Inject] public var config : GameConfig;
		[Inject] public var creator : EntityCreator;
		[Inject] public var assets : AssetManager;
		[Inject] public var engine : Engine;
		
		private var obstacles : NodeList;
		
		override public function addToEngine( engine : Engine ) : void
		{
			obstacles = engine.getNodeList( ObstacleNode );
		}
		
		override public function update( time : Number ) : void
		{		
			// Cant do anything without a camera
			var cam : CameraNode = engine.getNodeList(CameraNode).head;
			if(!cam) return;
			
			// Potentially we arent acually in game mode and instead are in menus
			var playing : PlayingGameNode = engine.getNodeList(PlayingGameNode).head;
			var waveVal : Number = 0;
			if(playing)
			{
				playing.state.obstacleWaveValue += time + (Math.random()/100);
				waveVal = playing.state.obstacleWaveValue;
			}			
			
			var lastNorth : ObstacleNode = obstacles.head;
			var lastNorthX : Number = 0;
			var lastSouth : ObstacleNode = obstacles.head;
			var lastSouthX : Number = 0;
			
			// Fist loop through and destroy any that are off screen, at the same time
			// find the rightmost north and south obstacles			
			for( var node : ObstacleNode = obstacles.head; node; node = node.next )
			{
				var x : int = node.position.position.x + node.display.container.width;
				if(node.obstacle.isNorth && x>lastNorthX) lastNorth = node;
				else if (!node.obstacle.isNorth && x>lastSouthX) lastSouth = node;
				
				// If this obstacle is now off screen then blast it
				if(x-cam.position.position.x<0) creator.destroyEntity(node.entity);		
			}		
			
			updateObstacles(lastNorth,true,waveVal,cam);
			updateObstacles(lastSouth,false,waveVal,cam);												
		}
		
		private function updateObstacles(node:ObstacleNode, isNorth:Boolean, obstacleWaveValue:Number, cam:CameraNode) : void
		{
			var x : int = -config.width;
			if(node) x = node.position.position.x + node.display.container.width - Rand.integer(3,5);
			
			while(x-cam.position.position.x<config.width)
			{
				var e : Entity = createNewObstacle(x,isNorth,obstacleWaveValue);
				x += Display(e.get(Display)).container.width;
			}			
		}
		
		private function createNewObstacle(xPos:Number, isNorth:Boolean, obstacleWaveValue:Number) : Entity
		{			
			var basicType : ObstacleTypeVO = isNorth?ObstacleTypes.getRandomBasicCeiling():ObstacleTypes.getRandomBasicFloor();
			var randomObstacleType : ObstacleTypeVO = isNorth?ObstacleTypes.getRandomCeiling():ObstacleTypes.getRandomFloor();
			
			var x : int = xPos;
			var y : int = 0;
						
			// Default the new obs to be of the basic type
			var type : ObstacleTypeVO = basicType;
			
			// But if we are a certain distance through the game
			// then we can start to introduce some harder obstacles
			if(x>config.width)
			{
				//var lastOther : Obstacle = otherObs[otherObs.length-1].get(Obstacle);
				//var otherIsObs : Boolean = ObstacleTypes.isObstacle(lastOther.type);
				//if(!otherIsObs) type = Rand.boolean()?basicType:randomObstacleType;
				type = Rand.random()>0.3?basicType:randomObstacleType;
			}
						
			var tex : Texture = assets.getTexture(type.name);
			var waveOffset:Number = Math.sin(obstacleWaveValue/5);
			var wiggleRoom : Number = 20;
			
			if(isNorth)
			{				
				y = -wiggleRoom+waveOffset*wiggleRoom;
			}
			else
			{
				waveOffset = 1-waveOffset;
				y = config.height-tex.frame.height + (wiggleRoom*2) - waveOffset*wiggleRoom;
			}
							
			return creator.createObstacle(type,isNorth,x-1,y);
		}
	}
}