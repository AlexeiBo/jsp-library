package beans;

import database.DBconnection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class GenreList {
    private static ArrayList<Genre> genreArrayList = new ArrayList<>();
    private static Connection connection;
    private static Statement statement;
    private static ResultSet resultSet;

    public GenreList() {
    }

    private ArrayList<Genre> getGenres(String query){
        try{
            connection = DBconnection.getDBconnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery(query);
            while (resultSet.next()){
                Genre genre = new Genre();
                genre.setId(resultSet.getLong("id"));
                genre.setName(resultSet.getString("name"));
                genreArrayList.add(genre);
            }
        }catch (SQLException e){
            Logger.getLogger(GenreList.class.getName()).log(Level.SEVERE, null, e);
        }finally {
            try{
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            }catch (SQLException e){
                Logger.getLogger(GenreList.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return genreArrayList;
    }

    public ArrayList<Genre> getGenreList(){
        if (genreArrayList.isEmpty()){
            return getGenres("SELECT * FROM genre");
        }else {
            return genreArrayList;
        }
    }
}
