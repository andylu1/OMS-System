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

<%
    Movies movies = movieApp.getMovies(); //Get a list of movies
    int len = movies.getList().size(); //Get the size of the list
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SEARCH MOVIE RESULTS</title>
    </head>
    
    <!-- Link to CSS file -->
    <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>
    
    <body>
        <h1 align="center">Online Movie Store</h1>
        <%
            if (customer != null) { //If the user is logged in
        %>	
        <p align="right">You are logged in as <%=customer.getUsername()%></p>
        
        <!-- code for the navigation bar -->
        <ul>
            <li><a href="main.jsp">Home</a></li>
            <li><a href="account.jsp">My Account</a></li>
                <%
                    if (customer.getIsStaff() == false) { //If the user is not staff
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
        <h1 align="center">Search Movie Results</h1>
        <!-- Form for searching a movie title -->
        <form action="searchResult.jsp">
            <table align="center">
                <tr>
                    <td><input name="keyword" placeholder="Search for a movie title..."></td>
                    <td><input type="submit" value="Search"></td>
                </tr>
            </table>
        </form>
        <p></p>
        <%
            String keyword = request.getParameter("keyword"); //Keyword that the user typed in
            boolean resultFound = false; //Value to be changed later for search purposes
            for (int i = 0; i <= len - 1; i++) { //Loop through the list of movies to try and find a match
                Movie movie = movies.getMovie(i);
                if (movie.getMovieName().toLowerCase().contains(keyword)) { //Make both comparisons lower case to avoid missing results
                    resultFound = true; //change value for later purpose
        %>
        <table align="center">
            <tr>
                <td><a href="details.jsp?movieID=<%=movie.getMovieID()%>"><%=movie.getMovieName()%> (<%=movie.getMovieYear()%>)</a></td>
                <%
                    if (session.getAttribute("customer") != null) { //Check if user is logged in
                        if (customer.getIsStaff()) { //Staff should be able to edit and delete
                %>
                <td><a href="editMovie.jsp?movieID=<%=movie.getMovieID()%>">edit</a></td>
                <td><a href="deleteMovie.jsp?movieID=<%=movie.getMovieID()%>">delete</a></td>
                <%
                        }
                    }
                %>
            </tr>
        </table>
        <%
                }
            }
            if (resultFound == false) { //If a matching movie was not found
        %>
        <p align="center">Sorry, there were no results for "<%=keyword%>"</p>
        <%
            }
        %>
    </body>
</html>
