package ectoplasm.systems.game
{
	import ash.core.Engine;
	import ash.tools.ListIteratingSystem;
	
	import ectoplasm.common.GameConfig;
	import ectoplasm.nodes.game.GhostMovementNode;
	import ectoplasm.nodes.states.PlayingGameNode;
	import ectoplasm.utils.math.NumberUtils;
	
	public class GhostMovementSystem extends ListIteratingSystem
	{
		[Inject] public var config : GameConfig;
		[Inject] public var engine : Engine;
		
		public function GhostMovementSystem()
		{
			super(GhostMovementNode, onUpdate);
		}
		
		private function onUpdate(ghost:GhostMovementNode, time : Number ) : void
		{
			var playing : PlayingGameNode = engine.getNodeList(PlayingGameNode).head;
			if(!playing) return;
			
			// The ghosts x velocity is directly dependant on the current difficulty level which is updated
			// in other systems
			ghost.velocity.velocity.x = playing.state.difficulty;
			
			// The strength of the player's input is modified by how fast the player is going. The faster the 
			// player is going in the x-direction the more control is needed in the y-direction
			var progressModifier : Number = NumberUtils.clamp(1,10,ghost.velocity.velocity.x/8000);			
			ghost.velocity.velocity.y -= playing.state.inputForce * 600 * progressModifier * time
			ghost.velocity.velocity.y += time * playing.state.gravity * 50 * progressModifier/2;		
			ghost.velocity.velocity.y = NumberUtils.clamp(-300,200,ghost.velocity.velocity.y);
			
			// Update the position
			ghost.position.position.x += ghost.velocity.velocity.x * time;
			ghost.position.position.y += ghost.velocity.velocity.y * time;
			
			// Lock the player to a certain area
			if(ghost.position.position.y < 0) 
			{
				ghost.velocity.velocity.y = 0;
				ghost.position.position.y = 0;
			}
			if(ghost.position.position.y > config.height-ghost.display.container.height) 
			{
				ghost.velocity.velocity.y = 0;
				ghost.position.position.y = config.height-ghost.display.container.height;
			}
		}
	}
}