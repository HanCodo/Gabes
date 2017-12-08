package gabes;

import java.io.*;
import java.sql.*;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import oracle.jdbc.*;
import java.sql.*;
import java.util.*;
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
	private CallableStatement callStmt;
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
		    		"WHERE c.UserID = s.UserID AND i.ItemID = s.ItemID AND c.UserID = "+this.getUserID()+" "+
		    		"ORDER BY ENDDATE DESC";
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
		  	
//		  	String queryString = "Select i.ITEMID as ITEMID, i.ITEMNAME as ITEMNAME,i.CATEGORIES as CATEGORIES,i.STARTDATE as STARTDATE,i.ENDDATE as ENDDATE,i.STARTPRICE as STARTPRICE, i.CURRENTBID as CURRENTBID,i.status as STATUS, " +
//		    		"c2.USERNAME as SUSERNAME, c2.EMAIL as EMAIL "+
//		    		"FROM GABES_CUSTOMER c, GABES_ITEM i, GABES_SELL s, GABES_CUSTOMER c2 " + 
//		    		"WHERE c.UserID = s.UserID AND i.ItemID = s.ItemID AND c.UserID = "+this.getUserID()+" AND i.status = 'SOLD' "+
//		    		"AND s.USERID = c2.USERID";
//		  	
		  	String queryString = "Select i.ITEMID as ITEMID, i.ITEMNAME as ITEMNAME,i.CATEGORIES as CATEGORIES,i.STARTDATE as STARTDATE,i.ENDDATE as ENDDATE,i.STARTPRICE as STARTPRICE, i.CURRENTBID as CURRENTBID,i.status as STATUS, " +
		    		"c2.USERNAME as SUSERNAME, c2.EMAIL as EMAIL "+
		    		"FROM GABES_CUSTOMER c, GABES_ITEM i, GABES_SELL s, GABES_CUSTOMER c2, GABES_BID b " + 
		    		"WHERE c.UserID = b.UserID AND b.itemID = i.itemID and i.ItemID = s.ItemID and b.maxBidLimit >= i.currentBid AND c.UserID = "+this.getUserID()+" AND i.status = 'SOLD' "+
		    		"AND s.USERID = c2.USERID "+
		    		"ORDER BY i.ENDDATE DESC";
		  	
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
		    String queryString = "Select b.ITEMID, it.ITEMNAME, c.USERNAME, b.MaxBidLimit, it.STATUS, b.BidTime, it.ENDDATE, it.CATEGORIES "+
		    				"FROM GABES_BID b,GABES_ITEM it, GABES_CUSTOMER c " + 
		    				"WHERE b.ITEMID = it.ITEMID and b.UserID = c.UserID and c.UserID ="+this.getUserID()+" "+
		    				"ORDER BY b.BidTime DESC, b.MaxBidLimit DESC";
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
	            java.sql.Date sd = java.sql.Date.valueOf(startDate);
	            preparedStmt.setDate(2,sd);
	            java.sql.Date ed = java.sql.Date.valueOf(endDate);
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

