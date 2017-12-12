<%@ page language="java" import="java.sql.*, gabes.*,java.text.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/> 
<%
if(!customer.isLoggedIn()){
	response.sendRedirect("index.jsp?error=1");
}
else{		
			try{
			int result = customer.addFavorites(request.getParameter("Favlist"));
			}	catch(Exception ex){
				out.println("noo");
			}
		response.sendRedirect("itemsBought.jsp?sellID="+request.getParameter("FavList"));
		}



		
		
		
		
	


%>