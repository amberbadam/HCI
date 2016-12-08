

importClass(com.sap.gateway.ip.core.customdev.util.Message);
importClass(java.util.HashMap);

 
function processData(message) {
//body
	var body = message.getBody();
   var messageLog = messageLogFactory.getMessageLog(message);	
	    if(messageLog != null){
        messageLog.setStringProperty("Logging properties", "Printing CustomerGroup call response")
        messageLog.addAttachmentAsString("body:", body, "text/plain");
    }; 
	message.setBody("");
	return message;
}

