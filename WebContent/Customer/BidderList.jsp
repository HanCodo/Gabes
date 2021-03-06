<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="customer" class="gabes.Customer" scope="session"/> 
<jsp:setProperty property="*" name="customer"/>
<% 
if(customer.getUsername() == null)
{
	response.sendRedirect("../CustomerLogout_action.jsp");
}
%>
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>Bidder List</title>
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
    	<a href="CustomerMenu.jsp">
  			<img style="width:150px;height:42px;border:0;" alt="GABeS_Logo" src="../img/gabes.png">
		</a>
	</div>
    <div class="right">
    	<form method="post" action="../CustomerLogout_action.jsp" name="logout">
    		Logged in as: <%=customer.getUsername()%> <input style = "text-align: right; color: black" name="Logout" value="Logout" type="submit">
    	</form>
    </div>
</div>
<br>
<br>
<br>
<%ResultSet r = null;
try{
r = customer.viewItem(request.getParameter("BidList"));}
catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }
    r.next();%>
<div style="text-align: center;"><b>List of Bidders</b><br>
<b>Item ID: <%=request.getParameter("BidList") %></b><br>
<b>(<%=r.getDate("startDate") %> to <%=r.getDate("endDate") %>)</b><br>
</div><br>
<table style="text-align: left; width: 100%;" border="2" cellpadding="2"
cellspacing="2">
<tbody>
<tr>
<td style="vertical-align: top;"><b>Bidding Time</b><br>
</td>
<td style="vertical-align: top;"><b>Bidder Username</b><br>
</td>
<td style="vertical-align: top;"><b>Max Bid Limit</b><br>
</td>
</tr>
<%ResultSet rs = null;
try{
rs = customer.bidInfoList(request.getParameter("BidList"));}
catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }
while(rs.next()){ %>
<tr>
<td style="vertical-align: top;"><%= rs.getDate("BID_TIME")%><br>
</td>
<td style="vertical-align: top;"><%= rs.getString("USERNAME")%><br>
</td>
<td style="vertical-align: top;"><%= "$"+rs.getDouble("MAX_BID")%><br>
</td>
</tr>
<%} %>
</tbody>
</table>
<div style="text-align:center;">
<br>
<b>Winner: </b><%
if(r.getString("Status").equals("SOLD")){
	ResultSet winner = customer.winnerInfo(request.getParameter("BidList"));
	winner.next();
	out.println(winner.getString("Username")+" $"+winner.getDouble("FinalSellingPrice"));
}
else{
	out.print(r.getString("Status"));
}
r.close();
	%>
</div>
<form method="post" action="ItemsList.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>

</body>
</html>