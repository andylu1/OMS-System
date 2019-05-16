<%-- 
    Document   : register
    Created on : 18/04/2019, 3:01:34 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
    </head>
    <body>
        <h1>Register an Account</h1>
        <table>
            <tr>
                <td>First Name</td>
                <td><input></td>
            </tr>
            <tr>
                <td>Last Name</td>
                <td><input></td>
            </tr>
            <tr>
                <td>Email Address</td>
                <td><input type="email"></td> <!--Will autocheck if email is in correct format but not perfect-->
            </tr>
            <tr>
                <td>Password</td>
                <td><input type="password"></td> <!--Password security-->
            </tr>
            <tr>
                <td>Mobile Number</td>
                <td><input></td>
            </tr>
            <tr>
                <td>Date of Birth</td>
                <td><input type="date"></td> <!--Input is a date picker which is either text field or GUI-->
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" value="Register"></td> <!--Creates a button with 'Register' on it-->
            </tr>
        </table>
    </body>
</html>
