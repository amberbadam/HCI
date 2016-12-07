importClass(com.sap.gateway.ip.core.customdev.util.Message);
importClass(java.util.HashMap);
importClass(java.util.Map);
importClass(com.google.gson.JsonParser);
// importClass()

function processData(message) {
	// Save the tokens in properties and write it to db
//	var username = message.getProperty("username");
//	if (username == null || username.equals("")) {
//		username = "test1@philips.com";
//	}
	
	//message.setProperty("username",username);
	//message.setProperty("usertokens", username + message.getBody());

	// Parse Json
	var newMsg = new com.sap.gateway.ip.core.customdev.util.Message();
	newMsg.setProperties(message.getProperties());
	var bodyAsJSON = JsonParser().parse(message.getBody(java.lang.String))
			.getAsJsonObject();
	newMsg.setHeader("Authorization", "Bearer "
			+ bodyAsJSON.get("access_token").getAsString());
	newMsg.setHeader("Content-Length", "0");

	// Store to hash map
	//var code_hashmap = new java.util.HashMap();
	//code_hashmap.put(username, bodyAsJSON);

	//newMsg.setHeader("code_hashmap", code_hashmap);
	//newMsg.setProperty("code", code_hashmap);
	
	return newMsg;
}
