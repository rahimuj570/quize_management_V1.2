package helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionProvider {
    public static Connection con;
    public static Connection main() {
        try {
            if (con == null || con.isClosed()) {
                try {
                    Class.forName("oracle.jdbc.OracleDriver");
                    con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "c##quize_management", "oracle123");
                    System.out.println("Connected to Oracle DB!");
                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println(e + "~~~from ConnectionProvider Class; line 14");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return con;
    }
}
