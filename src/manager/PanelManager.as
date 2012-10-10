package manager
{
	import mx.containers.Canvas;
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	
	import views.EditTile;
	import views.MapContainer;
	import views.NewMap;
	import views.SysTool;

	public class PanelManager
	{
		/**
		 * 全局宽度 
		 */		
		public static var globalWidth:Number;
		/**
		 * 全局高度 
		 */		
		public static var globalHeight:Number;
		/**
		 * 面板的容器 
		 */		
		public static var container:Canvas;
		/**
		 * 文件工具 
		 */		
		public static var sysTool:SysTool;
		/**
		 * 地图容器 
		 */		
		public static var mapContainer:MapContainer;
		private static var _newMap:NewMap;
		private static var _editTile:EditTile;
		public function PanelManager()
		{
		}
		/**
		 * 显示面板 
		 * @param panel
		 * 
		 */		
		public static function showPanel(panel:IVisualElement):void
		{
			container.addElement(panel);
			panel.x = globalWidth - panel.width >> 1;
			panel.y = globalHeight - panel.height >> 1;
		}
		/**
		 * 隐藏面板 
		 * @param panel
		 * 
		 */		
		public static function hidePanel(panel:IVisualElement):void
		{
			if(panel.parent)
			{
				(panel.parent as IVisualElementContainer).removeElement(panel);
			}
		}
		/**
		 * 清空容器 
		 * 
		 */		
		public static function cleanContainer():void
		{
			container.removeAllElements();
		}
		/**
		 * 新建地图面板
		 * @return 
		 * 
		 */		
		public static function get newMap():NewMap
		{
			if(_newMap == null)
			{
				_newMap = new NewMap();
			}
			return _newMap;
		}
		/**
		 * 编辑格子 
		 * @return 
		 * 
		 */		
		public static function get editTile():EditTile
		{
			if(null == _editTile)
			{
				_editTile = new EditTile();
			}
			return _editTile;
		}

	}
}