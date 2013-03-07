package ectoplasm.systems.game
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	
	import ectoplasm.common.EntityCreator;
	import ectoplasm.nodes.game.CameraNode;
	import ectoplasm.nodes.game.GhostMovementNode;
	import ectoplasm.nodes.game.ParticleNode;
	import ectoplasm.utils.math.Rand;
	
	public class ParticleTrailSystem extends System
	{
		[Inject] public var creator : EntityCreator;
		[Inject] public var engine : Engine;
		
		private var particles : NodeList;
		
		private var timeSinceLastParticle : Number;
		private var numParticlesRemainingAtThisSize : int;
		private var currentTextureSize : String;
		
		override public function addToEngine( engine : Engine ) : void
		{
			particles = engine.getNodeList( ParticleNode ) ;	
			timeSinceLastParticle = 0;
			numParticlesRemainingAtThisSize = 0;
			currentTextureSize = "small"
		}
		
		override public function update( time : Number ) : void
		{
			// Need these two to work
			var ghost : GhostMovementNode = engine.getNodeList( GhostMovementNode ).head;
			var cam : CameraNode = engine.getNodeList( CameraNode ).head;
			if(!ghost || !cam) return;
			
			// Create a new particle every now and then, depending on on the velocity of the ghost
			// the faster it is going the more particles that need to be spawned
			if(timeSinceLastParticle>=20/ghost.velocity.velocity.length)
			{
				var rot : Number = Math.atan2(ghost.velocity.velocity.y,ghost.velocity.velocity.x);				
				var tex : String = currentTextureSize+"_o";
				
				creator.createTrailParticle(tex,ghost.position.position.x, ghost.position.position.y+ghost.display.container.height-50, rot);
				timeSinceLastParticle = 0;
				
				// Every now and then randomly change the size of the particle
				// to create a pleasing OOOOoooOOOOoooOOO effect
				if(--numParticlesRemainingAtThisSize<0)
				{
					numParticlesRemainingAtThisSize = Rand.integer(4,8);
					currentTextureSize = Rand.boolean()?"small":"large";
				}				
			}
			
			timeSinceLastParticle+= time;		
			
			// Loop through all the particles and destroy any off screen and 
			// fade out the others
			for( var node : ParticleNode = particles.head; node; node = node.next )
			{
				node.particle.age += time;
				if (node.position.position.x-cam.position.position.x<-100 || node.particle.age>10) 
					creator.destroyEntity(node.entity);
				
				node.display.container.alpha = 1-(node.particle.age/10);
			}
		}
	}
}