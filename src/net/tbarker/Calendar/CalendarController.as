package net.comcast.CIMCalendar
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	
	
	public class CalendarController extends Sprite
	{
		private var _cal:CIMAbstractCalendar;
		private var _currDay:Day;
		private var _emptyDay:Day;
		private var _currMonth:Number
		private var _hf:HeadendFactory
		private var _yOffset:Number=0;


		public function CalendarController(){}
		
		public function getMonth(month:Number):void
		{
			_cal = new CIMAbstractCalendar(month)
			addChild(_cal)
			_cal.drawMonth(_currMonth,_currDay,_emptyDay)
		}
		
		private function drawNavigation():void
		{
			//TODO draw back and forward buttons to scroll through months
		}
		
		public function set ZipCode(zip:Number):void
		{
			_hf = new HeadendFactory()
			_hf.loadHeadEnds(zip);
			_hf.addEventListener(TVPlannerEvent.HEADENDS_LOADED, displayHeadends);
		}
		
		private function displayHeadends(event:Event):void
		{
			var tempTxt:TextField 
			for each(var he:Headend in _hf.getHeadEnds()){
				tempTxt = new TextField()
				tempTxt.width = 300
				tempTxt.text = he.headend_title
				tempTxt.y=_yOffset
				_yOffset+= 20
				addChild(tempTxt);
			}
		}

	}
}