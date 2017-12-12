<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<% 
if(customer.getUsername() == null)
{
	response.sendRedirect("../CustomerLogout_action.jsp");
}
int change = customer.updateStatuses();
%>
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>Featured Items</title>
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
<div style="text-align: center;"><b>Featured Item</b></div><br>
<%
ResultSet cat = customer.allActiveCategories();
while (cat.next()){
	ResultSet rs = customer.featuredItem(cat.getString("categories"));
	%> 
	<div style="text-align: center;"><b>Featured item in <%=cat.getString("categories") %></b></div>
	<table style="text-align: left; width: 100%;" border="1" cellpadding="2"
cellspacing="2">
<tbody>
	<%
	while(rs.next()){
		ResultSet item = customer.viewItem(""+rs.getInt("ItemID"));
		item.next();
	%>
<tr>
<td style="vertical-align: top; width: 253px; text-align:center;"><%=item.getString("itemName")%><br>
</td>
<td style="vertical-align: top; width: 253px;text-align:center;"><%=item.getInt("ItemID")%><br>
</td>
<td style="vertical-align: top; width: 245px;text-align:center;"><%=item.getDate("enddate")%><br>
</td>
<td style="vertical-align: top; width: 282px;"><%=item.getString("descript")%><br>
</td>
<td style="vertical-align: top; width: 282px;text-align:center;"><%=item.getString("status")%><br>
</td>
<td style="vertical-align: top; text-align: center; width: 282px;">$<%=item.getDouble("currentBid")%>
<form method="post" action="Bid.jsp?i=<%=item.getString(1)%>" name="Bid"><input style = "color: black" name="Bid" value="Bid" type="submit">
</form>
</td>
<td style="vertical-align: top; text-align: center; width: 282px;"><%if(item.getString(10) == null){
	out.println("Buy now not made available by seller");
}else{
	try{out.println("$"+item.getString("buyNow"));}catch(Exception ex){out.println("noo");}%>

<form method="post" action="BuyNow_action.jsp?i=<%=item.getString(1)%>&p=<%=item.getString(10)%>" name="Buynow">
<input style = "color: black" name="BuyNow" value="Buy Now" type="submit"></form></td>

<%		}
	}
	%> 
	</tr>
</tbody>
</table>
<br>
	<%
}%>
<form method="post" action="BiddingManagement.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>
</body>
</html>