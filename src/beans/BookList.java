package beans;

import database.DBconnection;
import enums.SearchType;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BookList {
    private Connection connection;
    private Statement statement;
    private ResultSet resultSet;
    private ArrayList<Book> bookArrayList = new ArrayList<>();

    private ArrayList<Book> getBooks(String query){
        try{
            connection = DBconnection.getDBconnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery(query);
            while (resultSet.next()){
                Book book = new Book();
                book.setId(resultSet.getLong("id"));
                book.setName(resultSet.getString("name"));
                book.setPage_count(resultSet.getInt("page_count"));
                book.setIsbn(resultSet.getString("isbn"));
                book.setGenre(resultSet.getString("genre"));
                book.setAuthor(resultSet.getString("author"));
                book.setPublish_year(resultSet.getInt("publish_year"));
                book.setPublisher(resultSet.getString("publisher"));
                book.setImage(resultSet.getBytes("image"));
                book.setDescr(resultSet.getString("descr"));
                book.setRating(resultSet.getInt("rating"));
                book.setVote_count(resultSet.getInt("vote_count"));
                bookArrayList.add(book);
            }
        }catch (Exception e){
            Logger.getLogger(BookList.class.getName()).log(Level.SEVERE, null, e);
        }finally {
            try{
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            }catch (SQLException e){
                Logger.getLogger(BookList.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return bookArrayList;
    }

    public ArrayList<Book> getBookArrayListAll(){
        return getBooks("SELECT b.id, b.name, b.page_count, b.isbn, g.name as genre, a.fio as author, b.publish_year, p.name as publisher, b.image, b.descr, b.rating, b.vote_count FROM book b "
                + "inner join genre g on b.genre_id = g.id "
                + "inner join author a on b.author_id = a.id "
                + "inner join publisher p on b.publisher_id = p.id;");
    }

    public ArrayList<Book> getBookArrayListByGenre(String id){
        int genreId = Integer.valueOf(id);
        return getBooks("SELECT b.id, b.name, b.page_count, b.isbn, g.name as genre, a.fio as author, b.publish_year, p.name as publisher, b.image, b.descr, b.rating, b.vote_count FROM book b "
                        + "inner join genre g on b.genre_id = g.id "
                        + "inner join author a on b.author_id = a.id "
                        + "inner join publisher p on b.publisher_id = p.id "
                        +"where genre_id ="+genreId+";");
    }

    public ArrayList<Book> getBookArrayListByLetter(String letter){
//        char l = letter.charAt(0);
        return getBooks("SELECT b.id, b.name, b.page_count, b.isbn, g.name as genre, a.fio as author, b.publish_year, p.name as publisher, b.image, b.descr, b.rating, b.vote_count FROM book b "
                + "inner join genre g on b.genre_id = g.id "
                + "inner join author a on b.author_id = a.id "
                + "inner join publisher p on b.publisher_id = p.id "
                + "where b.name like'"+letter+"%' order by b.name;");
    }

    public ArrayList<Book> getBookArrayListByText(String searchText, String selectOption){
        String query;
        if (selectOption.equals("Автор")){
            query = "SELECT b.id, b.name, b.page_count, b.isbn, g.name as genre, a.fio as author, b.publish_year, p.name as publisher, b.image, b.descr, b.rating, b.vote_count FROM book b "
                    + "inner join genre g on b.genre_id = g.id "
                    + "inner join author a on b.author_id = a.id "
                    + "inner join publisher p on b.publisher_id = p.id "
                    + "where a.fio like '%"+searchText+"%';";
        }else {
            query = "SELECT b.id, b.name, b.page_count, b.isbn, g.name as genre, a.fio as author, b.publish_year, p.name as publisher, b.image, b.descr, b.rating, b.vote_count FROM book b "
                    + "inner join genre g on b.genre_id = g.id "
                    + "inner join author a on b.author_id = a.id "
                    + "inner join publisher p on b.publisher_id = p.id "
                    + "where b.name like '%"+searchText+"%';";
        }
        return getBooks(query);
    }

}
