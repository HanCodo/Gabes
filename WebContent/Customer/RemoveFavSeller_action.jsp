<%@ page language="java" import="java.sql.*, gabes.*,java.text.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/> 
<%
if(!customer.isLoggedIn()){
	response.sendRedirect("index.jsp?error=1");
}
else{		
		int i = Integer.parseInt(request.getParameter("removeFav"));
		System.out.println("THIS IS THE PARAMETER REQUESTERD:"+i);
		System.out.println("THIS IS THE VALUE OF THE REQUEST:"+i);
		System.out.println(customer.checkSeller(i));
		if(customer.checkSeller(i)){
			int result = customer.removeFavSeller(i);
			response.sendRedirect("FollowSellers.jsp?sellID="+i);
			
		}
		else{
	
			response.sendRedirect("FollowSellers.jsp?error=1");
		}
}



		
		
		
		
	


%>