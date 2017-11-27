<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
<jsp:setProperty name="admin" property="*"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title></title>
</head>
<body>
<table style="text-align: left; width: 100%;" border="1" cellpadding="2"
cellspacing="2">
<tbody>
<tr>
<td style="vertical-align: top;">UserID<br>
</td>
<td style="vertical-align: top;">User Name<br>
</td>
<td style="vertical-align: top; width: 253px;">First Name<br>
</td>
<td style="vertical-align: top; width: 245px;">Last Name<br>
</td>
<td style="vertical-align: top; width: 282px;">Password<br>
</td>
<td style="vertical-align: top;">Phone<br>
</td>
<td style="vertical-align: top;">Email<br>
</td>
</tr>
<%try {ResultSet users = admin.viewUsers();
//out.println(users);
while(users.next()){%>
<tr>
<td style="vertical-align: top;"><%try{out.println(users.getString(1));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(users.getString(2));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top; width: 253px;"><%try{out.println(users.getString(3));}catch(Exception ex){out.println("noo");}  %><br>
</td>
<td style="vertical-align: top; width: 245px;"><%try{out.println(users.getString(4));}catch(Exception ex){out.println("noo");}  %><br>
</td>
<td style="vertical-align: top; width: 282px;"><%try{out.println(users.getString(5));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(users.getString(6));}catch(Exception ex){out.println("noo");}  %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(users.getString(7));}catch(Exception ex){out.println("noo");} %><br>
</td>
</tr>
<%} }catch(Exception ex){
	out.println(ex);
	}%>
</tbody>
</table>
<form method="post" action="AddUser.jsp"
name="AddUser"><input style = "color: black" name="AddUser"
value="Add User" type="submit"><br>
</form>

<br>
<br>
</body>
</html>