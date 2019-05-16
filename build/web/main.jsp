<%@page import="uts.isd.Customer"%>
<%@page import="uts.isd.Movie"%>
<%@page import="uts.isd.Movies"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String filePath = application.getRealPath("WEB-INF/movies.xml");
    Customer customer = (Customer)session.getAttribute("customer");
%>
<jsp:useBean id="movieApp" class="uts.isd.MovieApplication" scope="application">
    <jsp:setProperty name="movieApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>
<%
    Movies movies = movieApp.getMovies();
    int len = movies.getList().size();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Main Page</title>
    </head>
    <body>
        <h1>Main Page</h1>
        <%if (customer != null) {%>	
        <p>You are logged in as <%=customer.getUsername()%> </p>
        <a href="myaccount.jsp">My Account</a><a href="logout.jsp">Logout</a> <a href="createProperty.jsp">Create a new Property</a>
        <%} else {%>
        <p>You are not logged in</p>
        <a href="login.jsp">Login</a> <a href="register.jsp">Register</a>
        <% }%>
        <%
            for (int i = 0; i <= len - 1; i++) {
                Movie movie = movies.getMovie();
        %>
        <table>
            <tr>
                <td><%=movie.getMovieName()%></td>
                <td><%=movie.getYear()%></td>
            </tr>
        </table>
        <%
            }
        %>
    </body>
</html>
