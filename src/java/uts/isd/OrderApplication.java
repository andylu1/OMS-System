package uts.isd;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

public class OrderApplication {

    private String filePath;
    private Orders orders;

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) throws JAXBException, IOException {
        this.filePath = filePath;

        JAXBContext jc = JAXBContext.newInstance(Orders.class);
        Unmarshaller u = jc.createUnmarshaller();

        FileInputStream fin = new FileInputStream(filePath);
        orders = (Orders) u.unmarshal(fin);
        fin.close();
    }

    public Orders getOrders() {
        return orders;
    }

    public void setOrders(Orders orders) {
        this.orders = orders;
    }
    
    public int getNewOrderID(){
        if(orders.getList().size() > 0){
            int max = 0;
            for(Order order : orders.getList()){
                if(order.getOrderID() > max){
                    max = order.getOrderID();
                }
            }
            return max + 1;
        }
        else{
            return 1;
        }
    }
    
    public void updateXML(Orders orders, String filePath) throws Exception{
        this.orders = orders;
        this.filePath = filePath;
        
        // Sets up the helper classes
        JAXBContext jc = JAXBContext.newInstance(Orders.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        
        // Streams the order data into the xml file
        FileOutputStream fout = new FileOutputStream("/Users/admin/Desktop/OMS-SystemV2/web/WEB-INF/orders.xml");
        m.marshal(orders, fout);
        fout.close();
    }
}
