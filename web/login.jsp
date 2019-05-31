<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("customer") != null) { //If a user is already logged in, then take them to the main/home page
        response.sendRedirect("main.jsp");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LOGIN</title>
    </head>

    <!-- Link to the CSS files -->
    <link href="css/NavMainPage.css" rel="stylesheet" type="text/css"/>
    <link href="css/logincss.css" rel="stylesheet" type="text/css"/>

    <body>
        <h1 align="center">Online Movie Store</h1>
        <p align="right">You are not logged in </p>
        
        <!-- code for the navigation bar -->
        <ul>
            <li><a href="main.jsp">Home</a></li>            
            <li><a href="browseMovies.jsp">Movie Catalogue</a></li>           
            <li style="float:right"><a href="register.jsp">Register</a></li>
        </ul> 
        <h1 align="center">Login</h1>
        
        <!-- Form for logging in with username and password -->
        <form action="loginAction.jsp" method="POST">
            <table align="center">
                <tbody>
                    <tr>
                        <td><label for="">Username</label></td>
                        <td><input name="username" type="text" value=""></td>
                    </tr>
                    <tr>
                        <td><label for="">Password</label></td>
                        <td><input name="password" type="password" value=""></td>
                    </tr>
                    <tr>
                        <td><label></label></td>
                        <td><input type="submit" value="Login"></td>
                    </tr>
                </tbody>
            </table>
        </form>
    </body>
</html>

