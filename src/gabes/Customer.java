package gabes;

import java.io.*;
import java.sql.*;
import oracle.jdbc.*;
//import tdrichmond.companyDB.DatabaseConnection;

public class Customer implements Serializable {

	/**
	   * The following fields correspond to the fields in Table GABeS_CUSTOMER in
	   * GABeS Oracle database
	   */
	private int userID;
	private String username;
	private String pass;
	private String fname;
	private String lname;
	private int phone;
	private String email;

	private PreparedStatement preparedStmt;
	private Statement stmt;
	/**
	* The following stores whether or not the Customer has successfully logged
	* to the System
	*/    
	private boolean loggedIn = false;
		
	public int getUserID() {
		return userID;
	}
		  
	public void setUserID(int userID) {
		this.userID = userID;
	}
	
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

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}

	public int getPhone() {
		return phone;
	}

	public void setPhone(int phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public void setLoggedIn(Boolean loggedIn) {
	    this.loggedIn = loggedIn;
	}
	
	/**
	   * A default constructor for Customer
	   */
	public Customer() {
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
	   * @return whether the Customer is logged in or not
	   */
	  public Boolean isLoggedIn() {
	    return this.loggedIn;
	  }
	  
	  /** When called, this method uses a Statement object to query table ProductDeals_CUSTOMER 
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
	    String queryString = "SELECT c.Username FROM GABES_CUSTOMER c WHERE c.Username = ? and c.Pass = ?";
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
//	    this.setUserID(result.getInt("userID"));
//	    this.setFname(result.getString("fname"));
//	    this.setLname(result.getString("lname"));
//	    this.setEmail(result.getString("email"));
//	    this.setPhone(result.getInt("phone"));
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
	   * shows the items info for a specific itemID
	   * @param itemID
	   * @return
	   * @throws SQLException
	   */
	  public ResultSet showItemInfo(String itemID) throws SQLException {
		  	Connection con = openDBConnection();
		    String queryString = "SELECT *" + "FROM GABES_ITEM" + "WHERE itemID = ?";
		    preparedStmt.setString(1,itemID);
		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    preparedStmt.close();
		    return result;
	  }
	  
	  /**
	   * Retrieves the information for an account to be updated
	   * @return an int representing the number of 
	   * rows affected by the update statement
	   * @throws SQLException
	   */
	  public ResultSet profileInfo() {
		  Connection con = openDBConnection();
	        try{
	            stmt = con.createStatement();
	            String queryString = "SELECT username, fname, lname, email, phone, password, count(overall) as numRatings, avg(overall) as avgRatings" 
	                    + "FROM GABES_CUSTOMER c, GABES_SELL s "
	                    + "WHERE c.UserID='" + this.getUserID()+ "' AND c.UserID = s.UserID"
	                    + "GROUP BY username, fname, lname, email, phone, pass";

	            return stmt.executeQuery(queryString);
	        } catch (Exception E) {
	            E.printStackTrace();
	            return null;
	        }
	  }
	  
	  /**
	   * Updates the information for an account
	   * @return an int representing the number of 
	   * rows affected by the update statement
	   * @throws SQLException
	   */
	  public int updateProfile(){
		  int result = -1;
		  Connection con = openDBConnection();
	        try{
	            stmt = con.createStatement();
	            String queryString = "update irahal.company_employee set " 
	                    + " fname='" + this.getFname() + "',"
	                    + " lname='" + this.getLname() + "',"
	                    + " phone='" + this.getPhone() + "',"
	                    + " email='" + this.getEmail() + "',"
	                    + " username=" + this.getUsername() + "',"
	                    + " pass = '" + this.getPass()+"'"
	                    + " where UserID='" + this.getUserID()+ "'";

	            result = stmt.executeUpdate(queryString);
	            stmt.close();         
	        } catch (Exception E) {
	            E.printStackTrace();
	        }       
	        return result;
	  }
	  
	  /**
	   * Lists items matched to active user
	   * @return result set containing the results of the query
	   * @throws SQLException
	   */
	  public ResultSet listMyItems() throws SQLException {
		  	Connection con = openDBConnection();
		    String queryString = "SELECT c.UserID, i.ItemName, i.Category, i.StartDate, i.EndDate, i.StartPrice " + 
		    		"FROM GABES_CUSTOMER c, GABES_ITEM i, GABES_SELL s " + 
		    		"WHERE c.UserID = s.UserID AND i.ItemID = s.ItemID AND c.UserID = "+this.getUserID()+
		    		"";
		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    preparedStmt.close();
		    return result;
	  }
	  
	  /**
	   * Lists items bid on matched to active user
	   * @return result set containing the results of the query
	   * @throws SQLException
	   */
	  public ResultSet listBidOnItems() throws SQLException {
		  	Connection con = openDBConnection();
		    String queryString = "Select b.ITEMID, it.ITEMNAME,b.MAXBIDLIMIT,b.BIDTIME "+
		    		"FROM GABES_BID b,GABES_ITEM it, GABES_CUSTOMER c "+
		    		"WHERE b.ITEMID = it.ITEMID and b.UserID = c.UserID";

		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    preparedStmt.close();
		    return result;
	  }
}
