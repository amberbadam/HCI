import com.sap.gateway.ip.core.customdev.util.Message;
import java.util.HashMap;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.Map;
import com.sap.hci.met.oauth.TokenContainer;

 
 def Message processData(Message message) {
     try {
         processData("gt15_refresh_token_on_new_code_001", message);
         
     } catch (Exception ex) {
         
     }
 }



def Message processData(String prefix, Message message) {
def StringBuffer sb_html = new StringBuffer();
//Headers

  
def String body = message.getBody(java.lang.String.class);

    if (body==null ) {
        body = "";
    }
  
  
    saveFile("log_"+prefix+"_body.bin", body.getBytes());

 def map = message.getHeaders();
 dumpProperties_HTML("headers", map, sb_html);
  
    //Properties
    map = message.getProperties();
    dumpProperties_HTML("properties", map, sb_html);
    
    def ex = map.get("CamelExceptionCaught");
    
    
    sb_html.append("<h1>ex</h1><br>\n");
    if (ex!=null) {
        
        
        sb_html.append("<table>\n");
        sb_html.append("<tr><td>responseBody</td><td>"+ex.getResponseBody()+"</td></tr>\n");
        sb_html.append("<tr><td>getStatusCode()</td><td>"+ex.getStatusCode()+"</td></tr>\n");
        sb_html.append("<tr><td>getStatusText()</td><td>"+ex.getStatusText()+"</td></tr>\n");
        sb_html.append("</table>\n");
    }
    
    sb_html.append("<h1>TokenContainer</h1><br>\n");
    sb_html.append("<table>\n");
    sb_html.append("<tr><td>ID</td><td>"+TokenContainer.getInstance().getId()+"</td></tr>\n");
    sb_html.append("<tr><td>ACCESS_TOKEN</td><td>"+TokenContainer.getInstance().getAccessToken()+"</td></tr>\n");
    sb_html.append("<tr><td>REFRESH_TOKEN</td><td>"+TokenContainer.getInstance().getRefreshToken()+"</td></tr>\n");
    sb_html.append("</table>\n");
    
    
saveFile("log_"+prefix+".html", sb_html.toString().getBytes());

    
    

return message;
}



 public void saveFile(String fileName, byte[] bytes) {
 try {
 def String METVIEWER_FOLDER = "metviewer";
 java.nio.file.Path path = Paths.get(METVIEWER_FOLDER+"/"+fileName);
 path.toFile().delete();
 path.getParent().toFile().mkdir();
 Files.write(path, bytes, StandardOpenOption.CREATE);
 } catch (IOException ex) {
 throw new RuntimeException(ex);
 }
 }

 public void dumpProperties(String title, Map<String, Object> map, StringBuffer sb) {
 sb.append(title+"\n");
 for (String key : map.keySet()) {
 sb.append(key+"\t"+map.get(key)+"\n");
 }
 }

 public void dumpProperties_HTML(String title, Map<String, Object> map, StringBuffer sb) {
 sb.append("<h1>"+title+"</h1><br>\n");
 sb.append("<table>\n");
 for (String key : map.keySet()) {
 sb.append("<tr>\n");
 sb.append("<td>"+key+"</td><td>"+map.get(key)+"</td>\n");
 sb.append("</tr>\n");
 }
 sb.append("</table>\n");
 }