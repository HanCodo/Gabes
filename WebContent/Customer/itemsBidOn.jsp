<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
if(customer.getUsername() == null)
{
	response.sendRedirect("../CustomerLogout_action.jsp");
}
%>
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>My Bids</title>
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
<div style="text-align: center;"><b>My Bid History</b>  <br>
</div>
<br>
<script src="https://www.w3schools.com/lib/w3.js"></script>
<table style="text-align: left; width: 100%;" border="2" cellpadding="2"
cellspacing="2" id ="team2">
   <tr>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(1)')"style="vertical-align: top;"><b>Item ID</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(2)')"style="vertical-align: top;"><b>Item Name</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(3)')"style="vertical-align: top;"><b>Category</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(4)')"style="vertical-align: top;"><b>Bid Date</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(5)')"style="vertical-align: top;"><b>Auction End Time</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(6)')"style="vertical-align: top;"><b>Bid Amount</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(7)')"style="vertical-align: top;"><b>Item Info</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(8)')"style="vertical-align: top;"><b>Winner</b><br></th>


  </tr>
<%ResultSet r = customer.listBidOnItems();
while(r.next()){%>
<tr class = "items">
<td>
<%=r.getInt("ITEMID")
%>
</td>
<td>
<%=r.getString("ITEMNAME")
%>
</td>
<td>
<%=r.getString("CATEGORIES")
%>
</td>
<td>
<%=r.getString("BIDTIME").substring(0,10)
%>
</td>
<td>
<%=r.getString("ENDDATE").substring(0,10)
%>
</td>
<td>
<%="$"+r.getString("MaxBidLimit")
%>
</td>
<td style="vertical-align: top;"><form method="GET" action="ItemInfo.jsp" name="ItemInfo">
<input  style = "color: black" name="ItemInfo" type="hidden" value="<%=r.getInt("ITEMID") %>"/>
<button style = "color: black" value="Item Info" name="Item Info">Item Info</button><br>
</form>
</td>
<td>
<%
String status = r.getString("STATUS");
if (status.equals("ON AUCTION")) {
	
	out.write(status); 
}
else if (status.equals("SOLD")) {
	
	out.write(customer.winner(r.getInt("ITEMID")));
}
else{
	out.write("NONE");
}
%>
</td>
</tr>
<%} %>
</table>
<form method="post" action="CustomerMenu.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"><br>
</form>
</body>
</html>