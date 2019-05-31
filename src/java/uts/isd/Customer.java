package uts.isd;

import java.io.Serializable;
import javax.xml.bind.annotation.*;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="customer")
public class Customer implements Serializable {
    @XmlElement(name="customerID")
    private int customerID;
    @XmlElement(name="username")
    private String username;
    @XmlElement(name="password")
    private String password;
    @XmlElement(name="name")
    private String name;
    @XmlElement(name="email")
    private String email;
    @XmlElement(name="isStaff")
    private boolean isStaff;
    @XmlElement(name="accountCancel")
    private boolean accountCancel;

    public Customer() {
    }

    public Customer(int customerID, String username, String password, String name, String email, boolean isStaff, boolean accountCancel) {
        this.customerID = customerID;
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.isStaff = isStaff;
        this.accountCancel = accountCancel;
    }
    
    public int getCustomerID() {
        return customerID;
    }
    
    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }
 
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public boolean getIsStaff() {
        return isStaff;
    }
    
    public void setIsStaff(boolean isStaff) {
        this.isStaff = isStaff;
    }
    
    public boolean getAccountCancel() {
        return this.accountCancel;
    }
    
    public void setAccountCancel(boolean accountCancel) {
        this.accountCancel = accountCancel;
    }
}
