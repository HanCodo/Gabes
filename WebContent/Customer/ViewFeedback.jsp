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
<td style="vertical-align: top;">Item Name<br>
</td>
<td style="vertical-align: top;">Quality<br>
</td>
<td style="vertical-align: top;">Delivery<br>
</td>
<td style="vertical-align: top;">Buyer Response<br>
</td>
</tr>
<%ResultSet r = null;
try{
r = customer.viewFeedback();}
catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }%>
<%while(r.next()){ %>

<tr>
<td style="vertical-align: top;"><%= r.getString("Item_Sold")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("Quality")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("Delivery")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("Buyer_Response")%><br>
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