<%@page import="uts.isd.Customer"%>
<%@page import="uts.isd.Movie"%>
<%@page import="uts.isd.Movies"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String filePath = application.getRealPath("WEB-INF/movies.xml"); //Link to XML
    Customer customer = (Customer) session.getAttribute("customer"); //Get current session of user
%>

<jsp:useBean id="movieApp" class="uts.isd.MovieApplication" scope="application">
    <jsp:setProperty name="movieApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>

<%
    Movies movies = movieApp.getMovies(); //Get a list of all current movies
    int len = movies.getList().size(); //Get the number of movies in the list
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BROWSE MOVIES</title>
    </head>
    <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>
    <body>

        <h1 align="center">Online Movie Catalogue</h1>
        <form action="searchResult.jsp" method="POST">
            <%
                if (customer != null) { //If the user is logged in
            %>	
            <p align="right">You are logged in as <%=customer.getUsername()%></p>
            
            <!-- Code for the navigation bar -->
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
            <h1 align="center">Search Movies</h1>

            <!-- Form for the search movie function -->
            <table align="center">
                <tr>
                    <td><input name="keyword" placeholder="Search for a movie title..."></td>
                    <td><input type="submit" value="Search Movies"></td>
                </tr>
            </table>
        </form>
        <p>
            <%
                for (int i = 0; i <= len - 1; i++) { //For-loop used to display all the movies in the catalogue
                    Movie movie = movies.getMovie(i);
            %>
        <table align="center">
            <tr>
                <td><a href="details.jsp?movieID=<%=movie.getMovieID()%>"><%=movie.getMovieName()%> (<%=movie.getMovieYear()%>)</a></td>
                <%
                    if (session.getAttribute("customer") != null) { //If a user is logged in
                        if (customer.getIsStaff()) { //If the user is a staff, then they can edit and delete
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
        %>
        </p>
    </body>
</html>
