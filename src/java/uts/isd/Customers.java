package uts.isd;

import java.io.Serializable;
import java.util.ArrayList;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "customers")
public class Customers implements Serializable {

    @XmlElement(name = "customer")
    private ArrayList<Customer> list = new ArrayList<Customer>();

    public ArrayList<Customer> getList() {
        return list;
    }

    public Customers() {
        super();
    }

    public void addCustomer(Customer customer) {
        list.add(customer);
    }

    public void removeCustomer(Customer customer) {
        list.remove(customer);
    }

    public Customer login(String username, String password) {
        // For each user in the list...
        for (Customer customer : list) {
            if (customer.getUsername().equals(username) && customer.getPassword().equals(password)) {
                return customer; // Login correct. Return this user.
            }
        }
        return null; // Login incorrect. Return null.
    }

    public Customer getCustomer(int i) {
        return list.get(i);
    }

    public Customer getCustomer() {
        for (Customer customer : list) {
            return customer;
        }
        return null;
    }
}
