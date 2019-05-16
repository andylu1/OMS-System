package uts.isd;

import java.io.Serializable;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)
public class Movie implements Serializable {
    @XmlElement
    private String moviename;
    @XmlElement
    private String year;

    public Movie(String moviename, String year) {
        this.moviename = moviename;
        this.year = year;
    }

    public Movie() {
    }

    public String getMovieName() {
        return moviename;
    }

    public void setMovieName(String moviename) {
        this.moviename = moviename;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }
}
