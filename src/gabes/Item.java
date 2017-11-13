package gabes;

import java.io.*;
import java.sql.*;
import oracle.jdbc.*;

public class Item implements Serializable {
	
	private int itemID;
	private String itemName;
	private Date startDate;
	private Date endDate;
	private String descript;
	private String categories;
	private double startPrice;
	private String status;
	private double currentBid;
	
	private PreparedStatement preparedStmt;
	private Statement stmt;
	
	public int getItemID() {
		return itemID;
	}

	public void setItemID(int itemID) {
		this.itemID = itemID;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getDescript() {
		return descript;
	}

	public void setDescript(String descript) {
		this.descript = descript;
	}

	public String getCategories() {
		return categories;
	}

	public void setCategories(String categories) {
		this.categories = categories;
	}

	public double getStartPrice() {
		return startPrice;
	}

	public void setStartPrice(double startPrice) {
		this.startPrice = startPrice;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public double getCurrentBid() {
		return currentBid;
	}

	public void setCurrentBid(double currentBid) {
		this.currentBid = currentBid;
	}

	/**
	   * A default constructor for Customer
	   */
	public Item() {
		this.setCurrentBid(this.getStartPrice());
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
	   * Lists the bidders who have been active on the implied item
	   * @return result set containing the results of the query
	   * @throws SQLException
	   */
	public ResultSet showBidderList() throws SQLException {
		Connection con = openDBConnection();
	    String queryString = "SELECT b.BidTime, c.Username, b.MaxBidLimit, i.StartDate, i.EndDate"
	    		+"FROM GABES_BID b, GABES_CUSTOMER c, GABES_ITEM i"
	    		+"WHERE b.ItemID = "+this.getItemID()+" AND b.UserID = c.USERID";
	    preparedStmt = con.prepareStatement(queryString);
	    ResultSet result = preparedStmt.executeQuery();
	    preparedStmt.close();
	    return result;
	}
}
