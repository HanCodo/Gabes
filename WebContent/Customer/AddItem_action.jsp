<%@ page language="java" import="java.sql.*, gabes.*,java.text.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/> 
<%
if(!customer.isLoggedIn()){
	response.sendRedirect("index.jsp?error=1");
}
else{		
		String startDate =""+request.getParameter("sYear")+"-"+request.getParameter("sMonth")+"-"+request.getParameter("sDay")+"";
		String endDate =""+request.getParameter("eYear")+"-"+request.getParameter("eMonth")+"-"+request.getParameter("eDay")+"";

		java.util.Date sDate = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
		java.util.Date eDate = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
		String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		java.util.Date cDate = new SimpleDateFormat("yyyy-MM-dd").parse(currentDate);

		if(request.getParameter("Item_Name").isEmpty()){
			response.sendRedirect("AddItem.jsp?error=2");
		
		}
		else if(request.getParameter("Descript").isEmpty()){
			response.sendRedirect("AddItem.jsp?error=3");
			
		}
		else if(request.getParameter("Categories").isEmpty()){
			response.sendRedirect("AddItem.jsp?error=4");
			
		}
		else if(request.getParameter("Start_Price").isEmpty()){
			response.sendRedirect("AddItem.jsp?error=5");
			
		}
		else if(sDate.before(cDate) || eDate.before(cDate)||eDate.equals(sDate)||sDate.before(cDate) & eDate.before(cDate)){
			response.sendRedirect("AddItem.jsp?error=6");
		}
		
		else{
		
		int result = customer.addItem(request.getParameter("Item_ID"), startDate, endDate,request.getParameter("Item_Name"), request.getParameter("Descript"), request.getParameter("Categories"), request.getParameter("Start_Price"),request.getParameter("BuyNow"));
		response.sendRedirect("ItemsList.jsp?itemid="+request.getParameter("Item_ID"));}
}

		
		
		
		
	


%>