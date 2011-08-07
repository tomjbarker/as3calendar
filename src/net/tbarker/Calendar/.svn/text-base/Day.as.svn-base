package net.tbarker.Calendar
{
	
	
	import fl.transitions.Tween;
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;

	public class Day extends Sprite implements ICalendarItem
	{
		private var _name:String;
		private var _myDate:Date;
		private var _events:Array;
		private var _dayNumber:Number;
		private var _display:TextField
		private var _stackIndex:Number
		private var _isActive:Boolean = false;
		private var _restingX:Number;
		private var _restingY:Number;
		
		public var activateTweenH:Tween;
		public var activateTweenW:Tween;
		public var activateTweenT:Tween;
		public var activateTweenL:Tween;
		
		public function Day()
		{
			super();
			_display = new TextField()
			_display.height=20
			_display.width=20
			addChild(_display)
		}
		
		public function drawDay(bgColor:uint, borderSize:uint, borderColor:uint, dayWidth:Number, dayHeight:Number):void
		{
			graphics.beginFill(bgColor);
            graphics.lineStyle(borderSize, borderColor,50);
            graphics.drawRect(0, 0, dayWidth, dayHeight);
            graphics.endFill();
            var filter:DropShadowFilter = new DropShadowFilter();
            this.filters = [filter]         
		}
		
		public function get isActive():Boolean
		{
			return _isActive
		}
		
		public function set isActive(value:Boolean):void
		{
			_isActive = value
		}
		
		public function get originalStackIndex():Number
		{
			return _stackIndex;
		}
		
		public function set originalStackIndex(value:Number):void
		{
			_stackIndex = value;
		}
		
		public function getName():String
		{
			return _name;
		}
		
		public function getDayNumber():Number
		{
			return _dayNumber;
		}
		
		public function get restingX():Number
		{
			return _restingX;
		}
		
		public function get restingY():Number
		{
			return _restingY;
		}
		
		public function getDate():Date
		{
			return _myDate;
		}
		
		public function setDayNumber(dnum:Number):void
		{
			_dayNumber = dnum;
		}
		
		public function setName(name:String):void
		{
			_name = name
		}
		
		public function setDate(date:Date):void
		{
			_myDate = date
		}
		
		public function addDayEvent(eventItem:Object):void
		{
		}
		
		public function setDisplay(txt:String):void
		{
			_display.text = txt;
		}
		
		public function set restingX(n:Number):void
		{
			 _restingX = n;
		}
		
		public function set restingY(n:Number):void
		{
			 _restingY = n;
		}
		
		public function deactivate():void
		{}
		
	}
}