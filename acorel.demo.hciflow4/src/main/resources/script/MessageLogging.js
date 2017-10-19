importClass(com.sap.gateway.ip.core.customdev.util.Message);
importClass(java.util.HashMap);
importClass(com.google.gson.JsonParser);
importClass(java.util.Map);
 
function processData(message) {
	//body
	var body = message.getBody();
	var head = message.getHeaders();

	
    var messageLog = messageLogFactory.getMessageLog(message);
    if(messageLog != null){
        messageLog.setStringProperty("Logging#1", "Printing Payload As Attachment")
        messageLog.addAttachmentAsString("ResponsePayload1:", body, "text/plain");
       messageLog.setStringProperty("Logging#2", "Printing Payload As Attachment")
        messageLog.addAttachmentAsString("ResponsePayload2:", head, "text/plain");
     }
// Adjust Headers
    message.setHeader("ID", "1000032");
    message.setProperty("Pload",message.getBody(java.lang.String));
//Parse JSON and Read Properties
/*	var bodyAsJSON = JsonParser().parse(message.getBody(java.lang.String)).getAsJsonObject();
       message.setProperty("RoleCode", bodyAsJSON.get("RoleCode").getAsString());
*/       
	
	return message; 
	
}

