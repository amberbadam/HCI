importClass(com.sap.gateway.ip.core.customdev.util.Message);
importClass(java.util.HashMap);
function processData(message) {
	var map = message.getProperties();
	var ex = map.getProperty(“CamelExceptionCaught”);
	if(ex!=null){
	message.setProperty("STATUS_CODE",ex.getStatusCode());
	message.setProperty(“STATUS_TEXT”,ex.getStatusText());
	}
	return message;
}

