<%@ page language="java" import="java.sql.*, gabes.*,java.text.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/> 
<%
if(!customer.isLoggedIn()){
	response.sendRedirect("index.jsp?error=1");
}
else{		
		int i = Integer.parseInt(request.getParameter("Favlist"));
		if(customer.checkSeller(i)){
			response.sendRedirect("itemsBought.jsp?error=2");
		}
		else{
	
	
		int result = customer.addFavorites(request.getParameter("Favlist"));
		response.sendRedirect("itemsBought.jsp?sellID="+request.getParameter("FavList"));
		
		}
}



		
		
		
		
	


%>