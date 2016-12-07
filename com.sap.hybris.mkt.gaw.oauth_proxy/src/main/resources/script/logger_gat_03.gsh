import com.sap.gateway.ip.core.customdev.util.Message;
 
import java.util.HashMap;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Callable;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
 
def Message processData(Message message) {
 
    try {
 
        processData("oauth_proxy_gat_03", message);
 
         
 
    } catch (Exception ex) {
 
         
 
    }
 
}
 
 
 
 
def Message processData(String prefix, Message message) {
 
    try {
 
         
 
        processBody(prefix, message);
 
        processHeadersAndProperties(prefix, message);
 
         
 
    } catch (Exception ex00) {
 
        log.error("processData error",ex00)
 
         
 
        StringWriter sw = new StringWriter();
 
        ex00.printStackTrace(new PrintWriter(sw));
 
        log.error(sw.toString());
 
         
 
    }
 
     
 
    return message;
 
}
 
 
 
 
 
 
 
 
 
 
 
 
 
def void processBody(String prefix, Message message) {
 
     
 
    Logger log = LoggerFactory.getLogger(this.getClass());
 
     
 
     
 
    ExecutorService pool = Executors.newSingleThreadExecutor();
 
    def task = {c -> pool.submit( c as Callable)}
 
     
 
    def byte[] body_bytes = null;
 
     
 
    try {
 
         
 
        if (message==null) {
 
            body_bytes = "";
 
        } else {
 
            body_bytes = message.getBody(byte[].class);
 
        }
 
         
 
        if (body_bytes==null ) {
 
            body_bytes = new byte[0];
 
        }
 
         
 
        task{saveFile("log_"+prefix+"_body.bin", body_bytes)}
 
         
 
         
 
    } catch (Exception ex01) {
 
        log.error("cannot save body",ex01);
 
        StringWriter sw = new StringWriter();
 
        ex01.printStackTrace(new PrintWriter(sw));
 
        log.info(st.toString());
 
    }
 
     
 
}
 
 
 
 
 
 
 
 
 
 
 
 
 
def void processHeadersAndProperties(String prefix, Message message) {
 
     
 
    Logger log = LoggerFactory.getLogger(this.getClass());
 
        
 
    ExecutorService pool = Executors.newSingleThreadExecutor();
 
    def task = {c -> pool.submit( c as Callable)}
 
     
 
     
 
     
 
    try {
 
        def StringBuffer sb_html = new StringBuffer();
 
         
 
        def map = message.getHeaders();
 
        dumpProperties_HTML("Headers", map, sb_html);
 
         
 
        //Properties
 
        map = message.getProperties();
 
        dumpProperties_HTML("Properties", map, sb_html);
 
         
 
         
 
        def ex = map.get("CamelExceptionCaught");
 
         
 
        if (ex!=null) {
 
            sb_html.append("<h1>property.CamelExceptionCaught</h1><br>\n");
 
            sb_html.append("<table>\n");
 
            sb_html.append("<tr><td>exception</td><td>"+ex+"</td></tr>\n");
 
            sb_html.append("<tr><td>getCanonicalName</td><td>"+ex.getClass().getCanonicalName()+"</td></tr>\n");
 
            sb_html.append("<tr><td>getMessage</td><td>"+ex.getMessage()+"</td></tr>\n");
 
             
 
            StringWriter swe = new StringWriter();
 
            ex.printStackTrace(new PrintWriter(swe));
 
             
 
            sb_html.append("<tr><td>stacktrace</td><td><pre>"+swe.toString()+"</pre></td></tr>\n");
 
             
 
             
 
            if (ex.getClass().getCanonicalName().equals("org.apache.camel.component.ahc.AhcOperationFailedException")) {
 
                 
 
                //String str = ;
 
                 
 
                 
 
                sb_html.append("<tr><td>responseBody</td><td><pre>"+
 
                               org.apache.commons.lang.StringEscapeUtils.escapeXml(ex.getResponseBody())+
 
                               "</pre></td></tr>\n");
 
                sb_html.append("<tr><td>getStatusCode()</td><td>"+ex.getStatusCode()+"</td></tr>\n");
 
                sb_html.append("<tr><td>getStatusText()</td><td>"+ex.getStatusText()+"</td></tr>\n");
 
                 
 
            }
 
             
 
            sb_html.append("</table>\n");
 
        }
 
         
 
        task{saveFile("log_"+prefix+".html", sb_html.toString().getBytes())};
 
         
 
         
 
    } catch (Exception ex01) {
 
        log.error("cannot save headers and properties",ex01)
 
        StringWriter sw = new StringWriter();
 
        ex01.printStackTrace(new PrintWriter(sw));
 
        log.info(sw.toString());
 
    }
 
     
 
}
 
 
 
 
 
 
 
 
 
 
public void saveFile(String fileName, byte[] bytes) {
 
    try {
 
        def String METVIEWER_FOLDER = "metviewer";
 
        java.nio.file.Path path = Paths.get(METVIEWER_FOLDER+"/"+fileName);
 
        path.toFile().delete();
 
        path.getParent().toFile().mkdir();
 
        if (bytes!=null) {
 
            Files.write(path, bytes, StandardOpenOption.CREATE);
 
        } else {
 
            Files.write(path, "".getBytes(), StandardOpenOption.CREATE);
 
        }
 
    } catch (Exception ex) {
 
        System.out.println("saveFile.exception: filename:"+fileName+" ex:"+ex);
 
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