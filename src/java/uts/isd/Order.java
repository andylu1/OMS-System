package uts.isd;

import java.io.Serializable;
import java.util.Date;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)
public class Order implements Serializable {
    @XmlElement(name="orderID")
    private int orderID;
    @XmlElement(name="orderQuantity")
    private int orderQuantity;
    @XmlElement(name="orderMovieID")
    private int orderMovieID;
    @XmlElement(name="orderCustomerID")
    private int orderCustomerID;
    @XmlElement(name="orderCancelled")
    private boolean orderCancelled;
    @XmlElement(name="orderDate")
    private Date orderDate;


    public Order(int orderID, int orderQuantity, int orderMovieID, int orderCustomerID, boolean orderCancelled, Date orderDate) {
        this.orderID = orderID;
        this.orderQuantity = orderQuantity;
        this.orderMovieID = orderMovieID;
        this.orderCustomerID = orderCustomerID;
        this.orderCancelled = orderCancelled;
        this.orderDate = orderDate;
    }

    public Order() {
    }
    
    public int getOrderID() {
        return orderID;
    }
    
    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }
    
    public int getOrderQuantity() {
        return orderQuantity;
    }
    
    public void setOrderQuantity(int orderQuantity) {
        this.orderQuantity = orderQuantity;
    }
    
    public int getOrderMovieID() {
        return orderMovieID;
    }
    
    public void setOrderMovieID(int orderMovieID) {
        this.orderMovieID = orderMovieID;
    }
    
    public int getOrderCustomerID() {
        return orderCustomerID;
    }
    
    public void setOrderCustomerID(int orderCustomerID) {
        this.orderCustomerID = orderCustomerID;
    }
    
    public boolean getOrderCancelled() {
        return orderCancelled;
    }
    
    public void setOrderCancelled(boolean orderCancelled) {
        this.orderCancelled = orderCancelled;
    }
    
    public Date getOrderDate() {
        return orderDate;
    }
    
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
}