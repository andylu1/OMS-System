<%@page import="java.util.Date"%>
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
        <title>EDIT ORDER ACTION</title>
    </head>
    <body>
        <h1>EDIT ORDER ACTION</h1>
        <%
            Order order = (Order) session.getAttribute("order"); //Obtain current order session and values
            int orderID = order.getOrderID();
            int orderMovie = order.getOrderMovieID();
            int orderCustomer = order.getOrderCustomerID();
            int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
            boolean orderCancelled = order.getOrderCancelled();
            Date orderDate = order.getOrderDate();

            Movie movie = movieApp.getMovies().getExactMovie(orderMovie); //Get exact movie based on movie ID found in the order

            if (orderQuantity > movie.getMovieStock() + order.getOrderQuantity()) {
                response.sendRedirect("viewOrders.jsp");
            } else {

                int newStock = movie.getMovieStock() + order.getOrderQuantity() - orderQuantity; //If the stock changes, re-calculate the movie stock
                //Make a new Movie object with same values except for amount of stock
                Movie stockChangedMovie = new Movie(movie.getMovieID(), movie.getMovieName(), movie.getMovieYear(), movie.getMoviePrice(), newStock, movie.getMoviePoster(), movie.getMovieTrailer());
                Movies movies = movieApp.getMovies(); //Get a list of all current movies

                for (int i = 0; i <= movies.getList().size() - 1; i++) { //Loop through list of movies and remove movie that has matching ID
                    Movie movie1 = movies.getMovie(i);
                    if (movie1.getMovieID() == movie.getMovieID()) {
                        movies.removeMovie(movie1);
                    }
                }

                movies.addMovie(stockChangedMovie); //Add modified stock movie to the list of movies
                movieApp.setMovies(movies); //Update the list of movies
                movieApp.updateXML(movies, filePath); //Update the XML file

                Order newOrder = new Order(orderID, orderQuantity, orderMovie, orderCustomer, orderCancelled, orderDate); //Create a new order
                Orders orders = orderApp.getOrders(); //Get a list of all orders

                for (int i = 0; i <= orders.getList().size() - 1; i++) { //Loop through and remove the order with a matching ID
                    Order order1 = orders.getOrder(i);
                    if (order1.getOrderID() == orderID) {
                        orders.removeOrder(order1);
                    }
                }
                orders.addOrder(newOrder); //Add into the list the newly created/edited order
                orderApp.setOrders(orders); //Update the list of orders
                orderApp.updateXML(orders, filePath); //Update the XML file

                session.removeAttribute("order"); //Remove no longer needed order session
                response.sendRedirect("viewOrders.jsp");
            }
        %>
    </body>
</html>
