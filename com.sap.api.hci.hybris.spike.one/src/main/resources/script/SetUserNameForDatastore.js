importClass(com.sap.gateway.ip.core.customdev.util.Message);
importClass(java.util.HashMap); 
function processData(message) {
	message.setHeader("username","test1@philips.com");
	return message;
}

