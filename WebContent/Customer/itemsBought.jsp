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
<title>My Purchases</title>
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
<div style="text-align: center;"><b>My Purchase History</b>  <br>
</div>
<br>
<%
String message = "";
String errorParam = request.getParameter("error");
String itemID = request.getParameter("itemID");
String sellID = request.getParameter("sellID");
if (errorParam != null){
	int error = Integer.parseInt(errorParam);
	if (error == 1){
		message = "You Already Rated That Item!";
		%><div style="text-align: center;color:red;"><%=message %></div><br><%
	}
	else if(error ==2){
		message = "You Already Added this User to your favorites!";
		%><div style="text-align: center;color:red;"><%=message %></div><br><%
	}
}	
if (itemID != null){
	message = "You successfully bought item number "+itemID+"! Don't forget to rate the seller!";
	%><div style="text-align: center; "><%=message %></div><br><%
}

if (sellID != null){
	message = "You added User to your favorites";
	%><div style="text-align: center; "><%=message %></div><br><%
}
	

%>

<script src="https://www.w3schools.com/lib/w3.js"></script>
<table style="text-align: left; width: 100%;" border="2" cellpadding="2"
cellspacing="2" id ="team2">
   <tr>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(1)')"style="vertical-align: top;"><b>Item ID</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(2)')"style="vertical-align: top;"><b>ITEM NAME</b><br></th>
      <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(3)')"style="vertical-align: top;"><b> CATEGORY</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(3)')"style="vertical-align: top;"><b> START DATE</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(4)')"style="vertical-align: top;"><b> END DATE</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(5)')"style="vertical-align: top;"><b>START PRICE</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(6)')" style="vertical-align: top;"><b> BUY PRICE</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(7)')"style="vertical-align: top;"><b> SELLER USERNAME</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(8)')"style="vertical-align: top;"><b>SELLER EMAIL </b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(9)')"style="vertical-align: top;"><b> RATE SELLER</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(10)')"style="vertical-align: top;"><b>ADD TO FAVORITES SELLER</b><br></th>
     

  </tr>
<%ResultSet r = customer.listMyBoughtItems();

while(r.next()){%>
<tr class ="items">
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
<%=r.getDate("STARTDATE")
%>
</td>
<td>
<%=r.getDate("ENDDATE")
%>
</td>
<td>
<%="$"+r.getDouble("STARTPRICE")
%>
</td>
<td>
<%="$"+r.getDouble("CURRENTBID")
%>
</td>
<td>
<%=r.getString("SUSERNAME")
%>
</td>
<td>
<%=r.getString("EMAIL")
%>
</td>
<td>

<form method="post" action="RateSeller.jsp" name="Rate">
<input name="ItemID" value=<%=r.getInt("ITEMID")%> type="hidden">
<input name="ItemName" value=<%=r.getString("ITEMNAME")%> type="hidden">
<input style = "color: black" name="Rate" value="Rate" type="submit">
</form>
</td>
<%ResultSet rs = null;

int i = r.getInt("ITEMID");
	try{
	rs = customer.getSellerId(i);
	}catch(Exception ex){
		out.println("noo");
		}

while(rs.next()){
	%>
<td style="vertical-align: top;"><form method="GET" action="addToFavs_action.jsp" name="Favlist">
<button style = "color: black" value="<%=rs.getInt("SellerID") %>" name="Favlist">Add to Favorites</button><br>
</form><br>
</tr>

<%} }%>
</table>
<form method="post" action="CustomerMenu.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>

</body>
</html>