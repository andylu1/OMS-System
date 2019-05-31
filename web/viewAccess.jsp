<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="uts.isd.Customer"%>
<%@page import="uts.isd.Customers"%>
<%@page import="uts.isd.AccessLog"%>
<%@page import="uts.isd.AccessLogs"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="login.jsp"%>

<%
    String filePath = application.getRealPath("WEB-INF/accessLog.xml"); //Link to XML file
    Customer customer = (Customer) session.getAttribute("customer"); //Get current session of user
%>

<jsp:useBean id="accessApp" class="uts.isd.AccessLogApplication" scope="application">
    <jsp:setProperty name="accessApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>VIEW ACCESS LOGS</title>
    </head>

    <!-- Link to CSS file -->
    <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>

    <!-- CSS code specifically for this page -->
    <style>
        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 50%;
        }

        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #dddddd;
        }
    </style>

    <body>
        <h1 align="center">Access Logs: <%=customer.getUsername()%></h1> 
        <%
            if (customer != null) { //If the user is logged in
        %>	
        <p align="right">You are logged in as <%=customer.getUsername()%></p>
        
        <!-- code for navigation bar -->
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
                    if (customer.getIsStaff() == true) { //If the user is a staff member
                %>
            <li><a href="addMovie.jsp">Add New Movie</a></li>
                <%
                    }
                %>
            <li style="float:right"><a href="logout.jsp">Logout</a></li>
        </ul>
        <%
        } else {
        %>
        <p align="right">You are not logged in </p>
        <ul>
            <li><a href="main.jsp">Home</a></li>
            <li><a href="browseMovies.jsp">Movie Catalogue</a></li>
            <li style="float:right"><a href="register.jsp">Register</a></li>
            <li style="float:right"><a href="login.jsp">Login</a></li>
        </ul>
        <%
            }
        %>
        <br>
        <table align="center">
            <thead>
                <tr>
                    <th>Login Date/Time</th>
                    <th>Logout Date/Time</th>
                </tr>
            </thead>
            <tbody>
                <%
                    AccessLog currentAccessLog = (AccessLog) session.getAttribute("accessLog"); //Get the current session for access log
                    AccessLogs accessLogs = accessApp.getAccessLogs(); //Get a list of access logs
                    int len = accessLogs.getList().size(); //Get the size of the list of access logs

                    for (int i = 0; i <= len - 1; i++) { //Loop through the list and display all of the access logs which match the user
                        AccessLog accessLog = accessLogs.getAccessLog(i);
                        if (accessLog.getLogoutDate() != accessLog.getLoginDate() && accessLog.getUserID() == currentAccessLog.getUserID()) {
                            SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
                            String formattedLoginDate = formatter.format(accessLog.getLoginDate()); //Modify the dates to be neater for presentation
                            String formattedLogoutDate = formatter.format(accessLog.getLogoutDate());
                %> 
                <tr>
                    <td><%=formattedLoginDate%></td>
                    <td><%=formattedLogoutDate%></td>
                    <td><a href="deleteAccess.jsp?logID=<%=accessLog.getLogID()%>"><u>delete</u></a></td>
                </tr>        
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </body>
</html>
