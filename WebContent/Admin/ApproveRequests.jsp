<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" import="java.util.*, java.sql.*, gabes.*"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
<jsp:setProperty name="admin" property="*"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>Current Account Requests</title>
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
    	<a href="AdminMenu.jsp">
  			<img style="width:150px;height:42px;border:0;" alt="GABeS_Logo" src="../img/gabes.png">
		</a>
	</div>
    <div class="right">
    	<form method="post" action="../AdminLogout_action.jsp" name="logout">
    		Logged in as: <%=admin.getUsername()%> <input style = "text-align: right; color: black" name="Logout" value="Logout" type="submit">
    	</form>
    </div>
</div>
<br>
<br>
<br>
<%String message = "";
if(request.getParameter("status")!=null){
if (request.getParameter("status").equals("0"))
	message = "Request Has Been Denied";
else if(request.getParameter("status").equals("1"))
	message = "Request Has Been Accepted";
else if(request.getParameter("status").equals("2"))
	message = "No changes Made";
}
%>
<br>
<br>
<br>
<div style="color: red; text-align: center;"><%=message%></div><br>
<table style="text-align: left; width: 100%;" border="2" cellpadding="2"
cellspacing="2">
<tr>
<td>Username</td>
<td>First Name</td>
<td>Last Name</td>
<td>Email</td>
<td></td>
</tr>
<%
	ResultSet applicants = admin.viewRequests();
	while(applicants.next()){ %>
	<tr>
	<td><%=applicants.getString("USERNAME")%></td>
	<td><%=applicants.getString("FNAME")%></td>
	<td><%=applicants.getString("LNAME")%></td>
	<td><%=applicants.getString("EMAIL")%></td>
	<td>
	<form method="post" action="ApproveRequests_action.jsp" name="click"><input style = "color: black" name="click" value="Approve" type="submit">
	<input type="hidden" id="whatdo" name="whatdo" value="accept">
	<input type="hidden" id="who" name="who" value="<%=Integer.toString(applicants.getInt("USERID"))%>">
</form>
	<form method="post" action="ApproveRequests_action.jsp" name="click2"><input style = "color: black" name="click2" value="Deny" type="submit">
	<input type="hidden" id="whatdo" name="whatdo" value="deny">
	<input type="hidden" id="who" name="who" value="<%=Integer.toString(applicants.getInt("USERID"))%>">
</form>
	
<% 		
	}
%>

</table>