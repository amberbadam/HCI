import com.sap.it.api.mapping.*;
import groovy.time.TimeCategory;
//Add MappingContext as an additional argument to read or set Headers and properties.
def String customFunc(String arg1){
currentDate =  new Date()
use( TimeCategory ) {
    arg1 = currentDate + arg1.seconds
}
	return arg1 
}
