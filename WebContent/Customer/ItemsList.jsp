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
<title></title>
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
<table style="text-align: left; width: 100%;" border="2" cellpadding="2"
cellspacing="2">
<tbody>
<tr>
<td style="vertical-align: top;">Item ID<br>
</td>
<td style="vertical-align: top;">Item Name<br>
</td>
<td style="vertical-align: top;">Category<br>
</td>
<td style="vertical-align: top;">Auction Start Time<br>
</td>
<td style="vertical-align: top;">Auction End Time<br>
</td>
<td style="vertical-align: top;">Start Price<br>
</td>
<td style="vertical-align: top;">Current Bid<br>
</td>
<td style="vertical-align: top;">Status<br>
</td>
<td style="vertical-align: top;">Item Info<br>
</td>
<td style="vertical-align: top;">Bidders List<br>
</td>
</tr>
<%ResultSet r = null;
try{
r = customer.listMyItems();}
catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }%>
<%while(r.next()){ %>

<tr>
<td style="vertical-align: top;"><%= r.getInt("ITEMID")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("ITEMNAME")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("CATEGORIES")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("STARTDATE").substring(0,10)%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("ENDDATE").substring(0,10)%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("STARTPRICE")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("CURRENTBID")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("STATUS")%><br>
</td>
<td style="vertical-align: top;"><form method="GET" action="ItemInfo.jsp" name="ItemInfo">
<input  style = "color: black" name="ItemInfo" type="hidden" value="<%=r.getInt("ItemID") %>"/>
<button style = "color: black" value="Item Info" name="Item Info">Item Info</button><br>
</form><br>
</td>
<td style="vertical-align: top;"><form method="GET" action="BidderList.jsp" name="BidList">
<input  style = "color: black" name="BidList" type="hidden" value="<%=r.getInt("ItemID") %>"/>
<button style = "color: black" value="BidList" name="BidList">Item Info</button><br>
</form><br>
</tr>
<%} r.close(); %>
</tbody>
</table>
<br>
<form method="post" action="SellingManagement.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>
</body>
</html>