<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("customer") != null) { //If the customer is already logged in, then send them to the main page
        response.sendRedirect("main.jsp");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>REGISTER</title>
    </head>

    <!-- Link to CSS file -->
    <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>
    
    <body align="center">
        <h1 align="center">Online Movie Store</h1>
        <p align="right">You are not logged in </p>
        
        <!-- code for the navigation bar -->
        <ul>
            <li><a href="#home">Home</a></li>
            <li><a href="browseMovies.jsp">Movie Catalogue</a> </li>
            <li style="float:right"><a href="login.jsp">Login</a></li>
        </ul>

        <!-- Form for user registration -->
        <form action="registerAction.jsp" method="POST">
            <h1>Register</h1>
            <p>Please fill in this form to create an account.</p>
            <table align="center">
                <tr>
                    <td>Username</td>
                    <td><input name="username"></td>
                </tr>
                <tr>
                    <td>Email</td>
                    <td><input name="email" required></td>
                </tr>
                <tr>
                    <td>Full name</td>
                    <td><input name="name" required></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td><input type="password" name="password" required></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Register" required></td>
                </tr>
            </table>
            <p>Already have an account? <a href="login.jsp">Sign in</a></p>
        </form>
    </body>
</html>