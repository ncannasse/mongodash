class Main {

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