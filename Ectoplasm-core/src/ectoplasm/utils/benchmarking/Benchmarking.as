package ectoplasm.utils.benchmarking
{
	import flash.utils.getTimer;

	public class Benchmarking
	{
		public static function run(testName:String, method:Function, iterations:int=10) : void
		{
			trace();
			trace("--------------------------");
			trace("Running benchmark: '"+testName+"' "+iterations+" times");
			trace("--------------------------");
			
			var results : Array = [];
			
			for (var i:int=0; i<iterations; i++)
			{
				var b : int = getTimer();
				method();
				results.push(getTimer()-b);
			}
			
			var total : int = 0;
			for (var k:int=0; k<results.length; k++){ total += results[k]; trace("Run["+k+"] = "+results[k]+"ms"); }
			
			trace("--------------------------");
			trace("Total: "+(total/iterations)+"ms");
			trace("--------------------------");
			
		}
	}
}