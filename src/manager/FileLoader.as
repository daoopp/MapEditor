package manager
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class FileLoader extends File
	{
		//文件字典
		private static var fileDic:Dictionary = new Dictionary();
		
		private var fs:FileStream;
		private var _key:String;
		private var imageFilter:Array = [new FileFilter("Image","*.png;*.jpg;*jpeg")];
		private var callBack:Function;
		private var loader:Loader;
		public function FileLoader(_name:String, path:String=null)
		{
			super(path);
			this._key = _name;
			fs = new FileStream();
			loader = new Loader();
		}
		public function openImage(cb:Function):void
		{
			callBack = cb;
			this.browse(imageFilter);
			this.addEventListener(Event.SELECT, onSelect);
		}
		private function onSelect(e:Event):void
		{
			fs.open(this, FileMode.READ)
			try
			{
				var ba:ByteArray = new ByteArray();
				fs.readBytes(ba);
				loader.loadBytes(ba);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
			} 
			catch(e:Error) 
			{
				trace(e.toString());
			}finally
			{
				fs.close()
			}
		}
		private function onLoaded(e:Event):void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded);
			var bm:Bitmap = loader.content as Bitmap;
			if(callBack != null)
			{
				MapConfig.bgAdd = this.nativePath;
				callBack(bm);
			}
		}
		public static function getLoader(key:String):FileLoader
		{
			if(fileDic.hasOwnProperty(key))
			{
				return fileDic[key] as FileLoader;
			}else
			{
				var file:FileLoader = new FileLoader(key);
				fileDic[key] = file;
				return file;
			}
		}

		public function get key():String
		{
			return _key;
		}

	}
}