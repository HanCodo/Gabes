<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
<jsp:setProperty name="admin" property="*"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 	
if(admin.isLoggedIn() == false)
{
	response.sendRedirect("../../index.jsp");
}
%>
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>Sales Summary Report</title>
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
    	<a href="../AdminMenu.jsp">
  			<img style="width:150px;height:42px;border:0;" alt="GABeS_Logo" src="../../img/gabes.png">
		</a>
	</div>
    <div class="right">
    	<form method="post" action="../../AdminLogout_action.jsp" name="logout">
    		Logged in as: <%=admin.getUsername()%> <input style = "text-align: right; color: black" name="Logout" value="Logout" type="submit">
    	</form>
    </div>
</div>
<br>
<br>
<br>
<div style="text-align: center;"><b>Sales Summary Report</b><br>
</div>
<br>
<table style="text-align: left; width: 100%;">
<tbody>
<tr>
<td style="vertical-align: top;"><b>Category</b><br>
</td>
<td style="vertical-align: top;"><b>Item ID</b><br>
</td>
<td style="vertical-align: top;"><b>Item Name</b><br>
</td>
<td style="vertical-align: top;"><b>Final Selling Price</b><br>
</td>
<td style="vertical-align: top;"><b>Commision</b><br>
</td>
</tr>
<tr>
<%try {ResultSet rs = admin.viewReport1();
String last = "";
double sum = 0.0;
double totalsum = 0.0;
//out.println(users);
while(rs.next()){
	if(!last.equals(rs.getString(1))){
		if(!last.equals("")){
		%>
		<td></td><td></td><td></td><td>--------------</td><td>----------</td></tr><tr>
		<td></td><td></td><td></td><td><b>Subtotal:</b></td><td>$<%=sum %></td></tr><tr><td></td></tr><tr>
		<td style="color:white;">.</td><td></td><td></td><td></td><td></td></tr><tr><td></td></tr><tr>
		<%} totalsum+=sum; sum = 0.0; %>
		<td style="vertical-align: top;">
		<%try{out.println(rs.getString(1));}catch(Exception ex){out.println("noo");} %>
		<br></td>
		<%
	}
	else{
	%>
		<td style="vertical-align: top;"><br>
		</td>
	<%} %>
<td style="vertical-align: top;"><%try{out.println(rs.getString(2));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(rs.getString(3));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println("$"+rs.getString(4));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%sum+=rs.getDouble(5); try{out.println("$"+rs.getString(5));}catch(Exception ex){out.println("noo");} %><br>
</td>
</tr>
<%
last = rs.getString(1);
}
%>
<tr><td></td><td></td><td></td><td>--------------</td><td>----------</td></tr><tr>
<td></td><td></td><td></td><td><b>Subtotal:</b></td><td>$<%=sum %></td></tr><tr><td></td></tr>
<%totalsum+=sum; %>
<tr><td></td><td></td><td></td><td>--------------</td><td>----------</td></tr><tr>
<td></td><td></td><td></td><td><b>Total:</b></td><td>$<%=totalsum %></td></tr><tr><td></td></tr><tr>
<%}catch(Exception ex){
	out.println(ex);
	}%>
</tbody>
</table>
<form method="post" action="../ViewReports.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"><br>
</form>
<br>
<br>
</body>
</html>