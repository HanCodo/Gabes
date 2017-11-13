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
<div style="text-align: right;">
<form method="post" action="../../AdminLogout_action.jsp" name="logout"><input
style = "color: black" name="Logout" value="Logout" type="submit"></form>
</div>
<div style="text-align: center;">Sales Summary Report<br>
</div>
<br>
<table style="text-align: left; width: 100%;" border="1" cellpadding="2"
cellspacing="2">
<tbody>
<tr>
<td style="vertical-align: top;">Category<br>
</td>
<td style="vertical-align: top;">Item ID<br>
</td>
<td style="vertical-align: top;">Item Name<br>
</td>
<td style="vertical-align: top;">Final Selling Price<br>
</td>
<td style="vertical-align: top;">Commision<br>
</td>
</tr>
<tr>
<td style="vertical-align: top;"><br>
</td>
<td style="vertical-align: top;"><br>
</td>
<td style="vertical-align: top;"><br>
</td>
<td style="vertical-align: top;"><br>
</td>
<td style="vertical-align: top;"><br>
</td>
</tr>
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