package ectoplasm.common
{
	public class SystemPriorities
	{
		public static const PRE_UPDATE : int = 0;	
		public static const MIC_INPUT : int = 50;		
		public static const TOUCH_INPUT : int = 60;		
		public static const UPDATE : int = 100;		
		public static const POST_UPDATE : int = 150;		
		public static const RESOLVE_COLLISIONS : int = 200;
		public static const UPDATE_CAMERA : int = 300;
		public static const RENDER : int = 400;		
	}
}
