package manager
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;

	public class ConfigManager
	{
		private var file:File;
		private var fs:FileStream;
		private var filefilter:FileFilter;
		private var tempName:String;
		private var tempData:XML;
		
		private static var _instance:ConfigManager;
		public function ConfigManager()
		{
			filefilter = new FileFilter("Map config","*.dmc");
			file = new File();
			fs = new FileStream();
		}
		/**
		 * 保存 配置
		 * 
		 */		
		public function saveConfig(data:XML):void
		{
			fs.open(file,FileMode.WRITE);
			data.@width = MapConfig.mapWidth;
			data.@height = MapConfig.mapHeight;
			data.@tileWidth = MapConfig.tileWidth;
			data.@tileHeight = MapConfig.tileHeight;
			data.@bgurl = MapConfig.bgAdd;
			try
			{
				fs.writeUTFBytes(data);
			} 
			catch(error:Error) 
			{
				trace("WARNING: Write Map Config<"+file.name+"> failed...");
			}finally
			{
				fs.close();
			}
		}
		/**
		 *  新建配置
		 * 
		 */		
		public function newConfig(fileName:String, fileData:XML):void
		{
			tempName = fileName;
			tempData = fileData;
			file.save(fileData,fileName+".dmc");
			file.addEventListener(Event.COMPLETE, onComplete);
		}
		/**
		 * 打开配置 
		 * 
		 */		
		public function openConfig():void
		{
			file.addEventListener(Event.SELECT, onSelect);
			file.browseForOpen("Open Map  Config...",[filefilter]);
		}
		private function onSelect(e:Event):void
		{
			fs.open(file, FileMode.READ);
			try{
				var str:String = fs.readUTFBytes(fs.bytesAvailable);
				tempData = XML(str);
				if(tempData)
				{
					MapConfig.initConfig(tempData);
				}
			}catch(e:Error)
			{
				trace("WARNING: Read Map Config <"+file.nativePath+"> failed...");
				PanelManager.mapContainer.initMapBack();
			}finally
			{
				fs.close();
			}
			
		}
		private function onComplete(e:Event):void
		{
			file.removeEventListener(Event.COMPLETE, onComplete);
			
			if(tempData)
			{
				MapConfig.mapHeight = Number(tempData.@width);
				MapConfig.mapWidth = Number(tempData.@height);
				MapConfig.tileWidth = Number(tempData.@tileWidth);
				MapConfig.tileHeight = Number(tempData.@tileHeight);
				PanelManager.mapContainer.initMapBack();
			}
			
			tempName = null;
			tempData = null;
			PanelManager.hidePanel(PanelManager.newMap);
			
		}
		public static function get instance():ConfigManager
		{
			if(_instance == null)
			{
				_instance = new ConfigManager();
			}
			return _instance;
		}

		
	}
}