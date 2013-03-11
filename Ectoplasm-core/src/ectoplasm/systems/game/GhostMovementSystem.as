package ectoplasm.systems.game
{
	import ash.core.Engine;
	import ash.tools.ListIteratingSystem;
	
	import ectoplasm.common.GameConfig;
	import ectoplasm.nodes.game.GhostMovementNode;
	import ectoplasm.nodes.states.PlayingGameNode;
	import ectoplasm.utils.math.NumberUtils;
	import ectoplasm.views.GhostView;
	
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
			var progressModifier : Number = NumberUtils.clamp(1,10,ghost.velocity.velocity.x/400);		
			ghost.velocity.velocity.y -= playing.game.inputForce * 600 * progressModifier * time
			ghost.velocity.velocity.y += time * playing.state.gravity * 50 * progressModifier/2;		
			ghost.velocity.velocity.y = NumberUtils.clamp(-300,200,ghost.velocity.velocity.y);
			
			// Update the position
			ghost.position.position.x += ghost.velocity.velocity.x * time;
			ghost.position.position.y += ghost.velocity.velocity.y * time;
						
			// Lock the player to a certain area
			var gv : GhostView = ghost.display.container.getChildAt(0) as GhostView;
			var min : Number = 40;
			var max : Number = config.height-gv.ghostHeight;
			if(ghost.position.position.y < min) 
			{
				ghost.velocity.velocity.y = 0;
				ghost.position.position.y = min;
			}
			if(ghost.position.position.y > max) 
			{
				ghost.velocity.velocity.y = 0;
				ghost.position.position.y = max;
			}
		}
	}
}