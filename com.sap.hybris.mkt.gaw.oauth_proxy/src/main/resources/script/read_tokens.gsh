import com.sap.gateway.ip.core.customdev.util.Message;
import java.util.HashMap;
import com.sap.hci.met.secureapiwrapper.SecureApiWrapper;

def Message processData(Message message) {
	
    
    def apiwrapper = new SecureApiWrapper();
    def atoken = apiwrapper.getPassword("GoogleAdWordsAccessToken");
    if (atoken==null) {
        atoken = "";
    }
        
    def rtoken = apiwrapper.getPassword("GoogleAdWordsRefreshToken");
    if (rtoken==null) {
        rtoken = "";
    }
    
    message.setProperty("ACCESS_TOKEN", atoken);
    message.setProperty("REFRESH_TOKEN", rtoken);
    
	return message;
}

