<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
<jsp:setProperty name="admin" property="*"/>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>Search</title>
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
    	<a href="Customer/CustomerMenu.jsp">
  			<img style="width:150px;height:42px;border:0;" alt="GABeS_Logo" src="img/gabes.png">
		</a>
	</div>
    <div class="right">
    	<form method="post" action="CustomerLogout_action.jsp" name="logout">
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
if (errorParam != null){
	int error = Integer.parseInt(errorParam);
	if (error == 1){
		message = "Please Enter Valid Values";
	}else if(error == 2){
		message = "no results found for your request";
	}else if(error == 3){
		message = "please use correct date format MM/DD/YYYY";
	}else if(error == 4){
		message = "CAN ONLY SEARCH BY THE FOLLOWING\n" +
				"1 Search by item id alone \n 2. Search by keyword alone \n" +
				"3. Search by keyword and category\n"+
				"4. Search by keyword and current bid range\n"+
				"5. Search by keyword and auction time period\n"+
				"6. Search by keyword, category and current bid range\n"+
				"7. Search by keyword, category and auction time period\n"+
				"8. Search by keyword, current bid range and auction time period\n"+
				"9. Search by keyword, category, current bid range and auction time period\n"+
				"10. Inexact search on item name";
	}else if(error == 5){
		message = "if you are going to enter dates enter the full dates smarty";
	}
}
%>
<div style="color: red; text-align: center;"><%=message%></div><br>
<form method="post" action="Search_action.jsp" name="Search">
ItemID: <input name="itemID"> must be an integer<br>
Keyword: <input name="keyword"> a word that is in the description<br>
Category: <select name="category" >
<option value = "">Select Category</option>
 <option value="Household">Household</option>
  <option value="Children">Children</option>
  <option value="Health">Health</option>
  <option value="Leisure">Leisure</option>
  <option value="Electronics">Electronics</option>
  <option value="Style">Style</option>
  </select><br>
Item Name: <input name="itemName">Name of item<br>
Minimum Price: <input name="minbid"><br>
Maximum Price: <input name="maxbid"><br>
Start Date<select name="sDay" >
<option value ="00">Select Day</option>
 <option value="01">1</option>
  <option value="02">2</option>
  <option value="03">3</option>
  <option value="04">4</option>
  <option value="05">5</option>
  <option value="06">6</option>
  <option value="07">7</option>
  <option value="08">8</option>
  <option value="09">9</option>
  <option value="10">10</option>
  <option value="11">11</option>
  <option value="12">12</option>
  <option value="13">13</option>
  <option value="14">14</option>
  <option value="15">15</option>
  <option value="17">17</option>
  <option value="18">18</option>
  <option value="19">19</option>
  <option value="20">20</option>
  <option value="21">21</option>
  <option value="22">22</option>
  <option value="23">23</option>
  <option value="24">24</option>
  <option value="25">25</option>
  <option value="26">26</option>
  <option value="27">27</option>
  <option value="28">28</option>
  <option value="29">29</option>
  <option value="30">30</option>
  <option value="31">31</option>
 
</select>
<select name="sMonth" >
<option value ="00">Select Month</option>
 <option value="01">January </option>
  <option value="02">Feburary</option>
  <option value="03">March</option>
  <option value="04">April</option>
  <option value="05">May</option>
  <option value="06">June</option>
  <option value="07">July</option>
  <option value="08">August</option>
  <option value="09">September</option>
  <option value="10">October</option>
  <option value="11">November</option>
  <option value="12">December</option>

</select>
<select name="sYear" >
<option value ="00">Select Year</option>
  <%for (int i = 0; i <= 5 ; i++){ 
  String currentYear = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
  int currentDateInt= Integer.parseInt(currentYear);%>
<option value = "<%=currentDateInt + i%>"><%=currentDateInt + i%></option>
<%} %>
  </select>
<br>

End Date<select name="eDay" >
<option value ="00">Select Day</option>
  <option value="01">1</option>
  <option value="02">2</option>
  <option value="03">3</option>
  <option value="04">4</option>
  <option value="05">5</option>
  <option value="06">6</option>
  <option value="07">7</option>
  <option value="08">8</option>
  <option value="09">9</option>
  <option value="10">10</option>
  <option value="11">11</option>
  <option value="12">12</option>
  <option value="13">13</option>
  <option value="14">14</option>
  <option value="15">15</option>
  <option value="17">17</option>
  <option value="18">18</option>
  <option value="19">19</option>
  <option value="20">20</option>
  <option value="21">21</option>
  <option value="22">22</option>
  <option value="23">23</option>
  <option value="24">24</option>
  <option value="25">25</option>
  <option value="26">26</option>
  <option value="27">27</option>
  <option value="28">28</option>
  <option value="29">29</option>
  <option value="30">30</option>
  <option value="31">31</option>
</select>
<select name="eMonth" >
<option value ="00">Select Month</option>
  <option value="01">January </option>
  <option value="02">Feburary</option>
  <option value="03">March</option>
  <option value="04">April</option>
  <option value="05">May</option>
  <option value="06">June</option>
  <option value="07">July</option>
  <option value="08">August</option>
  <option value="09">September</option>
  <option value="10">October</option>
  <option value="11">November</option>
  <option value="12">December</option>
</select>
<select name="eYear" >
<option value ="00">Select Year</option>
 <%for (int i = 0; i <= 5 ; i++){ 
  String currentYear = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
  int currentDateInt= Integer.parseInt(currentYear);%>
<option value = "<%=currentDateInt + i%>"><%=currentDateInt + i%></option>
<%} %>
  </select>
<br>
<input style = "color: black" name="Confirm" value="Confirm" type="submit"><br>
</form>
<br>
</body>
</html>