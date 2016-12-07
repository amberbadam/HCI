/*
 
 
 <soap:Envelope>
 <soap:Header>
 <ResponseHeader xmlns="https://adwords.google.com/api/adwords/cm/v201506">
 <requestId>00051c6f207dc4310ac42a8ae002be38</requestId>
 <serviceName>CampaignService</serviceName>
 <methodName>mutate</methodName>
 <operations>0</operations>
 <responseTime>424</responseTime>
 </ResponseHeader>
 </soap:Header>
 <soap:Body>
 <soap:Fault>
 <faultcode>soap:Server</faultcode>
 <faultstring>[AuthenticationError.OAUTH_TOKEN_INVALID @ ; trigger:'&lt;null>']</faultstring>
 <detail>
 <ApiExceptionFault xmlns="https://adwords.google.com/api/adwords/cm/v201506">
 <message>[AuthenticationError.OAUTH_TOKEN_INVALID @ ; trigger:'&lt;null>']</message>
 <ApplicationException.Type>ApiException</ApplicationException.Type>
 <errors xsi:type="AuthenticationError" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
 <fieldPath/>
 <trigger>&lt;null></trigger>
 <errorString>AuthenticationError.OAUTH_TOKEN_INVALID</errorString>
 <ApiError.Type>AuthenticationError</ApiError.Type>
 <reason>OAUTH_TOKEN_INVALID</reason>
 </errors>
 </ApiExceptionFault>
 </detail>
 </soap:Fault>
 </soap:Body>
 </soap:Envelope>
 
 */




import java.io.StringReader;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import com.sap.gateway.ip.core.customdev.util.Message;
import java.util.HashMap;

import com.sap.gateway.ip.core.customdev.util.Message;
import java.util.HashMap;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

def Message processData(Message message) {
   
    Logger log = LoggerFactory.getLogger(this.getClass());
 
    def map = message.getProperties();
    def ex = map.get("CamelExceptionCaught");
    
    log.error("010");
    
    if (ex!=null) {
     
    log.error("020");
    
	//Body 
	def body = message.getBody(String.class);
	message.setBody(ex.getResponseBody());
	
	 log.error("020");
   
	//Headers 
	message.setHeader("STATUS_CODE", ex.getStatusCode());
	message.setHeader("STATUS_TEXT", ex.getStatusText());
	
	 log.error("030");
   
	def reason = process_xpath(ex.getResponseBody(), "//Envelope//Body//Fault//detail//ApiExceptionFault//errors//reason");
	def fault_string = process_xpath(ex.getResponseBody(), "//Envelope//Body//Fault//faultstring");
	
	 log.error("040");
   
   log.error("041 reason="+reason);
   log.error("042 fault_string="+fault_string);
   
    message.setHeader("REASON",reason);
	message.setHeader("FAULT_STRING",fault_string);
	
	
    }
    
        
        
	return message;
}


// /soap:Envelope/soap:Body/soap:Fault/detail/adwords:ApiExceptionFault/adwords:errors/adwords:reason

def String process_xpath(String payload, String xpath_expr) {
	
	Logger log = LoggerFactory.getLogger(this.getClass());
 
  log.error("process_xpath_010");
   
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
	
	log.error("process_xpath_011"+payload);
  	
		InputSource inputSource = new InputSource( new StringReader( payload ) );
	log.error("process_xpath_020");
  	
		Document doc = builder.parse(inputSource);
		XPathFactory xPathfactory = XPathFactory.newInstance();
		XPath xpath = xPathfactory.newXPath();
		XPathExpression expr = xpath.compile(xpath_expr);
		
		log.error("process_xpath_030");
  
		
		NodeList nl = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
  log.error("process_xpath_050");
  
  
    String text = "??";
    if (nl.item(0) == null ) {
    text = "null";
    } else {
    log.error("process_xpath_060");
  
         text = nl.item(0).getTextContent();
    }
	
	return text;
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

