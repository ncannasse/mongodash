package mongo;

extern class Collection {

    function aggregate( pipeline : Dynamic, ?options : {}, ?callback : MongoError -> Dynamic -> Void ) : AggregationCursor;
    function insertMany( objs : Array<Dynamic>, callback : MongoError -> Dynamic -> Void ) : Void;
    function deleteMany( query : Dynamic, callback : MongoError -> Dynamic -> Void ) : Void;
    function find( ?query : Dynamic, ?callback : MongoError -> Dynamic -> Void ) : Cursor;
    
}