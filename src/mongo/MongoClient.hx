package mongo;

@:jsRequire("mongodb")
extern class MongoClient {

    static function connect( url : String, callb : MongoError -> Db -> Void ) : Void;

}