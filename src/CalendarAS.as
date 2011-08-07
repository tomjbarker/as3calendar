package {
	import flash.display.Sprite;
	
	import net.tbarker.Calendar.*;

	public class CalendarAS extends Sprite
	{
		public function CalendarAS()
		{
			
			var t:AbstractCalendar = new AbstractCalendar()
			var tempDay:Day = new Day();
			var backDay:Day = new Day();
			addChild(t)
			t.drawMonth(2,tempDay,backDay)
		//	t.drawWeek(2,12,tempDay,backDay);
			
		/*	var ct:CalendarController = new CalendarController()
			addChild(ct);
			ct.ZipCode = 18914
			
		*/	
		}
	}
}
