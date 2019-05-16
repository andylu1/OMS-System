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

public class CustomerApplication {

    private String filePath;
    private Customers customers;
    private Customer customer;

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) throws PropertyException, JAXBException, FileNotFoundException{
        this.customer = customer;
        //create a marshaller
        JAXBContext jc = JAXBContext.newInstance(Customers.class);
        Marshaller m = jc.createMarshaller();
        //marshall the object customer and write it to the customers.xml
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        m.marshal(customer, new FileOutputStream("/Users/admin/Documents/GitHub/OMS-System/web/WEB-INF/customers.xml"));
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) throws JAXBException, IOException {
        this.filePath = filePath;
        //create an unmarshaller
        JAXBContext jc = JAXBContext.newInstance(Customers.class);
        Unmarshaller u = jc.createUnmarshaller();
        // unmarshall the object from the file
        FileInputStream fin = new FileInputStream(filePath);
        customers = (Customers) u.unmarshal(fin);
        fin.close();

    }

    public Customers getCustomers() {
        return customers;
    }

    public void setCustomers(Customers customers) {
        this.customers = customers;
    }
    
    public void saveUsers() throws Exception {
        JAXBContext jc = JAXBContext.newInstance(Customers.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        m.marshal(customers, new File("WEB-INF/customers.xml"));
    }
}
