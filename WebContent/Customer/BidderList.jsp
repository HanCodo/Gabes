<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="customer" class="gabes.Customer" scope="session"/> 
<jsp:setProperty property="*" name="customer"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<td style="vertical-align: top;">Bidding Time<br>
</td>
<td style="vertical-align: top;">Username<br>
</td>
<td style="vertical-align: top;">Max Bid Limit<br>
</td>
</tr>
<%ResultSet r = null;
try{
r = customer.listBidOnItems();}
catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }%>
<%while(r.next()){ %>
<tr>
<td style="vertical-align: top;"><%= r.getDate("BID_TIME")%><br>
</td>
<td style="vertical-align: top;"><%= r.getDate("USERNAME")%><br>
</td>
<td style="vertical-align: top;"><%= r.getDate("MAX_BID")%><br>
</td>
</tr>
<%} r.close(); %>
</tbody>
</table>
<form method="post" action="ItemsList.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>

</body>
</html>