<%@ page language="java" import="java.sql.*, java.text.*, java.util.*, gabes.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/>
<%
customer.buyNow(Integer.parseInt(request.getParameter("i")), Double.parseDouble(request.getParameter("p")));
response.sendRedirect("itemsBought.jsp?itemID="+request.getParameter("i"));
%>