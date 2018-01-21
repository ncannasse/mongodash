package mongo;

extern class Cursor {

    function toArray( callb : MongoError -> Array<Dynamic> -> Void ) : Void;

}