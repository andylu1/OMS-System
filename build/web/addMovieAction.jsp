<%@page import="uts.isd.Customer"%>
<%@page import="uts.isd.Movie"%>
<%@page import="uts.isd.Movies"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="login.jsp"%>

<%
    String filePath = application.getRealPath("WEB-INF/movies.xml"); //Link to XML file
    Customer customer = (Customer) session.getAttribute("customer"); //Get current session of the user
%>

<jsp:useBean id="movieApp" class="uts.isd.MovieApplication" scope="application">
    <jsp:setProperty name="movieApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADD MOVIE ACTION</title>
    </head>
    <body>
        <h1>ADD MOVIE ACTION</h1>
        <%
            Movies movies = movieApp.getMovies(); //Get a list of all current movies

            String movieName = request.getParameter("movieName");
            String movieYear = request.getParameter("movieYear");
            int movieID = movieApp.getNewMovieID();
            double moviePrice = Double.parseDouble(request.getParameter("moviePrice"));
            int movieStock = Integer.parseInt(request.getParameter("movieStock"));
            String moviePosterURL = request.getParameter("moviePosterURL");
            String movieTrailerURL = request.getParameter("movieTrailerURL");
            //Make a new Movie object
            Movie movie = new Movie(movieID, movieName, movieYear, moviePrice, movieStock, moviePosterURL, movieTrailerURL);

            movies.addMovie(movie); //Add new movie to the current list of movies
            movieApp.setMovies(movies); //Update the current list of movies with the modified list of movies
            movieApp.updateXML(movies, filePath); //Update the XML file with the updated list of movies
            response.sendRedirect("main.jsp");
        %>
    </body>
</html>
