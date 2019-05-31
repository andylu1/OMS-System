<%@page import="uts.isd.Customer"%>
<%@page import="uts.isd.Customers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("customer") != null) { //If the user is already logged in, send them to the main page
        response.sendRedirect("main.jsp");
    }
%>

<%
    String filePath = application.getRealPath("WEB-INF/customers.xml"); //Link to the XML file
%>

<jsp:useBean id="customerApp" class="uts.isd.CustomerApplication" scope="request">
    <jsp:setProperty name="customerApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Action</title>
    </head>
    <body>
        <%
            Customers customers = customerApp.getCustomers(); //Get a list of all users

            int userID = customerApp.getNewCustomerID(); //Generate a new ID
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String username = request.getParameter("username");
            Customer customer = new Customer(userID, username, password, name, email, false, false); //Create a new object

            customers.addCustomer(customer); //Add new object to list of users
            customerApp.setCustomers(customers); //Update the list of users
            customerApp.updateXML(customers, filePath); //Update the XML file
        %>
        <h1 align="center">Success!</h1>
        <p align="center">Register successful. Click <a href="main.jsp">here</a> to return to the main page.</p>   
    </body>
</html>