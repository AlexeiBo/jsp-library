package database;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


public class DBconnection {
    private static InitialContext initialContext;
    private static Connection connection;
    private static DataSource dataSource;

    public static Connection getDBconnection(){
        try{
            initialContext = new InitialContext();
            dataSource = (DataSource) initialContext.lookup("library");
//            dataSource = (DataSource) initialContext.lookup("libraryspring");
            connection = dataSource.getConnection();
        }catch (SQLException e){
            Logger.getLogger(DBconnection.class.getName()).log(Level.SEVERE, null, e);
        }catch (NamingException e){
            Logger.getLogger(DBconnection.class.getName()).log(Level.SEVERE, null, e);
        }
        return connection;
    }
}
