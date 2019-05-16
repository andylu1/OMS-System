<%-- 
    Document   : login.jsp
    Created on : 18/04/2019, 3:01:34 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <h1>Login</h1>
        <form action="loginAction.jsp" method="POST">
        <table>
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
                <td><label for=""></label></td>
                <td><input type="submit" value="Login"></td>
           </tr>
        </tbody>
        </table>
        <% String username = request.getParameter("username"); %>
        <% String password = request.getParameter("password"); %>
        </form>
    </body>
</html>
