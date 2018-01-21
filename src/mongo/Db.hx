package mongo;

extern class Db {

    function collection( name : String ) : Collection;
    function close() : Void;

    function authenticate( user : String, pass : String, ?options : Dynamic, ?callb : MongoError -> Dynamic ) : Void;

}