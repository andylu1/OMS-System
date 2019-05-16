package uts.isd;

import java.util.*;
import java.io.*;
import javax.xml.bind.*;

public class TestJAXB implements Serializable {

    public static void main(String[] args) throws Exception {
        Customers customers = new Customers();
        customers.addCustomer(new Customer("andy1", "password", "andy", "andy@gmail.com"));
        Movies movies = new Movies();
        movies.addMovie(new Movie("Avengers Infinity War","2018"));
        
// Boilerplate code to convert objects to XML...
        JAXBContext jc = JAXBContext.newInstance(Customers.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        m.marshal(customers,System.out);
    }
}
