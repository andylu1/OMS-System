package uts.isd;

import java.io.Serializable;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)
public class Movie implements Serializable {
    @XmlElement(name="movieID")
    private int movieID;
    @XmlElement(name="movieName")
    private String movieName;
    @XmlElement(name="movieYear")
    private String movieYear;
    @XmlElement(name="moviePrice")
    private double moviePrice;
    @XmlElement(name="movieStock")
    private int movieStock;
    @XmlElement(name="moviePosterURL")
    private String moviePosterURL;
    @XmlElement(name="movieTrailerURL")
    private String movieTrailerURL;

    public Movie(int movieID, String movieName, String movieYear, double moviePrice, int movieStock, String moviePosterURL, String movieTrailerURL) {
        this.movieID = movieID;
        this.movieName = movieName;
        this.movieYear = movieYear;
        this.moviePrice = moviePrice;
        this.movieStock = movieStock;
        this.moviePosterURL = moviePosterURL;
        this.movieTrailerURL = movieTrailerURL;
    }

    public Movie() {
    }
    
    public int getMovieID() {
        return movieID;
    }
    
    public void setMovieID(int movieID) {
        this.movieID = movieID;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public String getMovieYear() {
        return movieYear;
    }

    public void setMovieYear(String movieYear) {
        this.movieYear = movieYear;
    }
    
    public double getMoviePrice() {
        return moviePrice;
    }
    
    public void setMoviePrice(double moviePrice) {
        this.moviePrice = moviePrice;
    }
    
    public int getMovieStock() {
        return movieStock;
    }
    
    public void setMovieStock(int movieStock) {
        this.movieStock = movieStock;
    }
    
    public String getMoviePoster() {
        return moviePosterURL;
    }
    
    public void setMoviePoster(String moviePosterURL) {
        this.moviePosterURL = moviePosterURL;
    }
    
    public String getMovieTrailer() {
        return movieTrailerURL;
    }
    
    public void setMovieTrailer(String movieTrailerURL) {
        this.movieTrailerURL = movieTrailerURL;
    }
}
