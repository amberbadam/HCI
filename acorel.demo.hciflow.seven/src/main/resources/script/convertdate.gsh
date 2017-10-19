import com.sap.it.api.mapping.*;

//Add MappingContext as an additional argument to read or set Headers and properties.

def String customFunc(String arg1){
 mydate = Date.parse("yyyy-MM-dd'T'hh:mm:ss.SSS", arg1 );
arg1 =  mydate.format("yyyyMMdd");

}
