<%@page import="uts.isd.Customer"%>
<%@page import="uts.isd.Movie"%>
<%@page import="uts.isd.Movies"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="login.jsp"%>

<%
    String filePath = application.getRealPath("WEB-INF/movies.xml"); //Link to XML file
    Customer customer = (Customer) session.getAttribute("customer"); //Get current session of user
%>

<jsp:useBean id="movieApp" class="uts.isd.MovieApplication" scope="application">
    <jsp:setProperty name="movieApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MOVIE DETAILS</title>
    </head>
    <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>
    <body>
        <h1 align="center">Online Movie Store</h1>
        <%
            int movieID = Integer.parseInt(request.getParameter("movieID"));
            Movie movie = movieApp.getMovies().getExactMovie(movieID); //Find the exact movie based on movie ID
            session.setAttribute("movie", movie); //Make a new session for the movie

            if (customer != null) { //if the customer is logged in
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
        <h1 align="center"><%=movie.getMovieName()%></h1>

        <!-- Form and button to go to page to make a new order -->
        <form action="newOrder.jsp" method="post">
            <table align="center">
                <tr>
                    <td></td>
                    <td><input type="submit" value="Order This Movie"></td>
                </tr>
                <tr>
                    <td>Movie Name:</td>
                    <td><%=movie.getMovieName()%></td>
                </tr>
                <tr>
                    <td>Movie Year:</td>
                    <td><%=movie.getMovieYear()%></td>
                </tr>
                <tr>
                    <td>Movie Price:</td>
                    <td>$<%=movie.getMoviePrice()%></td>
                </tr>
                <tr>
                    <td>Movie Stock:</td>
                    <td><%=movie.getMovieStock()%></td>
                </tr>
                <tr>
                    <td>Movie Poster:</td>
                    <td align="center"><img src="<%=movie.getMoviePoster()%>"</td>
                </tr>
                <tr>
                    <td>Movie Trailer:</td>
                    <td><iframe width="420" height="345" src="<%=movie.getMovieTrailer()%>"></iframe></td>
                </tr>
            </table>
        </form>
    </body>
</html>
