//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.eventCommandMap.support
{
	import flash.events.Event;

	public class SupportEvent extends Event
	{

		/*============================================================================*/
		/* Public Static Properties                                                   */
		/*============================================================================*/

		public static const TYPE1:String = "type1";
		public static const TYPE2:String = "type2";

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function SupportEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		override public function clone():Event
		{
			return new SupportEvent(type, bubbles, cancelable);
		}
	}
}
