package ectoplasm.data
{
	import ectoplasm.utils.math.Rand;

	public class ObstacleTypes
	{
		public static var _ceilings : Vector.<ObstacleTypeVO> ;
		public static function get ceilings() : Vector.<ObstacleTypeVO> 
		{
			return _ceilings ||= genList(1,10,"obstacle_ceiling_tile");
		}
		
		public static var _floors : Vector.<ObstacleTypeVO> ;
		public static function get floors() : Vector.<ObstacleTypeVO> 
		{
			return _floors ||= genList(1,9,"obstacle_floor_tile");
		}
		
		public static var _basic_ceilings : Vector.<ObstacleTypeVO> ;
		public static function get basic_ceilings() : Vector.<ObstacleTypeVO> 
		{
			return _basic_ceilings ||= genList(1,9,"basic_ceiling_tile");
		}
		
		public static var _basic_floors : Vector.<ObstacleTypeVO> ;
		public static function get basic_floors() : Vector.<ObstacleTypeVO> 
		{
			return _basic_floors ||= genList(1,9,"basic_floor_tile");
		}
		
		private static function genList(fromI:int,toI:int,prefix:String) : Vector.<ObstacleTypeVO>
		{
			var v : Vector.<ObstacleTypeVO> = new Vector.<ObstacleTypeVO>();
			for (var i:int=fromI; i<toI; i++) v.push(new ObstacleTypeVO(prefix+i));
			return v;
		}
		
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