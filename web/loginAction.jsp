<%@page import="java.util.Date"%>
<%@page import="uts.isd.Customer"%>
<%@page import="uts.isd.Customers"%>
<%@page import="uts.isd.AccessLog"%>
<%@page import="uts.isd.AccessLogs"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="login.jsp"%>

<%
    if (session.getAttribute("customer") != null) { //If the user is already logged in, send them to the main page
        response.sendRedirect("main.jsp");
    }
%>

<%
    String filePath = application.getRealPath("WEB-INF/customers.xml"); //Link to XML
    String filePath1 = application.getRealPath("WEB-INF/accessLog.xml"); //Link to XML
%>

<jsp:useBean id="customerApp" class="uts.isd.CustomerApplication" scope="application">
    <jsp:setProperty name="customerApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>

<jsp:useBean id="accessApp" class="uts.isd.AccessLogApplication" scope="application">
    <jsp:setProperty name="accessApp" property="filePath" value="<%=filePath1%>"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LOGIN ACTION</title>
    </head>

    <!-- code for navigation bar -->
    <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>

    <body>
        <%
            String username = request.getParameter("username"); //Values from previous login page
            String password = request.getParameter("password");

            Customers customers = customerApp.getCustomers(); //Get a list of users
            Customer customer = customers.login(username, password); //check if the details match an existing user

            if (customer != null) { //If the user does exist and the details match
                if (!customer.getAccountCancel()) { //If the account is not cancelled
                    session.setAttribute("customer", customer); //Create a new session for the user

                    AccessLogs accessLogs = accessApp.getAccessLogs(); //Get a list of access logs
                    int logID = accessApp.getNewLogID(); //Generate a new log ID
                    int userID = customer.getCustomerID();
                    Date loginDate = new Date();
                    Date logoutDate = loginDate;
                    AccessLog accessLog = new AccessLog(logID, userID, loginDate, logoutDate); //Create a new AccessLog object
                    accessLogs.addAccessLog(accessLog); //Add the new object to the list of access logs
                    accessApp.setAccessLogs(accessLogs); //Update the list of access logs
                    accessApp.updateXML(accessLogs, filePath1); //Update the XML file

                    session.setAttribute("accessLog", accessLog); //Create a new session for the access log - to be used later to update the logout date
                    response.sendRedirect("main.jsp");
                } else {
        %>
        <!-- When the account is cancelled -->
        <h1 align="center">Account is cancelled</h1>
        <p align="center">Account is not available. Please contact staff for assistance.</p>
        <%
            }
        } else {
        %>
        <!-- When the password or username do not match -->
        <h1 align="center">Unsuccessful Login</h1>
        <p align="center">Password or username incorrect. Please click <a href="login.jsp">here</a> to try again.</p>
        <%  }%>
    </body>
</html>
