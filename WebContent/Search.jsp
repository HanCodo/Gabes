<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
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
<td style="vertical-align: top;">ItemID<br>
</td>
<td style="vertical-align: top;">Start Date<br>
</td>
<td style="vertical-align: top; width: 253px;">End Date<br>
</td>
<td style="vertical-align: top; width: 245px;">Item Name<br>
</td>
<td style="vertical-align: top; width: 282px;">Item Description<br>
</td>
<td style="vertical-align: top;">Category<br>
</td>
<td style="vertical-align: top;">Status<br>
</td>
<td style="vertical-align: top;">Current Bid<br>
</td>
</tr>
<%try {ResultSet users = admin.search(1, "null", "null", "null", "null", "null", "null", "null");
System.out.println(users);
while(users.next()){%>
<tr>
<td style="vertical-align: top;"><%try{out.println(users.getString(1));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(users.getString(2));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top; width: 253px;"><%try{out.println(users.getString(4));}catch(Exception ex){out.println("noo");}  %><br>
</td>
<td style="vertical-align: top; width: 245px;"><%try{out.println(users.getString(5));}catch(Exception ex){out.println("noo");}  %><br>
</td>
<td style="vertical-align: top; width: 282px;"><%try{out.println(users.getString(3));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(users.getString(6));}catch(Exception ex){out.println("noo");}  %><br>
</tr>
<%} }catch(Exception ex){
	out.println(ex);
	}%>
</tbody>
</table>
</body>
</html>