/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
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

    public void setMovies(Movies movies) {
        this.movies = movies;
    }
    
    public int getNewMovieID(){
        if(movies.getList().size() > 0){
            int max = 0;
            for(Movie movie : movies.getList()){
                if(movie.getMovieID() > max){
                    max = movie.getMovieID();
                }
            }
            return max + 1;
        }
        else{
            return 1;
        }
    }
    
    public void updateXML(Movies movies, String filePath) throws Exception{
        this.movies = movies;
        this.filePath = filePath;
        
        // Sets up the helper classes
        JAXBContext jc = JAXBContext.newInstance(Movies.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        
        // Streams the user data into the xml file
        FileOutputStream fout = new FileOutputStream("/Users/admin/Desktop/OMS-SystemV2/web/WEB-INF/movies.xml");
        m.marshal(movies, fout);
        fout.close();
    }
}
