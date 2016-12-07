import com.sap.gateway.ip.core.customdev.util.Message;

def Message processData(Message message) {

    def headers = message.getHeaders();
    def props = message.getProperties();
    
    def root_mcc_account = props.get("ROOT_MCC_ACCOUNT");
    def target_customer_id = headers.get("TargetClientCustomerId");
    
    def client_cusotomer_id = null;
    if ("".equals(target_customer_id)|| (target_customer_id==null)) {
        client_cusotomer_id  = root_mcc_account;
    } else {
        client_cusotomer_id  = target_customer_id;
    }
    
    message.setProperty("CLIENT_CUSTOMER_ID", client_cusotomer_id );
    
	return message;
}

