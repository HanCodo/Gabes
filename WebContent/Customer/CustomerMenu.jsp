<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 

<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title></title>
</head>
<body>
<div style="text-align: right;">
<form method="post" action="../CustomerLogout_action.jsp" name="logout"><input
style = "color: black" name="Logout" value="Logout" type="submit"></form>
</div>
<div style="text-align: center;"><br>
</div>
<form method="post" action="UpdateProfile.jsp"
name="UpdateProfile"><input style = "color: black" name="UpdateProfile"
value="Update Profile" type="submit"><br>
</form>
<form method="post" action="SellingManagement.jsp"
name="SellingManagement"><input style = "color: black" name="SellingManagement"
value="Selling Management" type="submit"><br>
</form>
<form method="post" action="BiddingManagement.jsp"
name="BiddingManagement"><input style = "color: black" name="BiddingManagement"
value="Bidding Management" type="submit"><br>
</form>
<form method="post" action="LeaveFeedback.jsp" name="LeaveFeedback"><input
style = "color: black" name="Leave Feedback" value="Leave Feedback" type="submit"><br>
</form>
<form method="post" action="ViewFeedback.jsp" name="ViewFeedback"><input
style = "color: black" name="View Feedback" value="View my Feedback" type="submit"><br>
</form>
<br>
<br>
</body>
</html>