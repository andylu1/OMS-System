<%@page import="java.util.ArrayList"%>
<%@page import="uts.isd.Movie"%>
<%@page import="uts.isd.Movies"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="login.jsp"%>

<%
    String filePath = application.getRealPath("WEB-INF/movies.xml"); //Link to the XML file
%>

<jsp:useBean id="movieApp" class="uts.isd.MovieApplication" scope="application">
    <jsp:setProperty name="movieApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DELETE MOVIE</title>
    </head>
    <body>
        <h1>DELETE MOVIE</h1>
        <%
            int movieID = Integer.parseInt(request.getParameter("movieID"));
            Movies movies = movieApp.getMovies(); //Get a list of all the current movies

            for (int i = 0; i <= movies.getList().size() - 1; i++) { //Loop through and remove the matching movie
                Movie movie1 = movies.getMovie(i);
                if (movie1.getMovieID() == movieID) {
                    movies.removeMovie(movie1);
                }
            }
            movieApp.setMovies(movies); //Update the list of movies
            movieApp.updateXML(movies, filePath); //Update the XML file
            response.sendRedirect("browseMovies.jsp");
        %>
    </body>
</html>
