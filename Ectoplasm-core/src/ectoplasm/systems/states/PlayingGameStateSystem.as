package ectoplasm.systems.states
{
	import ash.core.Engine;
	import ash.tools.ListIteratingSystem;
	
	import ectoplasm.common.EntityCreator;
	import ectoplasm.common.GameConfig;
	import ectoplasm.common.GameStates;
	import ectoplasm.common.Highscores;
	import ectoplasm.components.game.Collideable;
	import ectoplasm.components.game.Controllable;
	import ectoplasm.components.game.DeathThroes;
	import ectoplasm.components.game.Display;
	import ectoplasm.nodes.game.GameNode;
	import ectoplasm.nodes.game.GhostNode;
	import ectoplasm.nodes.game.MicrophoneNode;
	import ectoplasm.nodes.states.PlayingGameNode;
	import ectoplasm.views.GhostDeathView;
	
	import org.swiftsuspenders.Injector;
	
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	public class PlayingGameStateSystem extends ListIteratingSystem
	{
		[Inject] public var creator : EntityCreator;
		[Inject] public var injector : Injector;
		[Inject] public var config : GameConfig;
		[Inject] public var engine : Engine;
		[Inject] public var scores : Highscores;
		[Inject] public var assets : AssetManager;
		
		private var container : Sprite;
				
		public function PlayingGameStateSystem(container:Sprite)
		{
			this.container = container;
			super(PlayingGameNode,onUpdate,onNodeAdded, onNodeRemoved);
		}		
		
		private function  onNodeAdded(node:PlayingGameNode) : void
		{
			node.state.reset();
			container.addChild(node.state.view);
		}
		
		private function  onNodeRemoved(node:PlayingGameNode) : void
		{
			container.removeChild(node.state.view);
		}
		
		private function onUpdate(node:PlayingGameNode, time:Number) : void
		{		
			// Grab some nodes we need			
			var game : GameNode = engine.getNodeList(GameNode).head;
			var ghost : GhostNode = engine.getNodeList(GhostNode).head;
			var mic : MicrophoneNode = engine.getNodeList(MicrophoneNode).head;
						
			// Difficulty just a function of time				
			node.state.difficulty += time * 10;
			if(mic) game.game.inputForce = mic.mic.activityLevel;
			else game.game.inputForce = 0;
			
			// Score is a function of the difficulty
			game.game.score = node.state.difficulty*10;
			
			// Update the view
			node.state.view.updateScores(game.game.score,scores.highscore);
			
			// No more lifes, game over sukka
			if(node.state.lives==0)
			{
				if(ghost.entity.has(Controllable))
				{
					ghost.entity.remove(Controllable);
					ghost.entity.remove(Collideable);
					ghost.entity.add(new DeathThroes(1));
					
					// Swap out the visuals for the ghost
					var display : Display = ghost.entity.get(Display);
					display.container.alpha = 1;
					display.container.removeChildAt(0);					
					display.container.addChild(new GhostDeathView(assets,0.5));
					
					scores.highscore = Math.max(scores.highscore,game.game.score);
					if(game.game.score==scores.highscore) scores.save();
				}
				else  if (ghost.entity.has(DeathThroes))
				{
					var dt : DeathThroes = ghost.entity.get(DeathThroes);
					dt.timeRemaining-=time;
					if(dt.timeRemaining<=0) ghost.entity.remove(DeathThroes);
				}
				else
				{
					creator.destroyEntity(ghost.entity);
					game.game.states.changeState(GameStates.POST_GAME);	
				}
			}
		}
	}
}