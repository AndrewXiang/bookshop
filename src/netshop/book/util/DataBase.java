package netshop.book.util;

/**
 * <p>数据库连接专用包 </p>
 * @version 1.0
 */
import java.sql.*;
public class DataBase {
	public Connection conn;
	public Statement stmt;
	public ResultSet rs=null;
	public String sqlStr="";
public Connection connect(){
		 try{
		     Class.forName("com.mysql.jdbc.Driver").newInstance();
		     String url ="jdbc:mysql://localhost:3306/bookshop";
		     conn=DriverManager.getConnection(url,"dbo","dbo");
		     stmt = conn.createStatement ();
		    }catch(Exception ee){
		        System.out.println("connect db error:"+ee.getMessage());
		       }
		  return conn;
	    }
}
