<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" import="java.sql.*, gabes.*"%>


<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title></title>
</head>
<body>
<div style="text-align: center;">Leave Feedback <br>
</div>
<form method="post" action="RateSeller_action.jsp" name="Leave">
Item Id:<br> <input name="ItemID" value=<%=request.getParameter("ItemID")%> readonly><br>
Item Name:<br><input name="ItemName" value=><br>
Overall Rating:<br><select name="Overall">
    <option value="1">1</option>
    <option value="2">2</option>
    <option value="3">3</option>
    <option value="3">4</option>
    <option value="3">5</option>
</select><br>
Item Quality:<br><select name="Quality">
    <option value="1">1</option>
    <option value="2">2</option>
    <option value="3">3</option>
    <option value="3">4</option>
    <option value="3">5</option>
</select><br>
Delivery:<br><select name="Delivery">
    <option value="1">1</option>
    <option value="2">2</option>
    <option value="3">3</option>
    <option value="3">4</option>
    <option value="3">5</option>
</select><br>
Comments:<br><textarea name="Comments" cols="50" rows="10"></textarea><br>
<input style = "color: black" name="Submit" value="Submit" type="submit"><br>
</form>
</body>
</html>