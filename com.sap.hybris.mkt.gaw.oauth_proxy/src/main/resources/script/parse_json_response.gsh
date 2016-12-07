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

	public void setProperty(java.lang.String name, java.lang.Object value)
 * 
 */
import com.sap.gateway.ip.core.customdev.util.Message;
import java.util.HashMap;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

def Message processData(Message message) {
	
	//Body 
	def body = message.getBody(java.lang.String.class);

	
	JsonParser parser = new JsonParser();
    JsonObject o = (JsonObject)parser.parse(body);

    def access_token = o.get("access_token");
    if (access_token!=null) {
        message.setProperty("ACCESS_TOKEN", access_token.getAsString());

    } else {
        message.setProperty("ACCESS_TOKEN", "EMPTY");
        
    }
    
    def refresh_token = o.get("refresh_token");
    if (refresh_token!=null) {
        message.setProperty("REFRESH_TOKEN", refresh_token.getAsString());
        
    }
    
	return message;
}

