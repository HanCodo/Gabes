<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
    <%@ page language="java" import="java.sql.*, java.text.*,java.sql.Date, gabes.*"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
<jsp:setProperty name="admin" property="*"/>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/>
<% 
if(customer.getUsername() == null)
{
	response.sendRedirect("../CustomerLogout_action.jsp");
}
int change = customer.updateStatuses();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>All Items</title>
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
    	<a href="CustomerMenu.jsp">
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
<div style="text-align:center;"><b>Watch List</b></div>
<br>
<%
String message = "";
String errorParam = request.getParameter("error");
String itemID = request.getParameter("itemID");
String itemID2 = request.getParameter("ItemID");


if (errorParam != null){
	int error = Integer.parseInt(errorParam);
	if (error == 1){
		message = "Removed failed";
		%><div style="text-align: center;color:red;"><%=message %></div><br><%
	}
	else if(error ==2 ){
		message = "Item already in Watch List";
		%><div style="text-align: center;color:red;"><%=message %></div><br><%
	}
}	
if (itemID != null){
	message = "You successfully deleted item number "+itemID+" from your Watch List";
	%><div style="text-align: center; "><%=message %></div><br><%
}
if (itemID2 != null){
	message = "You successfully added item number "+itemID+" from your Watch List";
	%><div style="text-align: center; "><%=message %></div><br><%
}



%>
<%ResultSet items = customer.getItemListforWatch(); %>
<script src="https://www.w3schools.com/lib/w3.js"></script>
<table style="text-align: left; width: 100%;" border="2" cellpadding="2"
cellspacing="2" id ="team2">
   <tr>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(1)')"style="vertical-align: top;"><b>Item ID</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(2)')"style="vertical-align: top;"><b>Auction Start Time</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(3)')"style="vertical-align: top;"><b>Auction End Time</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(4)')"style="vertical-align: top;"><b>Item Name</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(5)')"style="vertical-align: top;"><b>Description</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(6)')"style="vertical-align: top;"><b>Category</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(7)')"style="vertical-align: top;"><b>Status</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(8)')"style="vertical-align: top;"><b>Current Bid</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(8)')"style="vertical-align: top;"><b>Buy Now</b><br></th>
      <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(8)')"style="vertical-align: top;"><b>Remove</b><br></th>

  </tr>
<%while (items.next()){ 
if(items.getString("STATUS").equals("ON AUCTION")){%>
<tr class = "items">
<td><%=items.getInt("ITEMID")%>
</td>
<td><%=items.getDate("STARTDATE")%>
</td>
<td><%=items.getDate("ENDDATE")%>
</td>
<td><%=items.getString("ITEMNAME")%>
</td>
<td><%=items.getString("DESCRIPT")%>
</td>
<td><%=items.getString("CATEGORIES")%>
</td>
<td><%=items.getString("STATUS")%>
</td>
<td><%=items.getDouble("CURRENTBID")%>
<form method="post" action="Bid.jsp?i=<%=items.getInt("ITEMID")%>" name="Bid"><input style = "color: black" name="Bid" value="Bid" type="submit">
</form>
</td>
<td>
<%
if(items.getString(10) == null){
	out.println("Buy now not made available by seller");
}
else{
	try{
		out.println("$"+items.getString("buyNow"));
		}
	catch(Exception ex){
		out.println("noo");
		}
	%>
<form method="post" action="BuyNow_action.jsp?i=<%=items.getInt("ITEMID")%>&p=<%=items.getDouble("BUYNOW")%>" name="Buynow">
<input style = "color: black" name="BuyNow" value="Buy Now" type="submit"></form></td>

<%
}
%>

<td style="vertical-align: top;"><form method="GET" action="RemoveWatchList_action.jsp" name="removeWatch">
<input  style = "color: black" name="removeWatch" type="hidden" value="<%=items.getInt("ITEMID") %>"/>
<button style = "color: black" value="removeWatch" name="removeWatch">Remove from List</button><br>
</form><br>
</td>
<% 
}}%>
</tbody>
</table>
<br>
<form method="post" action="BiddingManagement.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>
</body>
</html>
