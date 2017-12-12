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

<%
String message = "";
String errorParam = request.getParameter("error");
String sellID = request.getParameter("sellID");
if (errorParam != null){
	int error = Integer.parseInt(errorParam);
	if (error == 1){
		message = "Its gone ";
		%><div style="text-align: center;color:red;"><%=message %></div><br><%
	}
}	
if (sellID != null){
	message = "You removed User from your list";
	%><div style="text-align: center; "><%=message %></div><br><%
}
	

%>

<script src="https://www.w3schools.com/lib/w3.js"></script>
<table style="text-align: left; width: 100%;" border="2" cellpadding="2"
cellspacing="2" id ="team2">
   <tr>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(1)')"style="vertical-align: top;"><b>Seller Username</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(2)')"style="vertical-align: top;"><b>Seller Items</b><br></th>
     <th  onclick="w3.sortHTML('#team2', '.items', 'td:nth-child(3)')"style="vertical-align: top;"><b>Remove Seller</b><br></th>
     

  </tr>
<%ResultSet rs = null;
try{
rs = customer.allFollowers();
}
catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }
while(rs.next()){
%>
<tr class ="items">
<td style="vertical-align: top;"><%= rs.getString("Name")%><br>
</td>
<td style="vertical-align: top;"><form method="GET" action="SellerItems.jsp" name="SellerItems">
<input  style = "color: black" name="SellerItems" type="hidden" value="<%=rs.getInt("SellerID") %>"/>
<button style = "color: black" value="SellerItems" name="SellerItems">Seller Items</button><br>
</form><br>
</td>
<td style="vertical-align: top;"><form method="GET" action="RemoveFavSeller_action.jsp" name="removeFav">
<input  style = "color: black" name="removeFav" type="hidden" value="<%=rs.getInt("SellerID") %>"/>
<button style = "color: black" value="removeFav" name="removeFav">Remove from List</button><br>
</form><br>
</td>
</tr>
<%} rs.close();%>
</tbody>
</table>
<div style="text-align:center;">
<br>
</div>
<form method="post" action="BiddingManagement.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>

</body>
</html>