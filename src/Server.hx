class Server {

	var config : {
		host : String,
		port : Int,
		dbhost : String,
		dbport : Int,
		db : String,
		user : String,
		password : String,
	};

	var db : mongo.Db;

	public function new() {
		config = haxe.Json.parse(sys.io.File.getContent("config.json"));
		js.node.Http.createServer(onRequest).listen(config.port, config.host);
	}

	function onRequest( req : js.node.http.IncomingMessage, resp : js.node.http.ServerResponse ) {
		var url = req.url;
		var baseName = url.split("/").pop();
		if( baseName.indexOf(".") > 0 && url.indexOf("..") < 0 ) {
			try {
				var ext = baseName.split(".").pop().toLowerCase();
				switch( ext ) {
				case "png", "jpg", "jpeg", "gif":
					resp.setHeader('Content-Type', 'image/' + ext);
				case "js", "css":
					//
				default:
					throw "not accessible";
				}
				var content = sys.io.File.getBytes("." + url);
				resp.end(js.node.Buffer.hxFromBytes(content));
				return;
			} catch( e : Dynamic ) {
			}
		}
		function onError(err:Dynamic,isExc=false) {
			if( db != null ) {
				db.close();
				db = null;
			}
			resp.end("<pre>"+StringTools.htmlEscape(err+haxe.CallStack.toString(isExc?haxe.CallStack.exceptionStack():haxe.CallStack.callStack()))+"</pre>");
		}
		mongo.MongoClient.connect("mongodb://"+config.user+":"+config.password+"@"+config.dbhost+":"+config.dbport+"/"+config.db,function(err,db) {
			if( err != null ) {
				onError(err);
				return;
			}
			this.db = db;
			try {
				var content = handleURL(url);
				db.close();
				db = null;
				resp.end(content);
			} catch( err : Dynamic ) {
				onError(err, true);
			}
		});
	}

	function handleURL( url : String ) : String {
		var tpl = new thx.tpl.Template(sys.io.File.getContent("data/index.html"));
		return tpl.execute([ "" => "" ]);
	}

	static function main() {
		if( js.node.Buffer != null ) {
			try {
				var srcMap = js.node.Require.require("source-map-support");
				srcMap.install();
				haxe.CallStack.wrapCallSite = srcMap.wrapCallSite;
			} catch( e : Dynamic ) {
			}
			js.Node.process.on("uncaughtException", function(e) js.Node.console.log(e));
			new Server();
		}
	}
}