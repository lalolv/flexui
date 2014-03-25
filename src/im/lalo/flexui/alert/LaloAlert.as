package im.lalo.flexui.alert
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.managers.PopUpManager;

	public class LaloAlert
	{
		private static var alertBox:AlertBox;
		private static var timer:Timer;
		
		public function LaloAlert()
		{
		}
		
		public static function show(parent:DisplayObject, title:String, info:String, 
									closeDuring:Number = 2000, 
									width:Number = 230, height:Number = 100, 
									modal:Boolean = true):void
		{
			if(alertBox == null)
			{
				alertBox = new AlertBox();
				alertBox.addEventListener("CloseEvent", closeHandler);
			}
			
			if(closeDuring > 0)
			{
				if(timer == null)
				{
					timer = new Timer(closeDuring);
				}
				
				timer.addEventListener(TimerEvent.TIMER, timerHandler);
				timer.start();
			}
			
			alertBox.title = title;
			alertBox.info = info;
			alertBox.width = width;
			alertBox.height = height;
			PopUpManager.addPopUp(alertBox, parent, modal);
			PopUpManager.centerPopUp(alertBox);
		}
		
		private static function timerHandler(evt:TimerEvent):void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, timerHandler);
			PopUpManager.removePopUp(alertBox);
		}
		
		private static function closeHandler(evt:Event):void
		{
			close();
		}
		
		/**
		 * 关闭窗体
		 */
		public static function close():void
		{
			if(timer && timer.running)
			{
				timer.stop();
			}
			
			alertBox.removeEventListener(MouseEvent.CLICK, closeHandler);
			PopUpManager.removePopUp(alertBox);
		}
	}
}