<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
<tr>
<td>ITEM ID
</td>
<td>ITEM NAME
</td>
<td>CATAGORY
</td>
<td>START DATE
</td>
<td>END DATE
</td>
<td>BUY PRICE
</td>
<td>RATE SELLER
</td>
</tr>
<%ResultSet r = customer.listBidOnItems();
while(r.next()){%>
<tr>
<td>
<%=r.getInt("sell.ITEMID")
%>
</td>
<td>
<%=r.getString("ITEMNAME")
%>
</td>
<td>
<%=r.getString("CATAGORIES")
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
<%=r.getDouble("CURRENTBID")
%>
</td>
<td>
<form method="post" action="RateSeller.jsp" name="Rate">
<input name="ItemID" value=<%=r.getInt("sell.ITEMID")%>><br>
<input style = "color: black" name="Rate" value="Rate" type="submit">
</form>
</td>
</tr>
<%} %>
</table>

</body>
</html>