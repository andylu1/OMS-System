/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd;

import java.io.FileInputStream;
import java.io.IOException;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

public class MovieApplication {

    private String filePath;
    private Movies movies;

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) throws JAXBException, IOException {
        this.filePath = filePath;

        JAXBContext jc = JAXBContext.newInstance(Movies.class);
        Unmarshaller u = jc.createUnmarshaller();

        FileInputStream fin = new FileInputStream(filePath);
        movies = (Movies) u.unmarshal(fin);
        fin.close();

    }

    public Movies getMovies() {
        return movies;
    }

    public void setProperties(Movies movies) {
        this.movies = movies;
    }
}
