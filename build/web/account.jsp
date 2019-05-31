<%@page import="uts.isd.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="login.jsp"%>

<%
    String filePath = application.getRealPath("WEB-INF/customers.xml"); //Link to XML file
    Customer customer = (Customer) session.getAttribute("customer"); //Get current session of the user and obtain variable values
    int customerID = customer.getCustomerID();
    String customerName = customer.getName();
    String customerUsername = customer.getUsername();
    String customerPassword = customer.getPassword();
    String customerEmail = customer.getEmail();
%>

<jsp:useBean id="customerApp" class="uts.isd.CustomerApplication" scope="application">
    <jsp:setProperty name="customerApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MY ACCOUNT</title>
    </head>
    
    <!-- Linking CSS file to web page -->
    <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>

    <body>
        <!-- Display the name of the user -->
        <h1 align="center">Account User: <%=customerUsername%></h1>
        <form action="editUser.jsp" method="POST">
            <p align="right">You are logged in as <%=customer.getUsername()%></p>
            
            <!-- Code for the navigation bar -->
            <ul>
                <li><a href="main.jsp">Home</a></li>
                <li><a href="account.jsp">My Account</a></li>
                <%
                    if (customer.getIsStaff() == false) { //If the user is not a staff
                %>
                <li><a href="viewOrders.jsp">My Orders</a></li>
                <%
                    }
                %>
                <li><a href="browseMovies.jsp">Movie Catalogue</a></li>
                    <%
                        if (customer.getIsStaff() == true) { //If the user is a staff
                    %>
                <li><a href="addMovie.jsp">Add New Movie</a></li>
                    <%
                        }
                    %>           
                <li style="float:right"><a href="logout.jsp">Logout</a></li>
            </ul>
            
            <!-- Code for editing form of registration details -->
            <!-- Input fields are pre-loaded with existing values -->
            <h2 align="center">Edit My Account Details:</h2>
            <table align="center">
                <tr>
                    <td>Customer Name</td>
                    <td><input name="customerName" value="<%=customerName%>" required></td>
                </tr>
                <tr>
                    <td>Customer Username</td>
                    <td><input name="customerUsername" value="<%=customerUsername%>" required></td>
                </tr>
                <tr>
                    <td>Customer Email</td>
                    <td><input name="customerEmail" value="<%=customerEmail%>" required></td>
                </tr>
                <tr>
                    <td>Customer Password</td>
                    <td><input name="customerPassword" value="<%=customerPassword%>" required></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Update Account Details"></td>
                </tr>
            </table>
        </form>
                
        <!-- Link to cancel user registration -->
        <h2 align="center">Cancel My Account:</h2>
        <form align="center" action="cancelAccount.jsp">
            <input type="submit" value="Cancel Account">
        </form>
        
        <!-- Link to view user access log -->
        <h2 align="center">View My Access Logs:</h2>
        <form align="center" action="viewAccess.jsp">
            <input align="center" type="submit" value="Go to Access Logs">
        </form>
    </body>
</html>
