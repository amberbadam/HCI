/*
/*
 * The integration developer needs to create the method processData 
 * This method takes Message object of package com.sap.gateway.ip.core.customdev.util
 * which includes helper methods useful for the content developer:
 * 
 * The methods available are:
    public java.lang.Object getBody()
    
    //This method helps User to retrieve message body as specific type ( InputStream , String , byte[] ) - e.g. message.getBody(java.io.InputStream)
    public java.lang.Object getBody(java.lang.String fullyQualifiedClassName)

    public void setBody(java.lang.Object exchangeBody)

    public java.util.Map<java.lang.String,java.lang.Object> getHeaders()

    public void setHeaders(java.util.Map<java.lang.String,java.lang.Object> exchangeHeaders)

    public void setHeader(java.lang.String name, java.lang.Object value)

    public java.util.Map<java.lang.String,java.lang.Object> getProperties()

    public void setProperties(java.util.Map<java.lang.String,java.lang.Object> exchangeProperties) 

 * 
 */

importClass(com.sap.gateway.ip.core.customdev.util.Message);
importClass(java.util.HashMap);

 
function processData(message) {
	//body
	var body = message.getBody();
	message.setBody(body + " modified from js");	
	
	//headers	
	var map = message.getHeaders();
	var value = map.get("oldHeader");
	message.setHeader("oldHeader", value + "modified");
	message.setHeader("newHeader", "newHeader");
	
	//properties
	map = message.getProperties();
	value = map.get("oldProperty");
	message.setProperty("oldProperty", value + "modified");
	message.setProperty("newProperty", "newProperty");
	
	return message;
}

