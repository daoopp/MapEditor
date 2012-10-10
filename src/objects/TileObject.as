package objects
{
	public class TileObject
	{
		/**
		 * 所在行 
		 */		
		public var row:int;
		/**
		 * 所在列 
		 */		
		public var col:int;
		/**
		 * x坐标 
		 */		
		public var x:Number;
		/**
		 * y坐标 
		 */		
		public var y:Number;
		/**
		 * 是否可以行走 
		 */		
		public var walkable:Boolean=true;
		/**
		 * 是否半透明（遮挡效果） 
		 */		
		public var showAlpha:Boolean;
		public function TileObject()
		{
		}
		public function toXMLString():XML
		{
			return XML("<tile x='"+x+"' y='"+y+"' row='"+row+"' col='"+col+"' walkable='"+walkable+"' showAlpha='"+showAlpha+"'/>");
		}
	}
}