package net.tbarker.Calendar
{
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	
	public class Calendar extends Sprite implements ICalendar 
	{
		private var _currDate:Date;
		private var _currMonth:Number;
		private var _dayList:Array
		private static var _dayIDSequence:Number = 0;
		
		private var _dayHeight:Number = 50;
		private var _dayWidth:Number = 50;
		private var _startX:Number = 10;
		private var _startY:Number = 10;
		
		private const WEEKDAYCOUNT:Number = 7;

		
		private var _bgColor:uint      = 0xCCCCCC;
        private var _borderColor:uint  = 0x666666;
        private var _borderSize:uint   = 1;
        
  		private var _xTween:Tween;
  		private var _yTween:Tween;
        
        
		public function Calendar(month:Number=0)
		{
			_currDate = new Date();
			_currMonth = month
			_dayList = new Array()
		}

		public function update():void
		{
		}
		
		public function currentDate():Date
		{
			return _currDate
		}
			
		private function drawDay(tempShape:Day, width:Number = 0, height:Number = 0):Day
		{ 
         	tempShape.drawDay(_bgColor, _borderSize,_borderColor, _dayWidth, _dayHeight);
         	tempShape.buttonMode = true
			tempShape.addEventListener(Event.ADDED_TO_STAGE, doEffect);           
			tempShape.addEventListener(MouseEvent.CLICK, activateDay);            
			return tempShape
		}
		
		
		private function doEffect(event:Event):void
		{	
			event.currentTarget.activateTweenH = new Tween(event.target,"height", Elastic.easeOut, 1, 50, 2,true);
			event.currentTarget.activateTweenW = new Tween(event.target,"width", Elastic.easeOut, 1, 50, 2,true);
		}
		
		private function activateDay(event:Event):void
		{
			if(event.currentTarget.isActive==false)
			{
				
				deactivateAllDays()	
				event.currentTarget.isActive = true
				//event.currentTarget.x -= 10
				//event.currentTarget.y -= 10
				
				event.currentTarget.activateTweenT = new Tween(event.currentTarget,"x", Elastic.easeOut, event.currentTarget.x, event.currentTarget.x - 10, 1,true);
				event.currentTarget.activateTweenL = new Tween(event.currentTarget,"y", Elastic.easeOut, event.currentTarget.y, event.currentTarget.y - 10, 1,true);
				event.currentTarget.activateTweenH = new Tween(event.currentTarget,"height", Elastic.easeOut, event.currentTarget.height, 80, 1,true);
				event.currentTarget.activateTweenW = new Tween(event.currentTarget,"width", Elastic.easeOut, event.currentTarget.width, 80, 1,true);
				var newInd:Number
				(this.getChildIndex(event.currentTarget as Day) < this.numChildren-1)?newInd=this.getChildIndex(event.currentTarget as Day) + 1:newInd=this.numChildren -1
				this.setChildIndex(event.currentTarget as Day, newInd)
			}	
		}
		
		private function deactivateAllDays():void
		{
			var tempDay:Day
			for(var x:Number = _dayList.length-1;x>=0;x--)
			{
				tempDay = this.getChildByName(_dayList[x]) as Day
				if(tempDay.isActive == true){
					tempDay.x += 10;
					tempDay.y += 10;
				}
				tempDay.isActive = false
				tempDay.deactivate()
				if(tempDay.activateTweenH)
					tempDay.activateTweenH.fforward()
				if(tempDay.activateTweenL)
					tempDay.activateTweenL.fforward()
				if(tempDay.activateTweenT)
					tempDay.activateTweenT.fforward()
				if(tempDay.activateTweenW)
					tempDay.activateTweenW.fforward()
				tempDay.activateTweenW = new Tween(tempDay,"width", Elastic.easeIn, tempDay.height, 50, 2);
				tempDay.activateTweenH = new Tween(tempDay,"height", Elastic.easeIn, tempDay.height, 50, 2);
				tempDay.activateTweenL = new Tween(tempDay,"x",Elastic.easeIn, tempDay.x, tempDay.restingX,2);
				tempDay.activateTweenT = new Tween(tempDay,"y",Elastic.easeIn, tempDay.y, tempDay.restingY,2);
				tempDay.activateTweenH.addEventListener(TweenEvent.MOTION_FINISH, recessDay)
				var y:Number;
			}
		}
		
		
		private function recessDay(event:TweenEvent):void
		{
			if(event.currentTarget.obj.isActive == false){
				this.setChildIndex(event.currentTarget.obj,0)
			}			
		}
		private function createDay(currDay:Day, today:Date,name:String, display:String, dayNum:Number):Day
		{
			var tempDay:Day
			
			tempDay = new Day()
			tempDay.name = getNewDayID();
			tempDay.setDate(today)
			tempDay.setName(name);
			tempDay.setDisplay(display);
			tempDay.setDayNumber(dayNum)
			tempDay = drawDay(tempDay)
			tempDay.originalStackIndex = Number(tempDay.name)
			_dayList[_dayList.length] = tempDay.name
			return tempDay
		}
		
		private function getNewDayID():String
		{
			return (_dayIDSequence++).toString();
		}
		
		
		public function drawWeek(month:Number, day:Number, tempDay:Day, backDay:Day):void
		{
			
			var currDate:Date = new Date(month + "/"+day+"/" + new Date().getFullYear());
			var tempDate:Date = new Date()
			var dayHolder:String;

			//fill begining of week
			for(var x:Number = 0;x<currDate.getDay(); x++)
			{
				//backfill previous days
				dayHolder = (day - ((currDate.getDay())  - x)).toString()
				tempDate = new Date(month + "/"+dayHolder+"/" + new Date().getFullYear())
				if(tempDate.getMonth() + 1 != month){dayHolder = ""}
				backDay = createDay(backDay, tempDate,"",dayHolder,x)
				backDay.restingX = backDay.x = _startX
				backDay.restingY = backDay.y = _startY
				_startX += _dayWidth
				addChild(backDay);
			}

		
			//fill end of week
			for(var y:Number = currDate.getDay(); y<WEEKDAYCOUNT;y++)
					{
						//front fill the next months days
						dayHolder = (day - ((currDate.getDay()) - y)).toString()
						tempDate = new Date(month + "/"+dayHolder+"/" + new Date().getFullYear())
						if(tempDate.getMonth() + 1 != month){dayHolder = ""}
						backDay = createDay(backDay, tempDate,"",dayHolder,y)
						backDay.restingX = backDay.x = _startX
						backDay.restingY = backDay.y = _startY
						_startX += _dayWidth
						addChild(backDay);
					}
		}
		
		
		public function drawMonth(tempMonth:Number,tempDay:Day, backDay:Day):void{
			
			var currentDay:Number = 1
			var dayStepper:Number = 0
			var tempDate:Date = new Date(tempMonth + "/"+currentDay+"/" + new Date().getFullYear());
			var tempMonthChecker:Number = tempDate.getMonth()
			//check for current month  to step through each day in the month
			while(tempDate.getMonth() + 1 == tempMonth){
				
				tempDate = new Date(tempMonth + "/"+currentDay+"/" + new Date().getFullYear());
				tempMonthChecker = tempDate.getMonth()
				trace(tempDate.toString() +" --- "+ currentDay.toString());
				
				// check for day num, at each zero
				// reset startX back to 0
				if(tempDate.getDay() == 0){ _startX = 10}
				
				
				
				//figure out the day number for the first day only
				if(tempDate.getDay() > 0 && currentDay == 1 )
				{
					for(var x:Number = 0;x<tempDate.getDay(); x++)
					{
						//backfill previous days
						backDay = createDay(backDay, tempDate,"","",x)
						backDay.restingX = backDay.x = _startX
						backDay.restingY = backDay.y = _startY
						_startX += _dayWidth
						addChild(backDay);
						dayStepper++
					}
					
					
				}
				
				if(tempDate.getMonth() + 1 == tempMonth){
					tempDay = createDay(tempDay, tempDate, "",currentDay.toString(),tempDate.getDay())
					tempDay.restingX = tempDay.x = _startX
					tempDay.restingY = tempDay.y = _startY
					_startX += _dayWidth
					addChild(tempDay);
					dayStepper++
					
					// increment startY by the _dayHeight
					if(dayStepper % WEEKDAYCOUNT == 0){_startY += _dayHeight}
					
					currentDay++
				}else{
					for(var y:Number = tempDate.getDay(); y<WEEKDAYCOUNT;y++)
					{
						//front fill the next months days
						backDay = createDay(backDay, tempDate,"","",x)
						backDay.restingX = backDay.x = _startX
						backDay.restingY = backDay.y = _startY
						_startX += _dayWidth
						addChild(backDay);
					}
				}
			}
		}
	}
	
}
	