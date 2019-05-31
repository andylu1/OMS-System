package uts.isd;

import java.io.Serializable;
import java.util.ArrayList;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "accessLogs")
public class AccessLogs implements Serializable {

    @XmlElement(name = "accessLog")
    private ArrayList<AccessLog> list = new ArrayList<AccessLog>();

    public ArrayList<AccessLog> getList() {
        return list;
    }

    public AccessLogs() {
        super();
    }

    public void addAccessLog(AccessLog accessLog) {
        list.add(accessLog);
    }

    public void removeAccessLog(AccessLog accessLog) {
        list.remove(accessLog);
    }

    public AccessLog getAccessLog(int i) {
        return list.get(i);
    }

    public AccessLog getAccessLog() {
        for (AccessLog accessLog : list) {
            return accessLog;
        }
        return null;
    }
}
