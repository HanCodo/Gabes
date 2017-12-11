<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty property="*" name="customer"/>

<% 	
if(customer.getUsername() == null)
{
	response.sendRedirect("../CustomerLogout_action.jsp");
}
try{

            	%>
 <% 
String message = "";
String errorParam = request.getParameter("error");
if (errorParam != null){
	int error = Integer.parseInt(errorParam);
	if (error == 1){
		message = "Please Enter Valid Values";
	}else if(error == 2){
		message = "Please Enter a Name";
	}else if(error == 3){
		message = "Please Enter a Description";
	}else if(error == 4){
		message = "Please Choose a Category";
	}else if(error == 5){
		message = "Please Enter a Price";
	}
	else if(error == 6){
		message = "Please Enter a Valid Date";
	}
}
%>
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>Add Item</title>
<style type="text/css">
.left {
    float: left;
}
.right {
    float: right;
}
.shift {
    text-indent: 300px;
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
<div style="text-align: center;"><b>Add Item</b><br>
<div style="color: red; text-align: center;"><%=message%></div><br>
</div>
<form method="post" action="AddItem_action.jsp" name="AddItem">
<%ResultSet items = customer.allItems();
int x=0;
while(items.next()){ x++;
}%>
Item ID<input value=<%=x=10000+x %> name=Item_ID readOnly><br>
Item Name <input name="Item_Name"type="text"><br>
Start Date<select name="sDay" >
  <%for (int i = 1; i <= 31 ; i++){ 
  int day = i ;

  String currentDay = new java.text.SimpleDateFormat("dd").format(new java.util.Date());
  int curDay = Integer.parseInt(currentDay);

 %>
 <option value = "<%=i %>"
 <%if(i == curDay){ %> selected <%}%>><%= i%></option>
 <%} %>
 
 
</select>
<select name="sMonth" >
  <%!
  private String getMonth(int num){
	  if(num == 1){
		  return "January";
	  }
	  else if(num == 2){
		  return "February";
	  }
	  else if(num == 3){
		  return "March";
	  }
	  else if(num == 4){
		  return "April";
	  }
	  else if(num == 5){
		  return "May";
	  }
	  else if(num == 6){
		  return "June";
	  }
	  else if(num == 7){
		  return "July";
	  }
	  else if(num == 8){
		  return "August";
	  }
	  else if(num == 9){
		  return "September";
	  }
	  else if(num == 10){
		  return "October";
	  }
	  else if(num == 11){
		  return "November";
	  }
	  else if(num == 12){
		  return "December";
	  }
	  else{
		  return "";
	  }  
  } %>
  <%
  for (int i = 1; i <= 12 ; i++){ 
  int month = i ;

  String currentMonth = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
  int curMonth = Integer.parseInt(currentMonth);

 %>
 <option value = "<%=i %>"
 <%if(i == curMonth){ %> selected <%}%>><%= getMonth(i)%></option>
 <%} %>
 
</select>
<select name="sYear" >
  <%for (int i = 0; i <= 5 ; i++){ 
  String currentYear = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
  int currentDateInt= Integer.parseInt(currentYear);%>
<option value = "<%=currentDateInt + i%>"><%=currentDateInt + i%></option>
<%} %>
  </select>
<br>

End Date<select name="eDay" >
    <%for (int i = 1; i <= 31 ; i++){ 
  int day = i ;

  String currentDay = new java.text.SimpleDateFormat("dd").format(new java.util.Date());
  int curDay = Integer.parseInt(currentDay);

 %>
 <option value = "<%=i %>"
 <%if(i == curDay){ %> selected <%}%>><%= i%></option>
 <%} %>
</select>
<select name="eMonth" >
  <%
  for (int i = 1; i <= 12 ; i++){ 
  int month = i ;

  String currentMonth = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
  int curMonth = Integer.parseInt(currentMonth);
 %>
 <option value = "<%=i %>"
 <%if(i == curMonth){ %> selected <%}%>><%= getMonth(i)%></option>
 <%} %>
</select>
<select name="eYear" >
 <%for (int i = 0; i <= 5 ; i++){ 
  String currentYear = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
  int currentDateInt= Integer.parseInt(currentYear);%>
<option value = "<%=currentDateInt + i%>"><%=currentDateInt + i%></option>
<%} %>
  </select>
<br>
Description <input name="Descript" type="text"><br>
Category: <select name="Categories" >
<option value = "">Select Category</option>
 <option value="Household">Household</option>
  <option value="Children">Children</option>
  <option value="Health">Health</option>
  <option value="Leisure">Leisure</option>
  <option value="Electronics">Electronics</option>
  <option value="Style">Style</option>
  </select><br>
Start Price <input name="Start_Price" type="text"><br>
Buy Now Price  (Optional)<input name="BuyNow" type="text"><br>
<input style = "color: black" name="Add" value="Add" type="submit">
<br>
</form>
<form method="post" action="SellingManagement.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>
<% 		
}
catch(IllegalStateException ise){
	out.println(ise.getMessage());
}
%>
</body>
</html>