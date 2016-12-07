import com.sap.gateway.ip.core.customdev.util.Message;
import java.util.HashMap;

def Message processData(Message message) {
//set header
   message.setHeader("Authorization", "Basic " + "bW9iaWxlX2FuZHJvaWQ6c2VjcmV0"); 
      return message;
}

