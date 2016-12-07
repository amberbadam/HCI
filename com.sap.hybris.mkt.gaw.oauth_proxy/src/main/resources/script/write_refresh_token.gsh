import com.sap.gateway.ip.core.customdev.util.Message;
import java.util.HashMap;
import com.sap.hci.met.oauth.TokenContainer;
import com.sap.hci.met.secureapiwrapper.SecureApiWrapper;

def Message processData(Message message) {
    
    def map = message.getProperties();
    def value = map.get("REFRESH_TOKEN");
    if (value==null) {
        value = "";
    }
    
    def apiwrapper = new SecureApiWrapper();
    apiwrapper.updatePassword("GoogleAdWordsRefreshToken", value.toCharArray());
    
    
	return message;
}

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
