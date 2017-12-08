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
<title>My Feeback</title>
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
<div style="text-align: center;"><br>
<b>My Feedback</b><br><br>
</div>
<table style="text-align: left; width: 100%;" border="2" cellpadding="2"
cellspacing="2">
<tbody>
<tr>
<td style="vertical-align: top;"><b>Username</b><br>
</td>
<td style="vertical-align: top;"><b>Item ID</b><br>
</td>
<td style="vertical-align: top;"><b>Item Name</b><br>
</td>
<td style="vertical-align: top;"><b>Overall</b><br>
</td>
<td style="vertical-align: top;"><b>Quality</b><br>
</td>
<td style="vertical-align: top;"><b>Delivery</b><br>
</td>
<td style="vertical-align: top;"><b>Buyer Response</b><br>
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
<td style="vertical-align: top;"><%= r.getString("userName")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("itemid")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("Item_Sold")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("OVERALL")%><br>
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