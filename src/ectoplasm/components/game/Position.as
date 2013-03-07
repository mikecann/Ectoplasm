package ectoplasm.components.game
{
	import flash.geom.Point;
	
	import ectoplasm.utils.geom.Pt;

	public class Position
	{
		public var position : Pt;
		
		public function Position( x : Number=0, y : Number=0, z : Number=0 )
		{
			position = new Pt( x, y, z );
		}
	}
}