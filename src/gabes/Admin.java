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

import oracle.jdbc.OracleTypes;

public class Admin {
	
	private String username;
	private String pass;
	
	private CallableStatement callStmt;
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
	    	return this.isLoggedIn();
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
		    //preparedStmt.close();
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
	  //String queryString = "SELECT  it.Categories, it.ItemID, it.itemname, it.currentBid as FinalSellingPrice, (it.currentBid  * 0.05) as Commission" + 
	  //		"FROM GABES_Item it, GABES_Bid B" + 
	  //		"WHERE it.ItemID = b.ItemID" + 
	  //		"GROUP BY Categories, it.ItemID, it.itemname" + 
	  //		"ORDER BY Categories, ItemID";   
		  String queryString = "Select * From GABES_REPORT1";
		  stmt = con.createStatement();
		  ResultSet result = stmt.executeQuery(queryString);
		  
		  //stmt.close();
		  return result;
	  }
	  
	  
	  public ResultSet viewReport2(){
		  try {
			  Connection con = openDBConnection();
//	  	String queryString = "SELECT c.UserID, c.Username, c.FName, c.LName, c.Email, AVG (se.Overall) as rating, (it.currentBid  * 0.05) AS Commission" + 
//	  		"FROM GABES_CUSTOMER c, GABES_BID b, GABES_SELL se" + 
//	  		"WHERE c.UserID = b.UserID and  c.UserID =  se.UserID" + 
//	  		"Group by c.UserID, c.Username, c.FName, c.LName, c.Email";   
			  String queryString = "SELECT *"+
					  "FROM GABES_REPORT2";
			  stmt = con.createStatement();
			  ResultSet result = stmt.executeQuery(queryString);
		  
			  //stmt.close();
			  return result;
		  
		  }
		  catch (Exception E) {
			  E.printStackTrace();
			  return null;
		  }   
	  }
	  
	  public ResultSet search(int ItemID, String keyword, String category, double bidMin, double bidMax, 
			  Date startTime, Date endTime, String itemName) {
		  try {
			  //System.out.println("test");
			  Connection con = openDBConnection();
			  String statementString = "{?= call GABES_Search(?,?,?,?,?,?,?,?)}";
			  						   
			  //stmt = con.createStatement();  
			  callStmt = con.prepareCall(statementString);
			  //System.out.println("test2");
			  //stmt=con.prepareCall ("{?= call GABES_Search(?, ?, ?, ?, ?, ?, ?, ?)}");
			  //System.out.println("test3");
			  callStmt.setInt(2,ItemID);
			  //System.out.println("Test 4");
			  callStmt.setString(3,keyword);
			  //System.out.println("Test 5");
			  callStmt.setString(4,itemName);
			  callStmt.setString(5,category);
			  callStmt.setDouble(6,bidMin);
			  callStmt.setDouble(7,bidMax);
			  callStmt.setDate(8,startTime);
			  callStmt.setDate(9,endTime);
			  //System.out.println("Test 6");
			  //callStmt.registerOutParameter(1, Types.REF_CURSOR);
			  //callSt.registerOutParameter(2, Types.ResultSet);
			  callStmt.registerOutParameter(1, OracleTypes.CURSOR);
			  //System.out.println("Test 7");
			  callStmt.execute();
			  //System.out.println("Test 8");
			  ResultSet result = (ResultSet)callStmt.getObject(1); 
			//  System.out.println(result);
			  return result;
		    	
		 // ResultSet result = stmt.executeQuery(queryString);
	  
		  //stmt.close();
		  //return result;
		  }catch(Exception ex) {
			  ex.printStackTrace();
			  return null;
		  }
	  }
}
