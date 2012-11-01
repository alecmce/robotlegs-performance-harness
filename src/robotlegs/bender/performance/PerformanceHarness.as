//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.performance
{
	import flash.display.Sprite;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import robotlegs.bender.extensions.eventCommandMap.EventCommandMapPerformanceSuite;

	[SWF(width="800", height="600", frameRate="30")]
	public class PerformanceHarness extends Sprite
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const outTF:TextField = new TextField();

		private const runner:SuiteRunner = new SuiteRunner();

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function PerformanceHarness()
		{
			addChild(outTF);
			outTF.width = 800;
			outTF.height = 600;
			outTF.text = "Running tests on " + Capabilities.version + " "
				+ (Capabilities.isDebugger ? "DEBUG" : "RELEASE") + "...\n";

			runner.delay(1000)
				.output(out)
				.queue(new EventCommandMapPerformanceSuite())
				.queue(new EventCommandMapPerformanceSuite())
				.queue(new EventCommandMapPerformanceSuite())
				.run();
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function out(str:String):void
		{
			outTF.appendText(str);
		}
	}
}
