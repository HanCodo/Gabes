<%@ page language="java" import="java.sql.*, java.text.*, java.util.*, gabes.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/>
<%
customer.bid(Integer.parseInt(request.getParameter("i")), Double.parseDouble(request.getParameter("bidprice")));
response.sendRedirect("Bid.jsp?i="+request.getParameter("i"));
%>