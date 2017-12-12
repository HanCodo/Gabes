package gabes;

import java.io.*;
import java.sql.*;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.temporal.ChronoUnit;
import java.time.LocalDate;

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
		
	
	/* getter for customer field UserID 
	 * @returns int userID
	 * */
	public int getUserID() {
		return userID;
	}
	
	/* setter for customer field UserID  
	 * @param Int userID
	 * */
	public void setUserID(int userID) {
		this.userID = userID;
	}
	
	/* getter for customer field username 
	 * @returns String username
	 * */
	public String getUsername() {
		return username;
	}
	
	/* setter for customer field username  
	 * @param String username
	 * */
	public void setUsername(String username) {
		this.username = username;
	}

	/* getter for customer field pass  
	 * @returns String pass
	 * */
	public String getPass() {
		return pass;
	}

	/* setter for customer field pass  
	 * @param String pass
	 * */
	public void setPass(String pass) {
		this.pass = pass;
	}

	/* getter for customer field fname   
	 * @returns String fname
	 * */
	public String getFname() {
		return fname;
	}

	/* setter for customer field fname  
	 * @param String fname
	 * */
	public void setFname(String fname) {
		this.fname = fname;
	}

	/* getter for customer field lname  
	 * @returns String lname
	 * */
	public String getLname() {
		return lname;
	}

	/* setter for customer field lname  
	 * @param String lname
	 * */
	public void setLname(String lname) {
		this.lname = lname;
	}

	/* getter for customer field phone 
	 * @returns String phone
	 * */
	public String getPhone(){
		return phone;
	}

	/* setter for customer field phone  
	 * @param String phone
	 * */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/* getter for customer field email  
	 * @returns String email
	 * */
	public String getEmail() {
		return email;
	}

	/* setter for customer field email  
	 * @param String email
	 * */
	public void setEmail(String email) {
		this.email = email;
	}
	
	/* setter for customer field loggedIn 
	 * @param boolean loggedIn
	 * */
	public void setLoggedIn(Boolean loggedIn) {
	    this.loggedIn = loggedIn;
	}
	
	/**
	   * A getter for class field loggedIn
	   * @return whether the Customer is logged in or not
	   */
	  public Boolean isLoggedIn() {
	    return this.loggedIn;
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
		  	
		    String queryString = "Select i.ITEMID as ITEMID, i.ITEMNAME as ITEMNAME,i.CATEGORIES as CATEGORIES,i.STARTDATE as STARTDATE,i.ENDDATE as ENDDATE,i.STARTPRICE as STARTPRICE, i.CURRENTBID as CURRENTBID,i.status as STATUS,s.USERID as USERID " + 
		    		"FROM GABES_CUSTOMER c, GABES_ITEM i, GABES_SELL s " + 
		    		"WHERE c.UserID = s.UserID AND i.ItemID = s.ItemID AND c.UserID = "+this.getUserID()+" "+
		    		"ORDER BY ENDDATE DESC, i.itemID desc";
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
	  
	  /**
	   * inserts new item into SQL database based on the parameters provided
	   * @param String itemId
	   * @param String startDate
	   * @param String endDate
	   * @param String ItemName
	   * @param String Descript
	   * @param String Categories
	   * @param String startPrice
	   * @param String buyNow
	   * @return int number of rows inserted
	   * @throws SQLException
	   */
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
	            if(Descript.equals(null)) {
	            	String descript ="No Description";
	            preparedStmt.setString(5,descript);
	            }
	            else {
	            	 preparedStmt.setString(5,Descript);
	            }
	            if(Categories.equals(null)) {
	            	String categ ="No Category";
	            preparedStmt.setString(6,categ);
	            }
	            else {
	            	preparedStmt.setString(6,Categories);
	            }
	            
	            double sp = Double.parseDouble(startPrice);
	            preparedStmt.setDouble(7,sp);
	            if(buyNow.isEmpty()) {

		            preparedStmt.setNull(10,java.sql.Types.INTEGER);
	            }
	            else {
	            double bn = Double.parseDouble(buyNow);
	            preparedStmt.setDouble(10,bn);
	            }
	            
	            
	            String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	            if(startDate.equals(currentDate)) {
	            String status = "ON AUCTION";
	            preparedStmt.setString(8,status);
	            }
	            else {
	            String status = "OFF AUCTION";
	            preparedStmt.setString(8,status);
	            }
	            preparedStmt.setDouble(9,sp);
	            result = preparedStmt.executeUpdate();
	            preparedStmt.close();
	            this.addSeller(i);
	        } catch (Exception E) {
	            E.printStackTrace();
	        }       
	        return result;
	  }
	  
	  /**
	   * adds a sell relation to a given ItemID
	   * @param int itemId
	   * @return int number of rows inserted
	   * @throws SQLException
	   */
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
	  
	  /**
	   * retrieves all feedback for customer
	   * @return ResultSet with all feedback for provided user
	   * @throws SQLException
	   */
	  public ResultSet viewFeedback() throws SQLException{
		  	Connection con = openDBConnection();
		    String queryString = "Select c.USERNAME as userName, i.itemID as itemID, i.itemname as Item_Sold , s.overall as OVERALL, s.quality as Quality, s.delivery as Delivery, s.Comments as Buyer_Response "+
		    		"FROM GABES_SELL s, GABES_ITEM i, GABES_CUSTOMER c, GABES_Winners w "+
		    		"WHERE c.userID = w.userID and s.UserID ="+this.userID+" and i.itemId = s.itemid and w.itemID = i.itemID and i.status='SOLD'";

		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    return result;
		 
	  }
	  
	  /**
	   * given an itemID, it returns all the information in relation item 
	   * associated to that ID
	   * @param String itemId
	   * @return ResultSet of information for given ItemID
	   * @throws SQLException
	   */
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
	  
	  /**
	   * retrieves all necessary info for bid page given an itemID
	   * @param String itemId
	   * @return ResultSet containing all necessary info
	   * @throws SQLException
	   */
	  public ResultSet bidInfoList(String itemId) throws SQLException {
		  	Connection con = openDBConnection();
		  	int newId = Integer.parseInt(itemId);
		    String queryString = "Select DISTINCT c.USERNAME as USERNAME, b.MAXBIDLIMIT as MAX_BID, b.BIDTIME as BID_TIME "+
    				"FROM GABES_BID b,GABES_ITEM i, GABES_CUSTOMER c " + 
    				"WHERE b.ITEMID = "+newId+" and c.UserID = b.UserID";
		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    
		    return result;
	  }
	  
	  /**
	   * Returns a ResultSet of all items in the database
	   * @return ResultSet containing all items in the database
	   * @throws SQLException
	   */
	  public ResultSet allItems() throws SQLException {
		  	Connection con = openDBConnection();

		    String queryString = "SELECT * FROM GABES_ITEM";
		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
		    
		    return result;
	  
	  }
	  
	  /**
	   * For given itemID and buynow price, this function adds a bid relation
	   * for the item with the customers ID and the price they commited to paying
	   * @param int itemID for item that is being bid on
	   * @param double price that item was bid on
	   * @return ResultSet containing bid relation added
	   * @throws SQLException
	   */
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
	  
	  /**
	   * For given itemID and buynow price, this function updates the status of
	   * the item to sold, updates the end date to the current date, updates
	   * the currentBid to that final selling price, and creates a bid 
	   * relation with the user to ensure they are credited as the winner
	   * of the auction
	   * @param int itemID for item that is being bought now
	   * @param double price that item was bought now
	   * @return ResultSet containing all items in cat that have most bids
	   * @throws SQLException
	   */
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
	            preparedStmt.setDate(2,date1);
	            preparedStmt.setInt(3,itemId);
	            
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
	  public ResultSet winnerInfo(String itemID) throws SQLException {
		  	Connection con = openDBConnection();

		    String queryString = "SELECT * FROM GABES_CUSTOMER c, GABES_WINNERS w "
		    		+"WHERE c.USERID = w.USERID  and w.ITEMID = "+itemID+"";
		    preparedStmt = con.prepareStatement(queryString);
		    ResultSet result = preparedStmt.executeQuery();
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
		    int over = result.getInt("OVERALL");
		    if(over > 0)
		    	return true;
		    return false;
	  }
	  
	  /**
	   * retrieves all information of the bid given an itemID
	   * @param String itemId
	   * @return ResultSet containing all information of the bid
	   * @throws SQLException
	   */
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
	  
	  /**
	   * For a certain category, finds the most popular item based on number of 
	   * bids it has received.
	   * @param String category in which to find featured item
	   * @return ResultSet containing all items in cat that have most bids
	   * @throws SQLException
	   */
	  public ResultSet featuredItem(String cat) throws SQLException{
		  	Connection con = openDBConnection();
		    String queryString = "Select i.itemID " + 
		    		"from gabes_item i, gabes_bid b " + 
		    		"where i.categories = ? and i.itemID = b.itemID and i.status = 'ON AUCTION' " + 
		    		"group by i.itemID " + 
		    		"having count(b.itemID) >= (select max(count(b.itemID)) AS mostBids " + 
		    		"    from gabes_item i, gabes_bid b " + 
		    		"    where i.itemID = b.itemID and i.status = 'ON AUCTION' " + 
		    		"    group by b.itemID)";

		    preparedStmt = con.prepareStatement(queryString);
		    preparedStmt.setString(1,cat);

		    ResultSet result = preparedStmt.executeQuery();
		    return result;
	  }

	  /**
	   * search function to find all items in the database related to the search
	   * terms provided
	   * @param int ItemID
	   * @param String keyword
	   * @param String category
	   * @param double bidMin
	   * @param double bidMax
	   * @param Date startTime
	   * @param Date endTime
	   * @param String itemName
	   * @return ResultSet containing the product of our search given the terms
	   * entered by the user
	   * @throws SQLException
	   */
	  public ResultSet search(int ItemID, String keyword, String category, double bidMin, double bidMax, 
		  Date startTime, Date endTime, String itemName) {
		  try {
			 // System.out.println(ItemID + ", "+ keyword+ ", " + category + ", "+ bidMin+ ", " + bidMax +", " + startTime+" ," + 
		   //endTime+", " + itemName);
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
	 
	  /**
	   * finds all items ending either today or tomorrow
	   * @param Date todaysDate
	   * @return ResultSet containing all items ending either today or tomorrow
	   * @throws SQLException
	   */
    public ResultSet endingSoon(Date todaysDate) {
    	 try {
			  Connection con = openDBConnection();
			  String statementString = "{?= call GABES_EndingSoon(?)}";
			  callStmt = con.prepareCall(statementString);
			  callStmt.setDate(2,todaysDate);
			  callStmt.registerOutParameter(1, OracleTypes.CURSOR);
			  //System.out.println("Test 7");
			  callStmt.execute();
			  //System.out.println("Test 8");
			  ResultSet result = (ResultSet)callStmt.getObject(1); 
			  return result;
		  }catch(Exception ex) {
			  ex.printStackTrace();
			  return null;
		  }
    }

	  /**
	   * Finds a list of all categories which have an item currently being sold
	   * @return ResultSet containing all active categories
	   * @throws SQLException
	   */
	public ResultSet allActiveCategories() throws SQLException {
		Connection con = openDBConnection();
	    String queryString = "Select distinct i.categories "+
	    		" From GABES_ITEM i, GABES_BID b"+
	    		" Where i.status = 'ON AUCTION' and i.itemID = b.itemID";
	
	
	
	    preparedStmt = con.prepareStatement(queryString);
	    ResultSet result = preparedStmt.executeQuery();
	    return result;
	}
	
	  /**
	   * When called, checks all on auction items to see if their end date has
	   * been reached, and updates them accordingly using a case clause
	   * @return int num rows affected
	   * @throws SQLException
	   */
	public int updateStatuses() throws SQLException {
		Connection con = openDBConnection();
		String mydate = new SimpleDateFormat("MM/dd/yyyy").format(new java.util.Date());
		java.sql.Date date1 = null;
		if(mydate.trim().length() > 0){
		  	DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		  	try {
		  	    java.util.Date date2 = df.parse(mydate);
		  	    date1 = new java.sql.Date(date2.getTime());
		  	   
		  	} 
		  	catch (Exception e) {
		  	}
		}
	    String queryString = "UPDATE GABES_ITEM "+
	    		"SET status = "+
	    		"(CASE "+
	    		"WHEN currentBid > startPrice THEN 'SOLD' "+
	    		"ELSE 'OFF AUCTION' "+
	    		"END "+
	    		") "+
	    		"WHERE status = 'ON AUCTION' and endDate <= ?";
	
	    preparedStmt = con.prepareStatement(queryString);
	    preparedStmt.setDate(1,date1);
	    int result = preparedStmt.executeUpdate();
	    return result;
	
	}
	public long timeleft(int itemID) {
		try{
			Connection con = openDBConnection();
			String currentDay1 = new java.text.SimpleDateFormat("dd").format(new java.util.Date());
			int curDay1 = Integer.parseInt(currentDay1);
			String currentYear1 = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
			int currentDateInt1= Integer.parseInt(currentYear1);
			String currentMonth1 = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
			int curMonth1 = Integer.parseInt(currentMonth1);
			String Date = Integer.toString(curMonth1)+"/"+Integer.toString(curDay1)+"/"+Integer.toString(currentDateInt1);
			Date todaysDate = null;
			DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
			String queryString = "Select i.endDate " + 
		    		"from gabes_item i "+ 
		    		"where i.itemID = ? ";
		    
			preparedStmt = con.prepareStatement(queryString);
		    preparedStmt.setInt(1, itemID);

		    ResultSet result = preparedStmt.executeQuery();
		    result.next();
		    Date date =  result.getDate(1);
		    
			
			try {
			    java.util.Date startDate2 = df.parse(Date);
			    todaysDate = new java.sql.Date(startDate2.getTime());
			    
			} catch (Exception e) {
			    e.printStackTrace();
			    System.out.println("test2");
			    //response.sendRedirect("Search.jsp?error=3");
			}
			long days = ChronoUnit.DAYS.between(LocalDate.parse(todaysDate.toString()),LocalDate.parse(date.toString()));
			return days;
		}catch(Exception ex) {
			ex.printStackTrace();
			return 0;
		}

		
	}
	public ResultSet allFollowers() throws SQLException {
		Connection con = openDBConnection();
	    String queryString = "Select c.USERNAME as Name, f.FollowID as SellerID"+
	    		" From GABES_CUSTOMER c, GABES_FOLLOWS f"+
	    		" Where f.FollowID = c.USERID and f.MainID = "+this.userID;
	
	
	
	    preparedStmt = con.prepareStatement(queryString);
	    ResultSet result = preparedStmt.executeQuery();
	    return result;
	}
	public ResultSet sellerItems(int sellerID) throws SQLException {
		Connection con = openDBConnection();
		String queryString = "SELECT *"+
				" FROM GABES_ITEM i, GABES_SELL s"+ 
				" WHERE s.USERID = "+sellerID+" and i.itemID = s.itemID";
	
	
	
	    preparedStmt = con.prepareStatement(queryString);
	    ResultSet result = preparedStmt.executeQuery();
	    return result;
	}
	public int addFavorites(String SellerID) {
		 int result = -1;
		  Connection con = openDBConnection();
	        try{
	            String queryString = "INSERT INTO GABES_FOLLOWS"+
	        "(MainID, FollowID) "+
	         "VALUES (?, ?)";

	            preparedStmt = con.prepareStatement(queryString);
	            preparedStmt.setInt(1,this.getUserID());
	            int itemId = Integer.parseInt(SellerID);
	            preparedStmt.setInt(2,itemId);
	            result = preparedStmt.executeUpdate();
	            preparedStmt.close();
	        } catch (Exception E) {
	            E.printStackTrace();
	        }       
	        return result;
		
	}
	public ResultSet getSellerId(int itemID) throws SQLException {
		Connection con = openDBConnection();
		String queryString = "SELECT s.USERID as SellerID"+
				" FROM GABES_SELL s"+ 
				" WHERE "+itemID+" = s.itemID";

	    preparedStmt = con.prepareStatement(queryString);
	    ResultSet result = preparedStmt.executeQuery();
	    return result;
	}
	public boolean checkSeller(int sellerID) throws SQLException {
		Connection con = openDBConnection();
		boolean check = false;
		String queryString = "SELECT f.FOLLOWID as SellerID"+
				" FROM GABES_FOLLOWS f"+
				" WHERE f.mainID ="+this.userID;
		
	    preparedStmt = con.prepareStatement(queryString);
	    ResultSet result = preparedStmt.executeQuery();
	    while(result.next()) {
	    	int i = result.getInt("SellerID");
	   
	    	if(i == sellerID) {
	    		check = true;

	    	}

	    }
	    return check;
	}
	public int removeFavSeller(int sellerID) throws SQLException{	
		Connection con = openDBConnection();	
		String queryString ="DELETE FROM gabes_follows f"+
				" WHERE f.mainID ="+this.userID+" and "+sellerID +"=f.followid";
	    preparedStmt = con.prepareStatement(queryString);
	    preparedStmt.execute();
	    preparedStmt.close();
	    return 1;
		
	}

}