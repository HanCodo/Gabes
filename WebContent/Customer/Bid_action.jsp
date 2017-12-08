<%@ page language="java" import="java.sql.*, java.text.*, java.util.*, gabes.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/>
<%   
String date = new SimpleDateFormat("MM/dd/yyyy").format(new java.util.Date());
java.sql.Date date1 = null;
if(date.trim().length() > 0){
	DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
	try {
	    java.util.Date date2 = df.parse(date);
	    date1 = new java.sql.Date(date2.getTime());
	   
	} catch (Exception e) {
	}
}
customer.bid(Integer.parseInt(request.getParameter("i")), Double.parseDouble(request.getParameter("bidprice")),date1);
response.sendRedirect("Bid.jsp?i="+request.getParameter("i"));
%>