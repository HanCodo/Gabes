<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
<jsp:setProperty name="admin" property="*"/> 


<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title></title>
</head>
<body>
<div style="text-align: right;">
<form method="post" action="../../AdminLogout_action.jsp" name="logout"><input
style = "color: black" name="Logout" value="Logout" type="submit"></form>
</div>
<div style="text-align: center;">Overall Commision Report<br>
</div>
<br>
<table style="text-align: left; width: 100%;" border="1" cellpadding="2"
cellspacing="2">
<tbody>
<tr>
<td style="vertical-align: top;">User ID<br>
</td>
<td style="vertical-align: top;">Username<br>
</td>
<td style="vertical-align: top;">First Name<br>
</td>
<td style="vertical-align: top;">Last Name<br>
</td>
<td style="vertical-align: top;">Email<br>
</td>
<td style="vertical-align: top;">Seller Rating<br>
</td>
<td style="vertical-align: top;">Commisions<br>
</td>
</tr>

<%
        
         	ResultSet rs = admin.viewReport2();
            while (rs.next()){
        %>

<tr>
<td style="vertical-align: top;"><%=rs.getString("UserID")%><br>
</td>
<td style="vertical-align: top;"><%=rs.getString("Username")%><br>
</td>
<td style="vertical-align: top;"><%=rs.getString("Fname") %><br>
</td>
<td style="vertical-align: top;"><%=rs.getString("Lname") %><br>
</td>
<td style="vertical-align: top;"><%=rs.getString("Email") %><br>
</td>
<td style="vertical-align: top;"><%=rs.getString("rating") %><br>
</td>
<td style="vertical-align: top;"><%=rs.getString("Commision") %><br>
</td>
</tr>
<%
	}
    rs.close();
    %>

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
