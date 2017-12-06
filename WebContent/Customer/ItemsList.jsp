<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="customer" class="gabes.Customer" scope="session"/> 
<jsp:setProperty property="*" name="customer"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table style="text-align: left; width: 100%;" border="1" cellpadding="2"
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
<td style="vertical-align: top;"><%= r.getString("STARTDATE")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("ENDDATE")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("STARTPRICE")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("CURRENTBID")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("STATUS")%><br>
</td>
<td style="vertical-align: top;"><form method="GET" action="ItemInfo.jsp" name="ItemInfo">
<input name="ItemInfo" type="hidden" value="<%=r.getInt("ItemID") %>"/>
<button value="Item Info" name="Item Info">Item Info</button><br>
</form><br>
</td>
<td style="vertical-align: top;"><form method="post" action="BidderList.jsp">  <input name="Bidder List"
value="Bidder List" type="submit"></form><br>
</td>
</tr>
<%} r.close(); %>
</tbody>
</table>
<br>
<form method="post" action="CustomerMenu.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>
</body>
</html>