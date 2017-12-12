<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page language="java" import="java.sql.*, java.text.*,java.sql.Date, gabes.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 	
if(customer.isLoggedIn() == false)
{
	response.sendRedirect("../CustomerLogout_action.jsp");
}
int change = customer.updateStatuses();
%>
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>Ending Soon</title>
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
  			<img style="width:150px;height:42px;border:0;" alt="GABeS_Logo" src="../img/gabes.png">
		</a>
	</div>
    <div class="right">
    	<form method="post" action="../CustomerLogout_action.jsp" name="logout">
    		Logged in as: <%=customer.getUsername()%> <input style = "text-align: right; color: black" name="Logout" value="Logout" type="submit">
    	</form>
    </div>
</div>
<br>
<br>
<br>
<div style="text-align:center;"><b>Items Ending Soon</b></div>
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
try{
	String currentDay1 = new java.text.SimpleDateFormat("dd").format(new java.util.Date());
	int curDay1 = Integer.parseInt(currentDay1);
	String currentYear1 = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
	int currentDateInt1= Integer.parseInt(currentYear1);
	String currentMonth1 = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
	int curMonth1 = Integer.parseInt(currentMonth1);
	if(curDay1 < 28){
		curDay1++;
	}else if(curMonth1 == 2 &&  curDay1 == 28){
		curMonth1++;
		curDay1 = 1;
	}else if((curMonth1 == 4 || curMonth1 == 6 || curMonth1 == 9 || curMonth1 == 11)&& curDay1 == 30){
		curMonth1++;
		curDay1 = 1;
	}else if((curMonth1 == 1 ||curMonth1 == 3 || curMonth1 == 5 || curMonth1 == 7 || curMonth1 == 8 ||
			curMonth1 == 10)&& curDay1 == 31){
		curMonth1++;
		curDay1 = 1;
	}else if(curMonth1 == 12 && curDay1 == 31){
		curMonth1 = 1;
		curDay1 = 1;
		currentDateInt1++;
	}else{
		curDay1++;
	}
	String Date = Integer.toString(curMonth1)+"/"+Integer.toString(curDay1)+"/"+Integer.toString(currentDateInt1);
	Date todaysDate = null;
	DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
	try {
	    java.util.Date startDate2 = df.parse(Date);
	    todaysDate = new java.sql.Date(startDate2.getTime());
	   
	} catch (Exception e) {
	    e.printStackTrace();
	    //response.sendRedirect("Search.jsp?error=3");
	}
	ResultSet users = customer.endingSoon(todaysDate);
	//System.out.println(users);

	//ResultSet users = customer.allItems();

if(users == null){
	response.sendRedirect("CustomerMenu.jsp?error=1");
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
<form method="post" action="Bid.jsp?i=<%=users.getString(1)%>" name="Bid"><input style = "color: black" name="Bid" value="Bid" type="submit">
</form>
</td>
<td style="vertical-align: top; text-align: center; width: 282px;"><%if(users.getString(10) == null){
	out.println("Buy now not made available by seller");
}else{
	try{out.println("$"+users.getString(10));}catch(Exception ex){out.println("noo");}%>

<form method="post" action="BuyNow_action.jsp?i=<%=users.getString(1)%>&p=<%=users.getString(10)%>" name="Buynow">
<input style = "color: black" name="BuyNow" value="Buy Now" type="submit"></form></td>
</tr>
<%}}
if(x==0){
	response.sendRedirect("CustomerMenu.jsp?error=1");
}

}
} catch(Exception ex){
	response.sendRedirect("CustomerMenu.jsp?error=1");
	ex.printStackTrace();
	}%>
</tbody>
</table>
<form method="post" action="BiddingManagement.jsp" name="Return">
<input style = "color: black" name="Return" value="Return to Menu" type="submit"><br>
</form>
</body>
</html>