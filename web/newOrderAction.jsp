<%@page import="java.util.Date"%>
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
    Movie movie = (Movie) session.getAttribute("movie"); //Get current session of movie
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
        <title>NEW ORDER ACTION</title>
    </head>
    
    <!-- Link to CSS file -->
    <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>
    
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
            Orders orders = orderApp.getOrders(); //Get a list of all orders
            int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            int orderMovieID = movie.getMovieID();
            int orderCustomerID = customer.getCustomerID();
            Date orderDate = new Date(); //Date when order was created

            if (movie.getMovieStock() > 0 && movie.getMovieStock() >= orderQuantity && orderQuantity > 0) { //If there is enough stock to create an order
                int newStock = movie.getMovieStock() - orderQuantity; //Calculate the new movie stock amount
                //Create a new Movie object with the same details except for the updated stock count
                Movie stockChangedMovie = new Movie(movie.getMovieID(), movie.getMovieName(), movie.getMovieYear(), movie.getMoviePrice(), newStock, movie.getMoviePoster(), movie.getMovieTrailer());
                Movies movies = movieApp.getMovies(); //Get a list of all the current movies

                for (int i = 0; i <= movies.getList().size() - 1; i++) { //Loop through the list and remove the matching ID movie
                    Movie movie1 = movies.getMovie(i);
                    if (movie1.getMovieID() == movie.getMovieID()) {
                        movies.removeMovie(movie1);
                    }
                }

                movies.addMovie(stockChangedMovie); //Add the updated stock movie into the movie list
                movieApp.setMovies(movies); //Update the list of movies
                movieApp.updateXML(movies, filePath); //Update the XML file

                Order order = new Order(orderID, orderQuantity, orderMovieID, orderCustomerID, false, orderDate); //Create a new Order object
                orders.addOrder(order); //Add the new order into the list of orders
                orderApp.setOrders(orders); //Update the list of orders
                orderApp.updateXML(orders, filePath); //Update the XML file
                session.removeAttribute("movie"); //Remove movie session because not needed anymore
                response.sendRedirect("viewOrders.jsp");
            } else {
        %>
        <!-- Message for when there is not enough stock for user to create an order -->
        <h1 align="center">Not Enough Stock</h1>
        <p align="center">Please wait for more stock or try ordering a different movie.</p>
        <p align="center">Click <a href="browseMovies.jsp">here</a> to go back to the catalogue.</p>
        <%
            }
        %>
    </body>
</html>
