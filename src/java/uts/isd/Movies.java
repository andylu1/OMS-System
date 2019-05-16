package uts.isd;

import java.util.*;
import java.io.Serializable;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "movies")
public class Movies implements Serializable {

    @XmlElement(name = "movie")
    private ArrayList<Movie> list = new ArrayList<Movie>();

    public ArrayList<Movie> getList() {
        return list;
    }

    public void addMovie(Movie movie) {
        list.add(movie);
    }

    public void removeMovie(Movie movie) {
        list.remove(movie);
    }
    
    public Movie getMovie(int i) {
        return list.get(i);
    }

    public Movie getMovie() {
        for (Movie movie : list) {
            return movie;
        }
        return null;
    }
}
