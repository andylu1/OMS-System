<%@page import="uts.isd.Customer"%>
<%@page import="uts.isd.Customers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String filePath = application.getRealPath("WEB-INF/customers.xml"); //Link to XML file
%>

<jsp:useBean id="customerApp" class="uts.isd.CustomerApplication" scope="request">
    <jsp:setProperty name="customerApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CANCEL ACCOUNT</title>
    </head>
    <body>
        <h1>CANCEL ACCOUNT</h1>
        <%
            Customer customer = (Customer) session.getAttribute("customer"); //Get current session of the user

            int id = customer.getCustomerID(); //Get all the values of the user
            String name = customer.getName();
            String email = customer.getEmail();
            String password = customer.getPassword();
            String username = customer.getUsername();
            boolean isStaff = customer.getIsStaff();
            boolean accountCancel = true;

            customer.setAccountCancel(accountCancel); //Change the status of their account to cancelled

            Customer newCustomer = new Customer(id, username, password, name, email, isStaff, accountCancel); //Create a new object
            Customers customers = customerApp.getCustomers(); //Get a list of all the users

            for (int i = 0; i <= customers.getList().size() - 1; i++) { //For-loop to find the user with matching ID
                Customer customer1 = customers.getCustomer(i);
                if (customer1.getCustomerID() == id) {
                    customers.removeCustomer(customer1); //Remove the matching customer from the list
                }
            }
            customers.addCustomer(newCustomer); //Add in the new user that was created
            customerApp.setCustomers(customers); //Update the list of users
            customerApp.updateXML(customers, filePath); //Update the XML file with the list of users
            session.invalidate(); //End all sessions
%>
        <p>Your account is now cancelled. Click <a href="main.jsp">here</a> to go home</p>
    </body>
</html>
