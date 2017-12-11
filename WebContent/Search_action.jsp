<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
    <%@ page language="java" import="java.sql.*, java.text.*,java.sql.Date, gabes.*"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
<jsp:setProperty name="admin" property="*"/>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>Search Results</title>
<style type="text/css">
.left {
    float: left;
}
.right {
    float: right;
}
</style>
</head>
<body>
<div>
    <div class="left">
    	<a href="Customer/CustomerMenu.jsp">
  			<img style="width:150px;height:42px;border:0;" alt="GABeS_Logo" src="img/gabes.png">
		</a>
	</div>
    <div class="right">
    	<form method="post" action="CustomerLogout_action.jsp" name="logout">
    		Logged in as: <%=customer.getUsername()%> <input style = "text-align: right; color: black" name="Logout" value="Logout" type="submit">
    	</form>
    </div>
</div>
<br>
<br>
<br>
<div style="text-align:center;"><b>Search Results</b></div>
<br>
<table style="text-align: left; width: 100%;" border="1" cellpadding="2"
cellspacing="2">
<tbody>
<tr>
<td style="vertical-align: top;"><b>ItemID</b><br>
</td>
<td style="vertical-align: top;"><b>Start Date</b><br>
</td>
<td style="vertical-align: top; width: 253px;"><b>End Date</b><br>
</td>
<td style="vertical-align: top; width: 245px;"><b>Item Name</b><br>
</td>
<td style="vertical-align: top; width: 282px;"><b>Item Description</b><br>
</td>
<td style="vertical-align: top;"><b>Category</b><br>
</td>
<td style="vertical-align: top;"><b>Status</b><br>
</td>
<td style="vertical-align: top;"><b>Current Bid</b><br>
</td>
<td style="vertical-align: top;"><b>Buy Now</b><br>
</td>
</tr>
<%

try {
	String itemID1 = request.getParameter("itemID");
	String bidmin1 = request.getParameter("minbid");
	String bidmax1 = request.getParameter("maxbid");
	
	String sDay = request.getParameter("sDay");
	String sMonth = request.getParameter("sMonth");
	String sYear = request.getParameter("sYear");
	String startDate = sMonth+"/"+sDay+"/"+sYear;
	String eDay = request.getParameter("eDay");
	String eMonth = request.getParameter("eMonth");
	String eYear = request.getParameter("eYear");
	String endDate = eMonth+"/"+eDay+"/"+eYear;
	if(Integer.parseInt(sYear)==0 && Integer.parseInt(sMonth)==0 && Integer.parseInt(sDay)==0 && Integer.parseInt(eYear)==0 && 
			Integer.parseInt(eMonth)==0 && Integer.parseInt(eDay)==0){
		endDate = "";
		startDate = "";
	}else if(Integer.parseInt(eYear)==0 && Integer.parseInt(eMonth)==0 && Integer.parseInt(eDay)==0 && 
			Integer.parseInt(sYear)==0 && Integer.parseInt(sMonth)==0 && Integer.parseInt(sDay)==0){
		endDate = "";
		startDate = "";
	}else if(Integer.parseInt(eYear)!=0 && Integer.parseInt(eMonth)!=0 && Integer.parseInt(eDay)!=0 && 
			Integer.parseInt(sYear)!=0 && Integer.parseInt(sMonth)!=0 && Integer.parseInt(sDay)!=0) {
		
	}
	else{
		response.sendRedirect("Search.jsp?error=5");
	}
	Date startDate1 = null;
	if(startDate.trim().length() > 0){
		DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		try {
		    java.util.Date startDate2 = df.parse(startDate);
		    startDate1 = new java.sql.Date(startDate2.getTime());
		   
		} catch (Exception e) {
		    e.printStackTrace();
		    response.sendRedirect("Search.jsp?error=3");
		}
	}
	//String endDate = request.getParameter("endDate");
	Date endDate1 = null;
	if(startDate.trim().length() > 0){
		DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		try {
		    java.util.Date startDate2 = df.parse(endDate);
		    endDate1 = new java.sql.Date(startDate2.getTime());
		   
		} catch (Exception e) {
		    e.printStackTrace();
		    response.sendRedirect("Search.jsp?error=3");
		}
	}
	
	int itemID = -1;
	int bidmin = -1;
 	int bidmax = -1;
	if(itemID1.trim().length() > 0) {
	itemID = Integer.parseInt(itemID1);
	}
	if(bidmin1.trim().length() > 0) {
		bidmin = Integer.parseInt(bidmin1);
		if(bidmin < 0){
			bidmin = 0;
		}
	}
	if(bidmax1.trim().length() > 0) {
		bidmax = Integer.parseInt(bidmax1);
	}
	String itemName = request.getParameter("itemName");
	String keyword = request.getParameter("keyword");
	String category = request.getParameter("category");
	/*System.out.println(category);
	System.out.println(keyword);
	System.out.println(startDate1);
	System.out.println(endDate1);
	System.out.println("id"+itemID);
	System.out.println("bidmin"+bidmin);
	System.out.println("bidmax"+bidmax);*/
	if(itemName.trim().length() == 0) {
		itemName = null;
	}
	//System.out.println(keyword);
	//System.out.println(itemID + ", "+ keyword+ ", " + category + ", "+ bidmin+ ", " + bidmax +", " + startDate1+" ," + endDate1+", " + itemName);
	ResultSet users = customer.search(itemID, keyword, category, bidmin, bidmax, startDate1, endDate1, itemName);
	//System.out.println(users);

	//ResultSet users = customer.allItems();

if(users == null){
	response.sendRedirect("Search.jsp?error=4");
}
else{
	int x = 0;
while(users.next()){  x++; %>
<tr>
<td style="vertical-align: top;"><%try{out.println(users.getString(1));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(users.getString(2).substring(0,10));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top; width: 253px;"><%try{out.println(users.getString(3).substring(0,10));}catch(Exception ex){out.println("noo");}  %><br>
</td>
<td style="vertical-align: top; width: 245px;"><%try{out.println(users.getString(4));}catch(Exception ex){out.println("noo");}  %><br>
</td>
<td style="vertical-align: top; width: 282px;"><%try{out.println(users.getString(5));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(users.getString(6));}catch(Exception ex){out.println("noo");}  %><br>
</td>
<td style="vertical-align: top; width: 282px;"><%try{out.println(users.getString(8));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top; text-align: center; width: 282px;">$<%try{out.println(users.getString(9));}catch(Exception ex){out.println("noo");} %>
<form method="post" action="Customer/Bid.jsp?i=<%=users.getString(1)%>" name="Bid"><input style = "color: black" name="Bid" value="Bid" type="submit">
</form>
</td>
<td style="vertical-align: top; text-align: center; width: 282px;"><%if(users.getString(10) == null){
	out.println("Buy now not made available by seller");
}else{
	try{out.println("$"+users.getString(10));}catch(Exception ex){out.println("noo");}%>

<form method="post" action="Customer/BuyNow_action.jsp?i=<%=users.getString(1)%>&p=<%=users.getString(10)%>" name="Buynow">
<input style = "color: black" name="BuyNow" value="Buy Now" type="submit"></form></td>
</tr>
<%}}
if(x==0){
	response.sendRedirect("Search.jsp?error=2");
}

} }catch(java.lang.NumberFormatException e){
	response.sendRedirect("Search.jsp?error=1");
	//e.printStackTrace();
} catch(Exception ex){
	ex.printStackTrace();
	}%>
</tbody>
</table>
<form method="post" action="Search.jsp" name="Search">
<input style = "color: black" name="BacktoSearch" value="Back To Search" type="submit"><br>
</form>
</body>
</html>