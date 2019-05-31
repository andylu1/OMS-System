<%@page import="uts.isd.Customer"%>
<%@page import="uts.isd.Movie"%>
<%@page import="uts.isd.Movies"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="login.jsp"%>

<%
    String filePath = application.getRealPath("WEB-INF/movies.xml"); //Link to XML
    Customer customer = (Customer) session.getAttribute("customer"); //Get current session of user
%>

<jsp:useBean id="movieApp" class="uts.isd.MovieApplication" scope="application">
    <jsp:setProperty name="movieApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EDIT MOVIE</title>
    </head>
    
    <!-- Link to CSS file -->
    <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>

    <body>
        <%
            int movieID = Integer.parseInt(request.getParameter("movieID"));
            Movie movie = movieApp.getMovies().getExactMovie(movieID); //Get exact movie based on movie ID
            session.setAttribute("movie", movie); //Create a new session for the movie
        %>
        <h1 align="center">Editing: <%=movie.getMovieName()%></h1>
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
        <form action="editMovieAction.jsp" method="POST">
            <h1 align="center">Edit Movie Details</h1>
            <table align="center">
                <tr>
                    <td>Movie Name</td>
                    <td><input name="movieName" value="<%=movie.getMovieName()%>"></td>
                </tr>
                <tr>
                    <td>Movie Year</td>
                    <td><input name="movieYear" value="<%=movie.getMovieYear()%>"></td>
                </tr>
                <tr>
                    <td>Movie Price</td>
                    <td><input name="moviePrice" value="<%=movie.getMoviePrice()%>"></td>
                </tr>
                <tr>
                    <td>Movie Stock</td>
                    <td><input name="movieStock" value="<%=movie.getMovieStock()%>"></td>
                </tr>
                <tr>
                    <td>Movie Poster URL</td>
                    <td><input name="moviePosterURL" value="<%=movie.getMoviePoster()%>"></td>
                </tr>
                <tr>
                    <td>Movie Trailer YouTube URL</td>
                    <td><input name="movieTrailerURL" value="<%=movie.getMovieTrailer()%>"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Update Movie Details"></td>
                </tr>
                <tr><td></td><td></td></tr>
                <tr>
                    <td></td>
                    <td><a href="details.jsp?movieID=<%=movieID%>">Cancel</a></td>
                </tr>
            </table>
        </form>
    </body>
</html>
