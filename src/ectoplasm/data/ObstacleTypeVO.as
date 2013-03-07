package ectoplasm.data
{
	public class ObstacleTypeVO
	{
		private var _name:String;
		private var _shapeData:Array;

		public function ObstacleTypeVO(name:String)
		{
			_shapeData = shapeData;
			_name = name;
		}

		public function get shapeData():Array
		{
			return _shapeData;
		}

		public function get name():String
		{
			return _name;
		}
	}
}