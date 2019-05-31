package uts.isd;

import java.io.Serializable;
import java.util.Date;
import javax.xml.bind.annotation.*;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="accessLog")
public class AccessLog implements Serializable {
    @XmlElement(name="logID")
    private int logID;
    @XmlElement(name="userID")
    private int userID;
    @XmlElement(name="loginDate")
    private Date loginDate;
    @XmlElement(name="logoutDate")
    private Date logoutDate;
    
    public AccessLog() {
    }
    
    public AccessLog(int logID, int userID, Date loginDate, Date logoutDate) {
        this.logID = logID;
        this.userID = userID;
        this.loginDate = loginDate;
        this.logoutDate = logoutDate;
    }
    
    public int getLogID() {
        return logID;
    }
    
    public void setLogID(int logID) {
        this.logID = logID;
    }
    
    public int getUserID() {
        return userID;
    }
    
    public void setUserID(int userID) {
        this.userID = userID;
    }
    
    public Date getLoginDate() {
        return loginDate;
    }
    
    public void setLoginDate(Date loginDate) {
        this.loginDate = loginDate;
    }
    
    public Date getLogoutDate() {
        return logoutDate;
    }
    
    public void setLogoutDate(Date logoutDate) {
        this.logoutDate = logoutDate;
    }
}
