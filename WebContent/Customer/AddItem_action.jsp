<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/> 
<%
if(!customer.isLoggedIn()){
	response.sendRedirect("index.jsp?error=1");
}
else{

		System.out.println(request.getParameter("Item_ID") + request.getParameter("Item_Name")+ request.getParameter("Start_Date")+ request.getParameter("End_Date")+ request.getParameter("Descript")+ request.getParameter("Categories")+ request.getParameter("Start_Price"));
		String startDate =""+request.getParameter("sYear")+"-"+request.getParameter("sMonth")+"-"+request.getParameter("sDay")+"";
		String endDate =""+request.getParameter("eYear")+"-"+request.getParameter("eMonth")+"-"+request.getParameter("eDay")+"";
		System.out.println(startDate);
		System.out.println(endDate);
		int result = customer.addItem(request.getParameter("Item_ID"), startDate, endDate,request.getParameter("Item_Name"), request.getParameter("Descript"), request.getParameter("Categories"), request.getParameter("Start_Price"));
		response.sendRedirect("AddItem.jsp");
	}

%>