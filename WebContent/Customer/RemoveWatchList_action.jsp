<%@ page language="java" import="java.sql.*, gabes.*,java.text.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/> 
<%
if(!customer.isLoggedIn()){
	response.sendRedirect("index.jsp?error=1");
}
else{		
		int i = Integer.parseInt(request.getParameter("removeWatch"));
		if(customer.checkItem(i)){
			int result = customer.removeWatchList(i);
			response.sendRedirect("WatchList.jsp?itemID="+i);
			
		}
		else{
	
			response.sendRedirect("WatchList.jsp?error=1");
		}
}



		
		
		
		
	


%>