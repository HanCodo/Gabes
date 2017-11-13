package gabes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Admin {
	
	private String username;
	private String pass;
	
	private PreparedStatement preparedStmt;
	private Statement stmt;
	/**
	* The following stores whether or not the Admin has successfully logged
	* to the System
	*/    
	private boolean loggedIn = false;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	
	public void setLoggedIn(Boolean loggedIn) {
	    this.loggedIn = loggedIn;
	}
	
	/**
	   * A default constructor for Admin
	   */
	public Admin() {
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
	  
	  /**
	   * A getter for class field loggedIn
	   * @return whether the Admin is logged in or not
	   */
	  public Boolean isLoggedIn() {
	    return this.loggedIn;
	  }
	  
	  /**
	   ***************************************COMPLETE***************************************
	   * When called, this method uses a Statement object to query table ProductDeals_CUSTOMER 
	   * for the customer whose last name and customer number are stored in class instance
	   * fields last and customerNumber, respectively.
	   * If a match is found, the method sets loggedIn class field to true and 
	   * returns true; otherwise, loggedIn class field is set to false and false is returned 
	   * 
	   * @return true or false based on whether the login information of the customer
	   * stored in class fields last and customerNumber exist in Table ProductDeals_CUSTOMER
	   */
	  public boolean login() throws SQLException {
	    Connection con = openDBConnection();
	    String queryString = "SELECT * FROM GABES_ADMIN a WHERE a.username = ? AND a.pass = ?";
	    preparedStmt = con.prepareStatement(queryString);
	    preparedStmt.clearParameters();  
	    preparedStmt.setString(1,this.getUsername());
	    preparedStmt.setString(2,this.getPass());
	    ResultSet result = preparedStmt.executeQuery();
	    if(result.next()){
	    	this.setLoggedIn(true);
	    }
	    else{
	    	this.setLoggedIn(false);
	    }
	    preparedStmt.close();
	    return this.isLoggedIn();
	  }
	  
	  /**
	   * sets loggedIn class field to false
	   * @throws IllegalStateException if then method is called when loggedIn = false
	   */
	  public void logout() throws IllegalStateException {
	    if(! isLoggedIn())
	      throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
	    
	    this.loggedIn = false;
	  }
	  
	  /**
	   * views all users in the database
	   */
	  public ResultSet viewUsers() throws SQLException{
		  	Connection con = openDBConnection();
		    String queryString = "SELECT * FROM GABES_CUSTOMER";
		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    preparedStmt.close();
		    return result;
		  
	  }
	  
	  /**
	   * inserts a new user to the database
	   */
	  public boolean insertUser(String userID, String Username, String pass, String fname, String lname, String phone, String Email) throws SQLException{
		  Connection con = openDBConnection();
		  String queryString = "INSERT INTO GABES_CUSTOMER (USERID, USERNAME, PASS, FNAME, LNAME, PHONE, EMAIL) "
		  		+ "VALUES (?, ?, ?, ?, ?, ?, ?)";   
		  preparedStmt = con.prepareStatement(queryString);
		  preparedStmt.setString(1,userID);
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
	  
	  /**
	   * used to view report 1
	   */
	  public ResultSet viewReport1() throws SQLException{
	  Connection con = openDBConnection();  
	  String queryString = "SELECT  it.Categories, it.ItemID, it.itemname, it.currentBid as FinalSellingPrice, (it.currentBid  * 0.05) as Commission" + 
	  		"FROM GABES_Item it, GABES_Bid B" + 
	  		"WHERE it.ItemID = b.ItemID" + 
	  		"GROUP BY Categories, it.ItemID, it.itemname" + 
	  		"ORDER BY Categories ASC, ItemID ASC";   
		  preparedStmt = con.prepareStatement(queryString);
		  ResultSet result = preparedStmt.executeQuery();
		  
		  preparedStmt.close();
		  return result;
		  
		  
	  }
	  
	  
	  public ResultSet viewReport2() throws SQLException{
	  Connection con = openDBConnection();
	  String queryString = "SELECT c.UserID, c.Username, c.FName, c.LName, c.Email, AVG (se.Overall) as rating, (it.currentBid  * 0.05) AS Commission" + 
	  		"FROM GABES_CUSTOMER c, GABES_BID b, GABES_SELL se" + 
	  		"WHERE c.UserID = b.UserID and  c.UserID =  se.UserID" + 
	  		"Group by c.UserID, c.Username, c.FName, c.LName, c.Email";   
		  preparedStmt = con.prepareStatement(queryString);
		  ResultSet result = preparedStmt.executeQuery();
		  
		  preparedStmt.close();
		  return result;
		  
		   
	  }
	  
	  
	  
	  
	  
	  
	
}
