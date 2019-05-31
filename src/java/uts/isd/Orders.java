package uts.isd;

import java.util.*;
import java.io.Serializable;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "orders")
public class Orders implements Serializable {

    @XmlElement(name = "order")
    private ArrayList<Order> list = new ArrayList<Order>();

    public ArrayList<Order> getList() {
        return list;
    }

    public void addOrder(Order order) {
        list.add(order);
    }

    public void removeOrder(Order order) {
        list.remove(order);
    }
    
    public Order getOrder(int i) {
        return list.get(i);
    }

    public Order getOrder() {
        for (Order order : list) {
            return order;
        }
        return null;
    }
    
    public Order getExactOrder(int orderID) {
        for (Order order : list) {
            if(order.getOrderID() == orderID) {
                return order;
            }
        }
        return null;
    }
}
