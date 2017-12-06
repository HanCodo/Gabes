<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
<jsp:setProperty name="admin" property="*"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title></title>
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
<% 
String message = "";
String errorParam = request.getParameter("error");
if (errorParam != null){
	int error = Integer.parseInt(errorParam);
	if (error == 1){
		message = "Please Enter Valid Values";
	}else if(error == 2){
		message = "no results found for your request";
	}else if(error == 3){
		message = "please use correct date format MM/DD/YYYY";
	}
}
%>
<div style="color: red; text-align: center;"><%=message%></div><br>
<form method="post" action="Search_action.jsp" name="Search">
ItemID: <input name="itemID"><br>
Keyword: <input name="keyword"><br>
Category: <input name="category"><br>
Item Name: <input name="itemName"><br>
Minimum Price: <input name="minbid"><br>
Maximum Price: <input name="maxbid"><br>
Start Date: <input name="startDate"><br>
End Date: <input name="endDate"><br>
<input style = "color: black" name="Confirm" value="Confirm" type="submit"><br>
</form>
<br>
</body>
</html>