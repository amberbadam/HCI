import com.sap.gateway.ip.core.customdev.util.Message;
import java.util.HashMap;

import com.sap.it.api.ITApiFactory;
import com.sap.it.api.securestore.SecureStoreService;
import com.sap.it.api.securestore.UserCredential;

def Message processData(Message message) {

    def service = ITApiFactory.getApi(SecureStoreService.class, null);
        
    //Set Client Id and Secret
    String Client_Id = new String("598700112637-qr3evdaj7ctgckak67l09rqqvc8nj5mq.apps.googleusercontent.com");
 	String Client_Secret = new String("PXbv4vo0c-yULeALwAzKm1z4");
    
    message.setProperty("CLIENT_ID", Client_Id );
    message.setProperty("CLIENT_SECRET", Client_Secret);
    
    //Set Empty Developer Token
   	message.setProperty("DEVELOPER_TOKEN", "");  
    
    
    credential = service.getUserCredential("GoogleAdWordsCode");
    if (credential == null){
        throw new IllegalStateException("No credential found for alias 'GoogleAdWordsCode'");
    }
    userName = credential.getUsername();
    password = new String(credential.getPassword());
    
    message.setProperty("CODE", password);
    
    
	return message;
}

