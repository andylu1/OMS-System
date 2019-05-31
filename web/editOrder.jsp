<%@page import="uts.isd.Order"%>
<%@page import="uts.isd.Orders"%>
<%@page import="uts.isd.Movie"%>
<%@page import="uts.isd.Movies"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="login.jsp"%>

<%
    String filePath = application.getRealPath("WEB-INF/orders.xml"); //Link to XML file
    String filePath1 = application.getRealPath("WEB-INF/movies.xml"); //Link to XML file
%>

<jsp:useBean id="orderApp" class="uts.isd.OrderApplication" scope="application">
    <jsp:setProperty name="orderApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>

<jsp:useBean id="movieApp" class="uts.isd.MovieApplication" scope="application">
    <jsp:setProperty name="movieApp" property="filePath" value="<%=filePath1%>"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EDIT ORDER</title>
    </head>

    <!-- Link to the CSS file -->
    <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>

    <body>
        <%
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            Order order = orderApp.getOrders().getExactOrder(orderID); //Find exact order based on the order ID
            Movie movie = movieApp.getMovies().getExactMovie(order.getOrderMovieID()); //FInd exact movie based on movie ID
            session.setAttribute("order", order); //Create a session for the order found
        %>
        <h1 align="center">Editing Order Number # <%=order.getOrderID()%></h1>        

        <!-- code for the navigation bar -->
        <ul>
            <li><a href="main.jsp">Home</a></li>            
            <li><a href="account.jsp">My Account</a></li>            
            <li><a href="viewOrders.jsp">My Orders</a></li>       
            <li><a href="browseMovies.jsp">Movie Catalogue</a></li>   
            <li style="float:right"><a href="logout.jsp">Logout</a></li>
        </ul> 

        <!-- Form to change the details of the order -->
        <form action="editOrderAction.jsp" method="POST">
            <h1 align="center">Edit Order Details</h1>
            <table align="center">
                <tr>
                    <td>Order Number</td>
                    <td><input value="<%=order.getOrderID()%>" readonly></td>
                </tr>
                <tr>
                    <td>Ordered Movie</td>
                    <td><input value="<%=movie.getMovieName()%>" readonly></td>
                </tr>
                <tr>
                    <td>Order Quantity</td>
                    <td><input name="orderQuantity" type="number" value="<%=order.getOrderQuantity()%>"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Update Order Details"></td>
                </tr>
            </table>
        </form>
    </body>
</html>
