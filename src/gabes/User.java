package gabes;
import java.text.*;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;

public class User {
	private CallableStatement callStmt;
	private PreparedStatement preparedStmt;
	private Statement stmt;
	
	public User() {
	}
	
	/**
	   * This method and creates and returns a Connection object to the database. 
	   * All other methods that need database access should call this method.
	   * @return a Connection object to Oracle
	   */
	public Connection openDBConnection() {
	    try {
	      // Load driver and link to driver manager
	      Class.forName("oracle.jdbc.OracleDriver");
	      // Create a connection to the specified database
	      Connection myConnection = DriverManager.getConnection("jdbc:oracle:thin:@//cscioraclesrv.ad.csbsju.edu:1521/" +
	                                                            "csci.cscioraclesrv.ad.csbsju.edu","TEAM2", "dkrt");
	      return myConnection;
	    } catch (Exception E) {
	      E.printStackTrace();
	    }
	    return null;
	  }
	
	public int numUsers() throws SQLException{
	  	Connection con = openDBConnection();
	    String queryString = "SELECT COUNT(*) as number FROM GABES_CUSTOMER";
	    preparedStmt = con.prepareStatement(queryString);
	    ResultSet result = preparedStmt.executeQuery();
	    return result.getInt("number");
  }
  
	
	/**
	 * This inserts the users information into the database and waits the apporval of an Admin
	 * 
	 * @param userID
	 * @param Username
	 * @param pass
	 * @param fname
	 * @param lname
	 * @param phone
	 * @param Email
	 * @return
	 * @throws SQLException
	 */
	public boolean insertUser(String Username, String pass, String fname, String lname, String phone, String Email) throws SQLException{
		  Connection con = openDBConnection();
		  String queryString = "INSERT INTO GABES_NEWCUS (USERID, USERNAME, PASS, FNAME, LNAME, PHONE, EMAIL) "
		  		+ "VALUES (?, ?, ?, ?, ?, ?, ?)";   
		  preparedStmt = con.prepareStatement(queryString);
		  preparedStmt.setString(1,""+this.numUsers()+1);
		  preparedStmt.setString(2, Username);
		  preparedStmt.setString(3, pass);
		  preparedStmt.setString(4, fname);
		  preparedStmt.setString(5, lname);
		  preparedStmt.setString(6, phone);
		  preparedStmt.setString(7, Email);
		  ResultSet result = preparedStmt.executeQuery();
		  
		  preparedStmt.close();
		  if(result.next()){
		    	return true;
		    }
		    else{
		    	return false;
		    }
		  
	  }
}
