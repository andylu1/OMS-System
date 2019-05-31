package uts.isd;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.PropertyException;
import javax.xml.bind.Unmarshaller;

public class AccessLogApplication {

    private String filePath;
    private AccessLogs accessLogs;
    private AccessLog accessLog;

    public AccessLog getAccessLog() {
        return accessLog;
    }

    public void setAccessLog(AccessLog accessLog) throws PropertyException, JAXBException, FileNotFoundException{
        this.accessLog = accessLog;
        //create a marshaller
        JAXBContext jc = JAXBContext.newInstance(AccessLogs.class);
        Marshaller m = jc.createMarshaller();
        //marshall the object accessLog and write it to the accessLog.xml
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        m.marshal(accessLog, new FileOutputStream("/Users/admin/Desktop/OMS-SystemV2/web/WEB-INF/accessLog.xml"));
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) throws JAXBException, IOException {
        this.filePath = filePath;
        //create an unmarshaller
        JAXBContext jc = JAXBContext.newInstance(AccessLogs.class);
        Unmarshaller u = jc.createUnmarshaller();
        // unmarshall the object from the file
        FileInputStream fin = new FileInputStream(filePath);
        accessLogs = (AccessLogs) u.unmarshal(fin);
        fin.close();
    }

    public AccessLogs getAccessLogs() {
        return accessLogs;
    }

    public void setAccessLogs(AccessLogs accessLogs) {
        this.accessLogs = accessLogs;
    }
    
    public void saveAccessLogs() throws Exception {
        JAXBContext jc = JAXBContext.newInstance(AccessLogs.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        m.marshal(accessLogs, new File("/Users/macpro/Desktop/OMS-SystemV2/web/WEB-INF/accessLog.xml"));
    }
    
    public void updateXML(AccessLogs accessLogs, String filePath) throws Exception{
        this.accessLogs = accessLogs;
        this.filePath = filePath;
        
        // Sets up the helper classes
        JAXBContext jc = JAXBContext.newInstance(AccessLogs.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        
        // Streams the user data into the xml file
        FileOutputStream fout = new FileOutputStream("/Users/admin/Desktop/OMS-SystemV2/web/WEB-INF/accessLog.xml");
        m.marshal(accessLogs, fout);
        fout.close();
    }
    
    public int getNewLogID(){
        if(accessLogs.getList().size() > 0){
            int max = 0;
            for(AccessLog accessLog : accessLogs.getList()){
                if(accessLog.getLogID() > max){
                    max = accessLog.getLogID();
                }
            }
            return max + 1;
        }
        else{
            return 1;
        }
    }
}
