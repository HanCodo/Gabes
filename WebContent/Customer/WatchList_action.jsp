<%@ page language="java" import="java.sql.*, gabes.*,java.text.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/> 
<%
if(!customer.isLoggedIn()){
	response.sendRedirect("index.jsp?error=1");
}
else{		

		int i = Integer.parseInt(request.getParameter("watchList"));
		if(customer.checkItem(i)){
			response.sendRedirect("AllItems.jsp?error=1");
		}
		else{
	
	
		int result = customer.addWatchList(request.getParameter("watchList"));
		response.sendRedirect("AllItems.jsp?ItemID="+request.getParameter("watchList"));
		
		}
}



		
		
		
		
	


%>