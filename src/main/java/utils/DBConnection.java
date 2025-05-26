package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String DRIVER_CLASS = ConfigGetter.getProperty("db.driver");
    private static final String USER_NAME = ConfigGetter.getProperty("db.username");;
    private static final String PASSWORD = ConfigGetter.getProperty("db.password");;
    private static final String JDBC_URL = ConfigGetter.getConnectionString();
    //kết nối datebase dùng URL USER_NAME, PASSWORD. Thả ra lỗi 
    
    public static Connection getConnection(){
        Connection con = null;
        try{
            Class.forName(DRIVER_CLASS);
            con = (Connection) DriverManager.getConnection(JDBC_URL, USER_NAME, PASSWORD);
        } catch(SQLException | ClassNotFoundException e) {
            System.out.println(e.getMessage());
        }
        return con;
    }
}
