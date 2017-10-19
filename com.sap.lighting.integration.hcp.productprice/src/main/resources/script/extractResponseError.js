importClass(com.sap.gateway.ip.core.customdev.util.Message);
importClass(java.util.HashMap);
function processData(message) {	
	//properties
	map = message.getProperties();
	var exc = map.get("CamelExceptionCaught");
    if(exc != null)
    {
    //body
	var body = message.getBody();
	message.setBody(exc.getResponseBody());	
    };
	return message;
}

