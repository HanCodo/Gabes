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
<td>MAX BID LIMIT
</td>
<td>BID TIME
</td>
</tr>
<%ResultSet r = customer.listMyItems();
while(r.next()){%>
<tr>
<td>
<%=r.getInt("ITEMID")
%>
</td>
<td>
<%=r.getString("ITEMNAME")
%>
</td>
<td>
<%=r.getDouble("MAXBIDLIMIT")
%>
</td>
<td>
<%=r.getDate("ITEMID")
%>
</td>
</tr>
<%} %>
</table>

</body>
</html>