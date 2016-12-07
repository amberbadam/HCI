importClass(com.sap.gateway.ip.core.customdev.util.Message);
importClass(java.util.HashMap);
function processData(message) {	
//properties
	map = message.getProperties();
	var etime = map.get("expires_in");
	var edate = map.get("expiry_date");
	
//Calucuate the expiry date and time 	
	var expiry = new Date(edate);
	expiry.setSeconds(expiry.getSeconds()+etime);	
	var currentdate = new Date();

//set indicator to start new flow to fectch new token	
	if(currentdate < expiry){
		message.setProperty("refresh", "X");
	}  
	return message;
}

