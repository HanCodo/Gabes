<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>User Log In</title>
</head>
<body>
<a href="index.jsp">
  <img style="width:150px;height:42px;border:0;" alt="GABeS_Logo" src="img/gabes.png">
</a>
<% 
String message = "";
String errorParam = request.getParameter("error");
if (errorParam != null){
	int error = Integer.parseInt(errorParam);
	if (error == 1){
		message = "Invalid username or password";
	}
}
%>
<div style="color: red; text-align: center;"><%=message%></div><br>
<form method="post" action="UserLogin_action.jsp" name="Login">Username:
<input name="username"><br>
Password: <input name="pass" type="password"><br>
<input style = "color: black" name="Confirm" value="Confirm" type="submit"><br>
</form>
</body>
</html>