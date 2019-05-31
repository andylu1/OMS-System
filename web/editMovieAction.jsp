<%@page import="uts.isd.Movie"%>
<%@page import="uts.isd.Movies"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="login.jsp"%>

<%
    String filePath = application.getRealPath("WEB-INF/movies.xml"); //Link to XML
%>

<jsp:useBean id="movieApp" class="uts.isd.MovieApplication" scope="application">
    <jsp:setProperty name="movieApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EDIT MOVIE ACTION</title>
    </head>
    <body>
        <h1>EDIT MOVIE ACTION</h1>
        <%
            Movie movie = (Movie) session.getAttribute("movie"); //Get current session of movie
            int movieID = movie.getMovieID();
            String movieName = request.getParameter("movieName");
            String movieYear = request.getParameter("movieYear");
            double moviePrice = Double.parseDouble(request.getParameter("moviePrice"));
            int movieStock = Integer.parseInt(request.getParameter("movieStock"));
            String moviePosterURL = request.getParameter("moviePosterURL");
            String movieTrailerURL = request.getParameter("movieTrailerURL");

            //Create new Movie object with edited values
            Movie newMovie = new Movie(movieID, movieName, movieYear, moviePrice, movieStock, moviePosterURL, movieTrailerURL);
            Movies movies = movieApp.getMovies(); //Get a list of all current movies

            for (int i = 0; i <= movies.getList().size() - 1; i++) { //Loop through and find the matching movie to remove
                Movie movie1 = movies.getMovie(i);
                if (movie1.getMovieID() == movieID) {
                    movies.removeMovie(movie1);
                }
            }
            movies.addMovie(newMovie); //Add in the newly edited/created movie
            movieApp.setMovies(movies); //Update the list of movies
            movieApp.updateXML(movies, filePath); //Update the XML file

            session.removeAttribute("movie"); //Remove the session of the movie because not needed anymore
            response.sendRedirect("browseMovies.jsp");
        %>
    </body>
</html>
