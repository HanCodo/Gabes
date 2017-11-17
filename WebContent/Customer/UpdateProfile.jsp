<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title></title>
</head>
<body>
<div style="text-align: center;">Update Profile <br>
</div>
<form method="post" action="UpdateProfile_action.jsp" name="Update">Username
<input name="Username"><br>
First Name <input name="Fname"><br>
Last Name <input name="Lname"><br>
Email <input name="Email"><br>
Phone <input name="Phone"><br>
Seller Rating<br>
Number of Ratings<br>
Old Password <input name="oldPass" type="password"><br>
New Password <input name="Pass1" type="password"><br>
Retype Password <input name="Pass2" type="password"><br>
<input style = "color: black" name="Update" value="Update" type="submit"><br>
</form>
</body>
</html>