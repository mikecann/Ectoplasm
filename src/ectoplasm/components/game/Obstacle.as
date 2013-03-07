package ectoplasm.components.game
{
	import ectoplasm.data.ObstacleTypeVO;

	public class Obstacle
	{
		public var type:ObstacleTypeVO;
		public var isNorth : Boolean;
		
		public function Obstacle(type:ObstacleTypeVO, isNorth:Boolean)
		{
			this.type = type;
			this.isNorth = isNorth;
		}
	}
}