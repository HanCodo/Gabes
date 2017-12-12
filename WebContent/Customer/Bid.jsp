<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="customer" class="gabes.Customer" scope="session"/> 
<jsp:setProperty property="*" name="customer"/>
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
<title>Bid</title>
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
<div style = "text-align: center"><b>Bid</b></div>
<br>
<%ResultSet r = null;
int itemid = 0;
try{
r = customer.bidInfo(request.getParameter("i"));}
catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }%>
<%while(r.next()){ 
itemid = r.getInt("ITEMID");
String message = "You have "+ customer.timeleft(itemid) + " days left to bid on this item ";%>
<div style="text-align: center;"><b></b> <%=message %></div><br>
<div style="text-align: center;"><b>Leading Bidder:</b> <%=r.getString("Username") %></div><br>
<table style="text-align: left; width: 100%;" border="2" cellpadding="2"
cellspacing="2">
<tbody>
<tr>
<td style="vertical-align: top;"><b>Item ID</b><br>
</td>
<td style="vertical-align: top;"><b>Item Name</b><br>
</td>
<td style="vertical-align: top;"><b>Category</b><br>
</td>
<td style="vertical-align: top;"><b>Auction End Time</b><br>
</td>
<td style="vertical-align: top;"><b>Current Bid</b><br>
</td>
</tr>
<tr>
<td style="vertical-align: top;"><%= r.getInt("ITEMID")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("ITEMNAME")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("CATEGORIES")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("ENDDATE").substring(0,10)%><br>
</td>
<td style="vertical-align: top;"><%= "$"+r.getString("CURRENTBID")%><br>
</td>
</tr>
<%} r.close(); %>
</tbody>
</table>
<br>
<form method="post" action="Bid_action.jsp?i=<%=itemid%>"
name="Return"><div style="color: red; text-align: center;"><input name="bidprice"><input style = "color: black" name="Bid"
value="Max Bid Limit" type="submit"></div></form>
<form method="post" action="../Search.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>
</body>
</html>