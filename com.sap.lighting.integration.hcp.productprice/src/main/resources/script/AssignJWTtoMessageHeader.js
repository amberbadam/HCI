importClass(com.sap.gateway.ip.core.customdev.util.Message);
importClass(java.util.HashMap);
function processData(message) {
	//headers	
	var map = message.getHeaders();
	var jwt  = map.get("JWT-Authorization");	
	message.setHeader("Authorization", jwt); 
	message.setHeader("JWT-Authorization", null);
//logging	
//   var messageLog = messageLogFactory.getMessageLog(message);	
//	    if(messageLog != null){
//        messageLog.setStringProperty("Logging JWT Authorization", "Printing JWT")
//        messageLog.addAttachmentAsString("jwt:", jwt, "text/plain");
//        }
	return message;	
}

