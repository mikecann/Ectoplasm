package ectoplasm.components.game
{
	import flash.geom.Point;
	
	import ectoplasm.utils.geom.Pt;

	public class Velocity
	{
		public var velocity : Pt;
		
		public function Velocity( x : Number=0, y : Number=0, z : Number=0 )
		{
			velocity = new Pt( x, y, z );
		}
	}
}