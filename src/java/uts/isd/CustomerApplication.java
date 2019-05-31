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
        m.marshal(customer, new FileOutputStream("/Users/admin/Desktop/OMS-SystemV2/web/WEB-INF/customers.xml"));
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
    
    public void saveCustomers() throws Exception {
        JAXBContext jc = JAXBContext.newInstance(Customers.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        m.marshal(customers, new File("/Users/macpro/Desktop/OMS-SystemV2/web/WEB-INF/customers.xml"));
    }
    
    public void updateXML(Customers customers, String filePath) throws Exception{
        this.customers = customers;
        this.filePath = filePath;
        
        // Sets up the helper classes
        JAXBContext jc = JAXBContext.newInstance(Customers.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        
        // Streams the user data into the xml file
        FileOutputStream fout = new FileOutputStream("/Users/admin/Desktop/OMS-SystemV2/web/WEB-INF/customers.xml");
        m.marshal(customers, fout);
        fout.close();
    }
    
    public int getNewCustomerID(){
        if(customers.getList().size() > 0){
            int max = 0;
            for(Customer customer : customers.getList()){
                if(customer.getCustomerID() > max){
                    max = customer.getCustomerID();
                }
            }
            return max + 1;
        }
        else{
            return 1;
        }
    }
}
