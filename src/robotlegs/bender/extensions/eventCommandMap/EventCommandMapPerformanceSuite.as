//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.eventCommandMap
{
	import flash.events.EventDispatcher;
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.extensions.commandCenter.impl.CommandCenter;
	import robotlegs.bender.extensions.eventCommandMap.impl.EventCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.support.EmptyCommand;
	import robotlegs.bender.extensions.eventCommandMap.support.EmptyCommand2;
	import robotlegs.bender.extensions.eventCommandMap.support.SupportEvent;
	import robotlegs.bender.performance.PerformanceTest;
	import robotlegs.bender.performance.TestRunner;

	public class EventCommandMapPerformanceSuite implements PerformanceTest
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const loops:uint = 1000;

		private const iterations:uint = 5;

		private var injector:Injector;

		private var dispatcher:EventDispatcher;

		private var eventCommandMap:EventCommandMap;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function EventCommandMapPerformanceSuite()
		{
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function configureTest(runner:TestRunner):void
		{
			runner.named("Empty command performance. Loops " + loops)
				.iterations(iterations)
				.loops(loops)
				.before(before)
				.tare(tare)
				.test(test);
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function before():void
		{
			injector = new Injector();
			dispatcher = new EventDispatcher();
			eventCommandMap = new EventCommandMap(injector, dispatcher, new CommandCenter());
			eventCommandMap.map(SupportEvent.TYPE1).toCommand(EmptyCommand);
			eventCommandMap.map(SupportEvent.TYPE1).toCommand(EmptyCommand2);
		}

		private function tare():void
		{
			for (var i:uint = 0; i < loops; i++)
			{
				// we don't want to actually trigger the commands
				// we just want to discard the amount of time
				// it takes to construct and dispatch events
				dispatcher.dispatchEvent(new SupportEvent(SupportEvent.TYPE2));
			}
		}

		private function test():void
		{
			for (var i:uint = 0; i < loops; i++)
			{
				dispatcher.dispatchEvent(new SupportEvent(SupportEvent.TYPE1));
			}
		}
	}
}
