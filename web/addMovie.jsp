<%@page import="uts.isd.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="login.jsp"%>

<%
    if (session.getAttribute("customer") == null) { //If the user is not logged in, then send them to the login page
        response.sendRedirect("login.jsp");
    }
    Customer customer = (Customer) session.getAttribute("customer"); //Get current session of the user
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADD MOVIE</title>
        <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <h1 align="center">Online Movie Store</h1>
        <form action="addMovieAction.jsp" method="POST">
            <%
                if (customer != null) { //If the customer is logged in
            %>	
            <p align="right">You are logged in as <%=customer.getUsername()%></p>
            <!-- Code for the navigation bar -->
            <ul>
                <li><a href="main.jsp">Home</a></li>
                <li><a href="account.jsp">My Account</a></li>
                    <%
                        if (customer.getIsStaff() == false) { //If the user is a customer and not staff
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
            <h1 align="center">Add New Movie</h1>
            
            <!-- Input form for adding a new movie into the movie catalogue -->
            <table align="center">
                <tr>
                    <td>Movie Name</td>
                    <td><input name="movieName" required></td>
                </tr>
                <tr>
                    <td>Movie Year</td>
                    <td><input name="movieYear" required></td>
                </tr>
                <tr>
                    <td>Movie Price</td>
                    <td><input name="moviePrice" required></td>
                </tr>
                <tr>
                    <td>Movie Stock</td>
                    <td><input name="movieStock" required></td>
                </tr>
                <tr>
                    <td>Movie Poster URL</td>
                    <td><input name="moviePosterURL" required></td>
                </tr>
                <tr>
                    <td>Movie Trailer YouTube URL</td>
                    <td><input name="movieTrailerURL" required></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="ADD MOVIE"></td>
                </tr>
                <tr><td></td><td></td></tr>
                <tr>
                    <td></td>
                    <td><a href="main.jsp">Cancel</a></td>
                </tr>
            </table>
        </form>
    </body>
</html>
