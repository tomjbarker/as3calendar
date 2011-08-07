package net.comcast.CIMCalendar
{
	public class CalendarButtonEnum
	{
		public static const BACK:CalendarButtonEnum = new CalendarButtonEnum("back");
   		public static const FORWARD:CalendarButtonEnum = new CalendarButtonEnum("forward");
    	private var _name:String;
 
		public static function CalendarButtonEnum(val:String):String
		{
			switch(val){
				case "back":
				return "<";
				break;
				case "forward":
				return ">";
				break;
			}
		}
	}
}