//		    String queryString = "Select c2.USERNAME as userName,item.itemname as Item_Sold ,sell.overall as OVERALL,sell.quality as Quality,sell.delivery as Delivery, sell.Comments as Buyer_Response "+
//		    		"FROM GABES_SELL sell,GABES_ITEM item,GABES_CUSTOMER customer, GABES_CUSTOMER c2"+
//		    		"WHERE "+this.userID+ "= sell.userid and item.itemId = sell.itemid and item.status='SOLD' and sell.userid = customer.userid";

		    String queryString = "Select c.USERNAME as userName, i.itemname as Item_Sold , s.overall as OVERALL, s.quality as Quality, s.delivery as Delivery, s.Comments as Buyer_Response "+
		    		"FROM GABES_SELL s, GABES_ITEM i, GABES_CUSTOMER c, GABES_Winners w "+
		    		"WHERE c.userID = w.userID and s.UserID ="+this.userID+" and i.itemId = s.itemid and w.itemID = i.itemID and i.status='SOLD'";

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
	  public ResultSet bid(int itemId, double price){
		  String mydate = new SimpleDateFormat("MM/dd/yyyy").format(new java.util.Date());
		  java.sql.Date date1 = null;
		  if(mydate.trim().length() > 0){
		  	DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		  	try {
		  	    java.util.Date date2 = df.parse(mydate);
		  	    date1 = new java.sql.Date(date2.getTime());
		  	   
		  	} catch (Exception e) {
		  	}
		  }
		  
		  ResultSet result = null;
		  Connection con = openDBConnection();
	        try{
	            String queryString = "insert into GABES_BID(UserID, ItemID, MaxBidLimit, BidTime) VALUES (?,?,?,?)";

	            preparedStmt = con.prepareStatement(queryString);
	            preparedStmt.setInt(1,this.getUserID());
	            preparedStmt.setInt(2,itemId);
	            preparedStmt.setDouble(3,price);
	            preparedStmt.setDate(4,date1);
	            
	            result = preparedStmt.executeQuery();
	            preparedStmt.close();
	        } catch (Exception E) {
	            E.printStackTrace();
	        }       
	        return result;
	  }
	  
	  
	  public ResultSet buyNow(int itemId, double price){
		  String mydate = new SimpleDateFormat("MM/dd/yyyy").format(new java.util.Date());
		  java.sql.Date date1 = null;
		  if(mydate.trim().length() > 0){
		  	DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		  	try {
		  	    java.util.Date date2 = df.parse(mydate);
		  	    date1 = new java.sql.Date(date2.getTime());
		  	   
		  	} catch (Exception e) {
		  	}
		  }
		  
		  ResultSet result = null;
		  Connection con = openDBConnection();
	        try{
	            String queryString = "insert into GABES_BID(UserID, ItemID, MaxBidLimit, BidTime) VALUES (?,?,?,?)";

	            preparedStmt = con.prepareStatement(queryString);
	            preparedStmt.setInt(1,this.getUserID());
	            preparedStmt.setInt(2,itemId);
	            preparedStmt.setDouble(3,price);
	            preparedStmt.setDate(4,date1);
	            
	            result = preparedStmt.executeQuery();
	            preparedStmt.close();
	        } catch (Exception E) {
	            E.printStackTrace();
	        }  
	        try{
	            String queryString = "update GABES_ITEM " 
	                    + " set currentBid=?, status='SOLD', endDate=?"
	                    + " where itemID=?";

	            preparedStmt = con.prepareStatement(queryString);
	            preparedStmt.setDouble(1,price);
	            preparedStmt.setInt(2,itemId);
	            preparedStmt.setDate(3,date1);
	            
	            result = preparedStmt.executeQuery();
	            preparedStmt.close();
	        } catch (Exception E) {
	            E.printStackTrace();
	        }
	        return result;
	  }
	  
	  /**
	   * Takes a input of itemID which is a int and uses it to find the winner of bid
	   * that winners username is then returned
	   */
	  public String winner(int itemID) throws SQLException {
		  	Connection con = openDBConnection();

		    String queryString = "SELECT c.USERNAME FROM GABES_CUSTOMER c, GABES_WINNERS w "
		    		+"WHERE c.USERID = w.USERID  and w.ITEMID = "+itemID+"";
		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    result.next();
		    String name = result.getString("USERNAME");
		    return name;
	  }
	  /**
	   * Checks if a  item has been rated
	   * @return rated, a boolean
	   */
	  public boolean hasRated(int itemID) throws SQLException {
		  	Connection con = openDBConnection();

		    String queryString = "SELECT OVERALL FROM GABES_SELL s "
		    		+"WHERE ITEMID= "+itemID+"";
		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    result.next();
		    Integer name = result.getInt("OVERALL");
		    if(name != null)
		    	return true;
		    return false;
	  }
	  
	  public ResultSet bidInfo(String ItemId) throws SQLException{
		  	Connection con = openDBConnection();
		  	int itemId = Integer.parseInt(ItemId);
		    String queryString = "Select i.*, c.Username "+
		    		" From GABES_ITEM i, GABES_BID b, GABES_CUSTOMER c "+
		    		" Where "+itemId+ "= i.itemid and b.itemID = i.itemID and b.maxBidLimit > i.currentBid and c.UserID = b.UserID";



		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    return result;
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


