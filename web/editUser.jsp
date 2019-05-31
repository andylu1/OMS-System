<%@page import="uts.isd.Customer"%>
<%@page import="uts.isd.Customers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="login.jsp"%>

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
        <title>EDIT USER</title>
    </head>

    <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>

    <body>
        <h1>EDITING USER DETAILS</h1>
        <%
            Customer customer = (Customer) session.getAttribute("customer"); //Get current session of the user and values
            int id = customer.getCustomerID();
            String name = request.getParameter("customerName");
            String email = request.getParameter("customerEmail");
            String password = request.getParameter("customerPassword");
            String username = request.getParameter("customerUsername");
            boolean isStaff = customer.getIsStaff();
            boolean accountCancel = customer.getAccountCancel();

            customer.setName(name);
            customer.setUsername(username);
            customer.setEmail(email);
            customer.setPassword(password);

            Customer newCustomer = new Customer(id, username, password, name, email, isStaff, accountCancel); //Create a new customer object
            Customers customers = customerApp.getCustomers(); //Get a list of all users

            for (int i = 0; i <= customers.getList().size() - 1; i++) { //For-loop
                Customer customer1 = customers.getCustomer(i);
                if (customer1.getCustomerID() == id) {
                    customers.removeCustomer(customer1); //Remove old user with the same ID
                }
            }
            customers.addCustomer(newCustomer); //Add the new/edited user to the list of users
            customerApp.setCustomers(customers); //Update the list of users
            customerApp.updateXML(customers, filePath); //Update the XML file

            session.setAttribute("customer", newCustomer); //Update the current session with the details of the new account
            response.sendRedirect("main.jsp");
        %>
    </body>
</html>
