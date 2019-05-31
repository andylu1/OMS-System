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
        <title>CANCEL ORDER</title>
    </head>
    <body>
        <h1>Cancel Order</h1>
        <%
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            boolean orderCancel = true;
            Order newOrder = new Order(); //Create an empty Order object
            Orders orders = orderApp.getOrders(); //Get a list of all orders
            Order order = orders.getExactOrder(orderID); //Find the exact order with a matching ID
            int movieID = order.getOrderMovieID();
            int orderQuantity = order.getOrderQuantity();
            Movie movie = movieApp.getMovies().getExactMovie(movieID); //Find the Movie object that matches ID

            int newStock = movie.getMovieStock() + orderQuantity; //Calculate the new movie stock amount
            //Create a new Movie object with the same values except for newStock
            Movie stockChangedMovie = new Movie(movie.getMovieID(), movie.getMovieName(), movie.getMovieYear(), movie.getMoviePrice(), newStock, movie.getMoviePoster(), movie.getMovieTrailer());
            Movies movies = movieApp.getMovies(); //Get a list of all current movies

            for (int i = 0; i <= movies.getList().size() - 1; i++) { //For-loop to go through all movies
                Movie movie1 = movies.getMovie(i);
                if (movie1.getMovieID() == movie.getMovieID()) {
                    movies.removeMovie(movie1); //remove the movie which has a matching ID
                }
            }

            movies.addMovie(stockChangedMovie); //Add the stock updated movie to the list
            movieApp.setMovies(movies); //update the list of movies
            movieApp.updateXML(movies, filePath); //update the XML file

            for (int i = 0; i <= orders.getList().size() - 1; i++) { //For-loop to go through all orders
                Order order1 = orders.getOrder(i);
                if (order1.getOrderID() == orderID) {
                    //Populate the empty object with values escept for cancelled property
                    newOrder = new Order(orderID, order1.getOrderQuantity(), order1.getOrderMovieID(), order1.getOrderCustomerID(), orderCancel, order1.getOrderDate());
                    orders.removeOrder(order1); //remove the order which matches ID
                }
            }

            orders.addOrder(newOrder); //Add the cancelled order to the list of orders
            orderApp.setOrders(orders); //Update the list of orders
            orderApp.updateXML(orders, filePath); //Update the XML file
            response.sendRedirect("viewOrders.jsp");
        %>
    </body>
</html>
