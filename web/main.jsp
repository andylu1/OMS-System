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
    Movies movies = movieApp.getMovies(); //Get a list of all movies
    int len = movies.getList().size(); //Get the list number of movies
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OMS SYSTEM</title>
        
    </head>
    
    <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>

     <body>
        <h1 align="center">Online Movie Store</h1>
        <%
            if (customer != null) { //If a user is logged in
        %>	
        <p align="right">You are logged in as <%=customer.getUsername()%></p>
           <ul>
            <li><a href="account.jsp">My Account</a></li>
            <%
                if (customer.getIsStaff() == false) { //If user is not a staff
            %>
            <li><a href="viewOrders.jsp">My Orders</a></li>
            <% 
                }
            %>
            <li><a href="browseMovies.jsp">Movie Catalogue</a></li>
            <%
                if (customer.getIsStaff() == true) { //If user is a staff
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
        <h1 align="center">Recently Added Movies</h1>
        <%
            for (int i = 1; i <= 3; i++) { //Display the latest 3 movies to be added or modified
            Movie movie = movies.getMovie(len - i);
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
    </body>
</html>

