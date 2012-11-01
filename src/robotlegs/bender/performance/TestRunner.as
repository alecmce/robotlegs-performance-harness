//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.performance
{
	import flash.system.System;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;

	public class TestRunner
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _before:Function = nop;

		private var _after:Function = nop;

		private var _tare:Function = nop;

		private var _test:Function = nop;

		private var _name:String = "Test";

		private var _iterations:uint = 1;

		private var _loops:uint = 1;

		private var _running:Boolean;

		private var _results:Results;

		private var _callback:Function;

		private var _iterationCount:int;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function TestRunner()
		{
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function before(func:Function):TestRunner
		{
			_before = func;
			return this;
		}

		public function after(func:Function):TestRunner
		{
			_after = func;
			return this;
		}

		public function tare(func:Function):TestRunner
		{
			_tare = func;
			return this;
		}

		public function test(func:Function):TestRunner
		{
			_test = func;
			return this;
		}

		public function named(name:String):TestRunner
		{
			_name = name;
			return this;
		}

		public function iterations(i:uint):TestRunner
		{
			_iterations = i;
			return this;
		}

		public function loops(i:uint):TestRunner
		{
			_loops = i;
			return this;
		}

		public function run(callback:Function):void
		{
			if (_running)
				throw(new Error("TestRunner is already running"));

			_running = true;
			_callback = callback;
			_results = new Results(_name);
			_iterationCount = 0;
			start();
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function start():void
		{
			_before();
			System.gc();
			setTimeout(processTare, 100);
		}

		private function processTare():void
		{
			const beforeTare:int = getTimer();
			_tare();
			_results.tareTime = getTimer() - beforeTare;
			System.gc();
			setTimeout(runNextTest, 100);
		}

		private function runNextTest():void
		{
			const beforeTest:int = getTimer();
			_test();
			const testTime:int = getTimer() - beforeTest;
			_results.testTimes.push(testTime - _results.tareTime);

			_iterationCount++;
			if (_iterationCount < _iterations)
			{
				System.gc();
				setTimeout(runNextTest, 100);
			}
			else
			{
				_after();
				System.gc();
				_callback(_results);
			}
		}

		private function nop():void
		{
		}
	}
}
