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
	private String phone;
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

	public String getPhone(){
		return phone;
	}

	public void setPhone(String phone) {
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
	    String queryString = "SELECT * FROM GABES_CUSTOMER c  WHERE c.Username = ? and c.Pass = ?";
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
	    this.setUserID(result.getInt("userID"));
	    this.setFname(result.getString("fname"));
	    this.setLname(result.getString("lname"));
	    this.setEmail(result.getString("email"));
	    this.setPhone(result.getString("phone"));
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
	            String queryString = "SELECT username, fname, lname, email, phone, pass, count(overall) as numRatings, avg(overall) as avgRatings " 
	                    + "FROM GABES_CUSTOMER c, GABES_SELL s "
	                    + "WHERE c.Username = '"+this.getUsername()+"' AND c.UserID = s.UserID "
	                    + "GROUP BY username, fname, lname, email, phone, pass";

	            
	            ResultSet result = stmt.executeQuery(queryString);
	            result.next();
	            return result;
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
	  public int updateProfile(String username,String fname,String lname,String phone,String email,String pass){
		  int result = -1;
		  Connection con = openDBConnection();
	        try{
	            String queryString = "update GABES_CUSTOMER " 
	                    + " set fname=?,"
	                    + " lname=?,"
	                    + " phone=?,"
	                    + " email=?,"
	                    + " username=?,"
	                    + " pass=?"
	                    + " where userID=?";

	            preparedStmt = con.prepareStatement(queryString);
	            preparedStmt.setString(1,fname);
	            preparedStmt.setString(2,lname);
	            preparedStmt.setString(3,phone);
	            preparedStmt.setString(4,email);
	            preparedStmt.setString(5,username);
	            preparedStmt.setString(6,pass);
	            preparedStmt.setInt(7,(this.getUserID()));
	            result = preparedStmt.executeUpdate();
	            
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
		  	
		    String queryString = "Select i.ITEMID as ITEMID, i.ITEMNAME as ITEMNAME,i.CATEGORIES as CATEGORIES,i.STARTDATE as STARTDATE,i.ENDDATE as ENDDATE,i.STARTPRICE as STARTPRICE, i.CURRENTBID as CURRENTBID,i.status as STATUS " + 
		    		"FROM GABES_CUSTOMER c, GABES_ITEM i, GABES_SELL s " + 
		    		"WHERE c.UserID = s.UserID AND i.ItemID = s.ItemID AND c.UserID = "+this.getUserID()+
		    		"";
		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    
		    return result;
	  }
	  
	  /**
	   * Lists items matched to active user
	   * @return result set containing the results of the query
	   * @throws SQLException
	   */
	  public ResultSet listMyBoughtItems() throws SQLException {
		 
		  	Connection con = openDBConnection();
		  	
		    String queryString = "Select i.ITEMID as ITEMID, i.ITEMNAME as ITEMNAME,i.CATEGORIES as CATEGORIES,i.STARTDATE as STARTDATE,i.ENDDATE as ENDDATE,i.STARTPRICE as STARTPRICE, i.CURRENTBID as CURRENTBID,i.status as STATUS " + 
		    		"FROM GABES_CUSTOMER c, GABES_ITEM i, GABES_SELL s " + 
		    		"WHERE c.UserID = s.UserID AND i.ItemID = s.ItemID AND c.UserID = "+this.getUserID()+" AND i.status = 'SOLD'"+
		    		"";
		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    
		    return result;
	  }
	  
	  /**
	   * Lists items bid on matched to active user
	   * @return result set containing the results of the query
	   * @throws SQLException
	   */
	  public ResultSet listBidOnItems() throws SQLException {
		  	Connection con = openDBConnection();
		    String queryString = "Select b.ITEMID, it.ITEMNAME, c.USERNAME, b.MAXBIDLIMIT, b.BIDTIME "+
		    				"FROM GABES_BID b,GABES_ITEM it, GABES_CUSTOMER c " + 
		    				"WHERE b.ITEMID = it.ITEMID and b.UserID = c.UserID and c.UserID ="+this.getUserID();
		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    
		    return result;
	  }
	  public int addItem(String itemId,String startDate,String endDate,String ItemName,String Descript,String Categories,String startPrice, String buyNow){
		  int result = -1;
		  Connection con = openDBConnection();
	        try{
	            String queryString = "INSERT INTO GABES_ITEM"+
	        "(ItemID, StartDate, EndDate, ItemName, Descript, Categories, StartPrice, Status, CurrentBid, buyNow)"+
	         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	            preparedStmt = con.prepareStatement(queryString);
	            int i = Integer.parseInt(itemId);
	            preparedStmt.setInt(1,i);
	            Date sd = Date.valueOf(startDate);
	            preparedStmt.setDate(2,sd);
	            Date ed = Date.valueOf(endDate);
	            preparedStmt.setDate(3,ed);
	            preparedStmt.setString(4,ItemName);
	            preparedStmt.setString(5,Descript);
	            preparedStmt.setString(6,Categories);
	            double sp = Double.parseDouble(startPrice);
	            double bn = Double.parseDouble(buyNow);
	            preparedStmt.setDouble(7,sp);
	            preparedStmt.setDouble(10,bn);
	            String status = "ON AUCTION";
	            preparedStmt.setString(8,status);
	            preparedStmt.setDouble(9,sp);
	            result = preparedStmt.executeUpdate();
	            preparedStmt.close();
	            this.addSeller(i);
	        } catch (Exception E) {
	            E.printStackTrace();
	        }       
	        return result;
	  }
	  public int addSeller(int itemId){
		  int result = -1;
		  Connection con = openDBConnection();
	        try{
	            String queryString = "INSERT INTO GABES_SELL"+
	        "(UserID, ItemID, Overall, Comments, Quality, Delivery) "+
	         "VALUES (?, ?, null, null, null, null)";

	            preparedStmt = con.prepareStatement(queryString);
	            preparedStmt.setInt(1,this.getUserID());
	            preparedStmt.setInt(2,itemId);
	            result = preparedStmt.executeUpdate();
	            preparedStmt.close();
	        } catch (Exception E) {
	            E.printStackTrace();
	        }       
	        return result;
	  }
	  public ResultSet viewFeedback() throws SQLException{
		  	Connection con = openDBConnection();

		    String queryString = "Select item.itemname as Item_Sold ,sell.quality as Quality,sell.delivery as Delivery, sell.Comments as Buyer_Response "+
		    		"FROM GABES_SELL sell,GABES_ITEM item "+
		    		"WHERE "+this.userID+ "= sell.userid and item.itemId = sell.itemid";


		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    return result;
		 
	  }
	  public ResultSet viewItem(String ItemId) throws SQLException{
		  	Connection con = openDBConnection();
		  	int itemId = Integer.parseInt(ItemId);
		    String queryString = "Select * "+
		    		" From GABES_ITEM "+
		    		" Where "+itemId+ "= GABES_ITEM.itemid ";



		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    return result;
	  }
	  public ResultSet bidInfoList(String itemId) throws SQLException {
		  	Connection con = openDBConnection();
		  	int newId = Integer.parseInt(itemId);
		    String queryString = "Select DISTINCT GABES_CUSTOMER.USERNAME as USERNAME, GABES_BID.MAXBIDLIMIT as MAX_BID, GABES_BID.BIDTIME as BID_TIME "+
    				"FROM GABES_BID,GABES_ITEM, GABES_CUSTOMER " + 
    				"WHERE GABES_BID.ITEMID = "+newId+" and GABES_CUSTOMER.UserID ="+this.userID;
		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    
		    return result;
	  }
	  public ResultSet allItems() throws SQLException {
		  	Connection con = openDBConnection();

		    String queryString = "SELECT * FROM GABES_ITEM";
		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    
		    return result;
	  
}
}


