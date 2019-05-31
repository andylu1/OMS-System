<%@page import="uts.isd.Customer"%>
<%@page import="uts.isd.Movie"%>
<%@page import="uts.isd.Order"%>
<%@page import="uts.isd.Orders"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="login.jsp"%>

<%
    String filePath = application.getRealPath("WEB-INF/orders.xml"); //Link to XML file
    Customer customer = (Customer) session.getAttribute("customer"); //Get current session of user
    Movie movie = (Movie) session.getAttribute("movie"); //Get current session of movie
%>

<jsp:useBean id="orderApp" class="uts.isd.OrderApplication" scope="application">
    <jsp:setProperty name="orderApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>NEW ORDER</title>
    </head>

    <!-- Link to CSS file -->
    <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>
    <link href="css/registationStyle.css" rel="stylesheet" type="text/css"/>

    <body>
        <h1 align="center">Online Movie Store</h1>
        <p align="right">You are logged in as <%=customer.getUsername()%></p>
        <!-- code for the navigation bar -->
        <ul>
            <li><a href="main.jsp">Home</a></li>
            <li><a href="account.jsp">My Account</a></li>            
            <li><a href="viewOrders.jsp">My Orders</a></li>       
            <li><a href="browseMovies.jsp">Movie Catalogue</a></li>           
            <li style="float:right"><a href="logout.jsp">Logout</a></li>
        </ul> 
        <%
            int orderID = orderApp.getNewOrderID(); //Generate a new order ID
%>
        <h1 align="center">Create New Order</h1>

        <!-- Form to create a new order -->
        <form action="newOrderAction.jsp" method="POST">
            <table align="center">
                <tr>
                    <td>Order ID:</td>
                    <td><input name="orderID" value="<%=orderID%>" readonly></td>
                </tr>
                <tr>
                    <td>Customer Name:</td>
                    <td><input value="<%=customer.getName()%>" readonly></td>
                </tr>
                <tr>
                    <td>Movie Name:</td>
                    <td><input value="<%=movie.getMovieName()%> (<%=movie.getMovieYear()%>)" readonly></td>
                </tr>
                <tr>
                    <td>Order Quantity:</td>
                    <td><input type="number" name="orderQuantity"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Create Order"></td>
                </tr>
                <tr><td></td><td></td></tr>
                <tr>
                    <td></td>
                    <td><a href="details.jsp?movieID=<%=movie.getMovieID()%>">Cancel</a></td>
                </tr>
            </table>
        </form>
    </body>
</html>