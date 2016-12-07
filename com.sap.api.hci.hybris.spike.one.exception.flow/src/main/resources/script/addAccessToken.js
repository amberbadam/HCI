importClass(com.sap.gateway.ip.core.customdev.util.Message);
importClass(java.util.HashMap);
function processData(message) {
	//body
	var body = message.getBody();
	message.setBody("");	
	//properties
	map = message.getProperties();
	var access_token = map.get("access_token");
	message.setHeader("Authorization", "Bearer "+access_token.toString());
	return message;
}

