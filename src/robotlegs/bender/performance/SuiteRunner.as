//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.performance
{
	import flash.utils.getTimer;
	import flash.utils.setTimeout;

	public class SuiteRunner
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const _tests:Array = [];

		private var _running:Boolean;

		private var _position:uint;

		private var _delay:Number = 500;

		private var _outputFunction:Function = tracer;

		private var _start:int;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function SuiteRunner()
		{
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function delay(time:Number):SuiteRunner
		{
			_delay = time;
			return this;
		}

		public function queue(test:PerformanceTest):SuiteRunner
		{
			const settings:TestRunner = new TestRunner();
			_tests.push(settings);
			test.configureTest(settings);
			return this;
		}

		public function run():SuiteRunner
		{
			if (!_running && _tests.length > 0)
			{
				_running = true;
				_position = 0;
				_start = getTimer();
				setTimeout(runNext, _delay);
			}
			return this;
		}

		public function output(func:Function):SuiteRunner
		{
			_outputFunction = func;
			return this;
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function runNext():void
		{
			const runner:TestRunner = _tests[_position];
			runner.run(testComplete);
		}

		private function testComplete(results:Results):void
		{
			print(results);
			_position++;
			if (_position < _tests.length)
			{
				print("Waiting for " + _delay);
				setTimeout(runNext, _delay);
			}
			else
			{
				afterSuite();
			}
		}

		private function afterSuite():void
		{
			_running = false;
			_position = 0;
			const time:int = getTimer() - _start;
			print("Done in " + time);
		}

		private function print(str:*):void
		{
			_outputFunction(str + "\n");
		}

		private static function tracer(str:String):void
		{
			trace(str);
		}
	}
}
