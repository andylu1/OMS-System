<%@page import="java.text.SimpleDateFormat"%>
<%@page import="uts.isd.Customer"%>
<%@page import="uts.isd.Movie"%>
<%@page import="uts.isd.Movies"%>
<%@page import="uts.isd.Order"%>
<%@page import="uts.isd.Orders"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="login.jsp"%>

<%
    String filePath = application.getRealPath("WEB-INF/orders.xml"); //Link to XML file
    String filePath1 = application.getRealPath("WEB-INF/movies.xml"); //Link to XML file
    Customer customer = (Customer) session.getAttribute("customer"); //Get current session of user
%>

<jsp:useBean id="orderApp" class="uts.isd.OrderApplication" scope="application">
    <jsp:setProperty name="orderApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>

<jsp:useBean id="movieApp" class="uts.isd.MovieApplication" scope="application">
    <jsp:setProperty name="movieApp" property="filePath" value="<%=filePath1%>"/>
</jsp:useBean>

<%
    Movies movies = movieApp.getMovies(); //Get a list of movies
    Orders orders = orderApp.getOrders(); //Get a list of orders
    int len = orders.getList().size(); //Get the number of orders in the list
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SEARCH ORDER RESULTS</title>
    </head>

    <!-- Link to the CSS file -->
    <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>
    
    <!-- CSS code specifically for this page -->
    <style>
        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 70%;
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
        <h1 align="center">Search My Orders</h1>
        <%
            if (customer != null) { //If the user is logged in
        %>	
        <p align="right">You are logged in as <%=customer.getUsername()%></p>
        
        <!-- code for the navigation bar -->
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
        <form action="searchOrders.jsp">
            <h1 align="center">Search Again</h1>
            <table id="unique" align="center">
                <tr>
                    <td><input name="orderNumber" type="number" placeholder="Search order numbers..."><input type="submit" value="Search"></td>
                </tr>
            </table>
        </form>
        <p></p>
        <table align="center">
            <tbody>
                <%
                    int orderNumber = Integer.parseInt(request.getParameter("orderNumber"));
                    boolean resultFound = false; //boolean value will change depending on result
                    for (int i = 0; i <= len - 1; i++) { //Loop through a list of orders and find matching order ID
                        Order order = orders.getOrder(i);
                        if (order.getOrderID() == orderNumber && order.getOrderCancelled() == false) { //Make sure the order is not cancelled
                            resultFound = true; //Change value for later purpose
                            SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
                            String formattedOrderDate = formatter.format(order.getOrderDate()); //Modify format of the date to be neater
                            Movie movie = movies.getExactMovie(order.getOrderMovieID()); //Get exact movie based on movie ID

                %>
                <tr>
                    <td><%=order.getOrderID()%></td>
                    <td><%=movie.getMovieName()%></td>
                    <td><%=order.getOrderQuantity()%></td>
                    <td><%=formattedOrderDate%></td>
                    <td><a href="editOrder.jsp?orderID=<%=order.getOrderID()%>">edit</a></td>
                    <td><a href="cancelOrder.jsp?orderID=<%=order.getOrderID()%>">cancel</a></td>
                </tr>
                <%
                        }
                    }
                    if (resultFound == false) { //If there was no matching result
                %>
            <p align="center">Sorry, there were no results for Order # <%=orderNumber%></p>
            <%
                }

                if (resultFound == true) { //If there is a match in the results
            %>
            <thead>
                <tr>
                    <th>Order Number</th>
                    <th>Movie Ordered</th>
                    <th>Quantity Ordered</th>
                    <th>Date Ordered</th>
                </tr>
            </thead>
            <%
                }
            %>
            </tbody>
        </table>
    </body>
</html>