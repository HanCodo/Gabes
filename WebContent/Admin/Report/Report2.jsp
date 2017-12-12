<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
<jsp:setProperty name="admin" property="*"/> 
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
<title>Overall Commision Report</title>
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
<div style="text-align: center;"><b>Overall Commision Report</b><br>
</div>
<br>
<table style="text-align: left; " width="100%">
<tbody>
<tr>
<td style="vertical-align: top;"><b>User ID</b><br>
</td>
<td style="vertical-align: top;"><b>Username</b><br>
</td>
<td style="vertical-align: top;"><b>First Name</b><br>
</td>
<td style="vertical-align: top;"><b>Last Name</b><br>
</td>
<td style="vertical-align: top;"><b>Email</b><br>
</td>
<td style="vertical-align: top;"><b>Seller Rating</b><br>
</td>
<td style="vertical-align: top;"><b>Commisions</b><br>
</td>
</tr>

<%
        	double total = 0.0;
         	ResultSet rs = admin.viewReport2();
            while (rs.next()){
        %>

<tr>
<td style="vertical-align: top;"><%try{out.println(rs.getString(1));}catch(Exception ex){out.println("noo"); } %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(rs.getString(2));}catch(Exception ex){out.println("noo");}%><br>
</td>
<td style="vertical-align: top;"><%try{out.println(rs.getString(3));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(rs.getString(4));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(rs.getString(5));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(rs.getString(6));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println("$"+rs.getDouble(7)); total = total+rs.getDouble(7);}catch(Exception ex){out.println("noo");} %><br>
</td>
</tr>
<%
	}
    rs.close();
    %>
    <tr>
<td><br></td>
<td><br></td>
<td><br></td>
<td><br></td>
<td><br></td>
<td><br></td>
<td>---------------<br></td>
</tr>
<tr>
<td><b>Total Income:</b><br></td>
<td><br></td>
<td><br></td>
<td><br></td>
<td><br></td>
<td><br></td>
<%total = (Math.floor(total * 100) / 100); %>
<td style="vertical-align: top;">$<%=total %><br></td>
</tr>
</tbody>
</table>
<br>
<form method="post" action="../ViewReports.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"><br>
</form>
<br>
<br>
</body>
</html>
