//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.performance
{

	public class Results
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		public const testTimes:Array = [];

		public var tareTime:int;

		public var name:String;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function Results(name:String)
		{
			this.name = name;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function toString():String
		{
			return name + " " + testTimes.join(', ');
		}
	}
}
