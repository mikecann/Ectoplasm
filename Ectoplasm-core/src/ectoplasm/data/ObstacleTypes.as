package ectoplasm.data
{
	import ectoplasm.utils.math.Rand;

	public class ObstacleTypes
	{
		public static const BASIC_CEILING_1 : ObstacleTypeVO = new ObstacleTypeVO("basic_ceiling_tile");
		public static const BASIC_CEILING_2 : ObstacleTypeVO = new ObstacleTypeVO("basic_ceiling_tile2");
		public static const BASIC_CEILING_3 : ObstacleTypeVO = new ObstacleTypeVO("basic_ceiling_tile3");
		public static const BASIC_CEILING_4 : ObstacleTypeVO = new ObstacleTypeVO("basic_ceiling_tile4");
		
		public static const BASIC_FLOOR_1 : ObstacleTypeVO = new ObstacleTypeVO("basic_floor_tile");
		public static const BASIC_FLOOR_2 : ObstacleTypeVO = new ObstacleTypeVO("basic_floor_tile2");
		public static const BASIC_FLOOR_3 : ObstacleTypeVO = new ObstacleTypeVO("basic_floor_tile3");
		public static const BASIC_FLOOR_4 : ObstacleTypeVO = new ObstacleTypeVO("basic_floor_tile4");
		
		public static const OBSTACLE_CEILING_1 : ObstacleTypeVO = new ObstacleTypeVO("obstacle_ceiling_tile1");
		public static const OBSTACLE_CEILING_2 : ObstacleTypeVO = new ObstacleTypeVO("obstacle_ceiling_tile2");
		public static const OBSTACLE_CEILING_3 : ObstacleTypeVO = new ObstacleTypeVO("obstacle_ceiling_tile3");
		public static const OBSTACLE_CEILING_4 : ObstacleTypeVO = new ObstacleTypeVO("obstacle_ceiling_tile4");				
		
		public static const OBSTACLE_FLOOR_1 : ObstacleTypeVO = new ObstacleTypeVO("obstacle_floor_tile1");
		public static const OBSTACLE_FLOOR_2 : ObstacleTypeVO = new ObstacleTypeVO("obstacle_floor_tile2");
		public static const OBSTACLE_FLOOR_3 : ObstacleTypeVO = new ObstacleTypeVO("obstacle_floor_tile3");
		public static const OBSTACLE_FLOOR_4 : ObstacleTypeVO = new ObstacleTypeVO("obstacle_floor_tile4");
				
		public static var ceilings : Vector.<ObstacleTypeVO> = Vector.<ObstacleTypeVO>([OBSTACLE_CEILING_1,OBSTACLE_CEILING_2,OBSTACLE_CEILING_3,OBSTACLE_CEILING_4]);
		public static var basic_ceilings : Vector.<ObstacleTypeVO> = Vector.<ObstacleTypeVO>([BASIC_CEILING_1,BASIC_CEILING_2,BASIC_CEILING_3,BASIC_CEILING_4]);
		public static var basic_floors : Vector.<ObstacleTypeVO> = Vector.<ObstacleTypeVO>([BASIC_FLOOR_1,BASIC_FLOOR_2,BASIC_FLOOR_3,BASIC_FLOOR_4]);
		public static var floors : Vector.<ObstacleTypeVO> = Vector.<ObstacleTypeVO>([OBSTACLE_FLOOR_1,OBSTACLE_FLOOR_2,OBSTACLE_FLOOR_3,OBSTACLE_FLOOR_4]);
				
		public static function getRandomCeiling():ObstacleTypeVO
		{
			return ceilings[Rand.integer(0,ceilings.length)];
		}
		
		public static function getRandomFloor():ObstacleTypeVO
		{
			return floors[Rand.integer(0,floors.length)];
		}
		
		public static function getRandomBasicCeiling():ObstacleTypeVO
		{
			return basic_ceilings[Rand.integer(0,basic_ceilings.length)];
		}
		
		public static function getRandomBasicFloor():ObstacleTypeVO
		{
			return basic_floors[Rand.integer(0,basic_floors.length)];
		}
		
		public static function isObstacle(lastOtherType:ObstacleTypeVO):Boolean
		{
			return ceilings.indexOf(lastOtherType)!=-1 || floors.indexOf(lastOtherType)!=-1;
		}
	}
}