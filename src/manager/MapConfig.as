package manager
{
	public class MapConfig
	{
		/**
		 * 地图宽度 
		 */		
		public static var mapWidth:Number;
		/**
		 * 地图高度 
		 */		
		public static var mapHeight:Number;
		/**
		 * 格子宽度 
		 */		
		public static var tileWidth:Number;
		/**
		 * 格子高度 
		 */		
		public static var tileHeight:Number;
		/**
		 * 可行走的格子的颜色 
		 */		
		public static var wakableColor:uint = 0x00ff00;
		/**
		 * 布尔科行走的 格子的颜色
		 */		
		public static var unwalkableColor:uint = 0xff0000;
		/**
		 * 格子的透明度 
		 */		
		public static var tileAlpha:Number = 0.8;
		/**
		 * 背景图片地址 
		 */		
		public static var bgAdd:String = "";
		public static function initConfig(xml:XML):void
		{
			if(xml)
			{
				MapConfig.mapHeight = Number(xml.@width);
				MapConfig.mapWidth = Number(xml.@height);
				MapConfig.tileWidth = Number(xml.@tileWidth);
				MapConfig.tileHeight = Number(xml.@tileHeight);
				
				PanelManager.mapContainer.mapConfig = xml;
//				PanelManager.mapContainer.initMapBack(xml);
			}
			
		}
	}
}