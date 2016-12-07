import com.sap.gateway.ip.core.customdev.util.Message;
import java.util.HashMap;
import com.sap.hci.met.oauth.TokenContainer;
import com.sap.hci.met.secureapiwrapper.SecureApiWrapper;


def Message processData(Message message) {
	
	def map = message.getProperties();
    def value = map.get("ACCESS_TOKEN");
    if (value==null) {
      value = "";
    }
   
    def apiwrapper = new SecureApiWrapper();
    apiwrapper.updatePassword("GoogleAdWordsAccessToken", value.toCharArray());
      
    def currentDate = new Date();
	def currentDateInMsec = currentDate.getTime();
	apiwrapper.updatePassword("GoogleAdWordsAccessTokenTs", String.valueOf(currentDateInMsec).toCharArray());
        
        
	return message;
}

