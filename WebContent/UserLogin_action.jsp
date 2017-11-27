<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/> 

<%
if (customer.login()){
	response.sendRedirect("Customer/CustomerMenu.jsp");
}
else
    response.sendRedirect("index.jsp");
%> 