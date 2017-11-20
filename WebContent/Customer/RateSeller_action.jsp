<%@ page language="java" import="java.sql.*,gabes.*"%>
<jsp:useBean id="item" class="gabes.Item" scope="page"/>
<% 
Connection conn = item.openDBConnection();
CallableStatement c = conn.prepareCall("{call LeaveFeedBack_Proc(?, ?, ?, ?, ?)}");
c.setInt(1, Integer.parseInt(request.getParameter("ItemID")));
c.setString(2, request.getParameter("Comments"));
c.setInt(3, Integer.parseInt(request.getParameter("Delivery")));
c.setInt(4, Integer.parseInt(request.getParameter("Quality")));
c.setInt(5, Integer.parseInt(request.getParameter("Overall")));
c.execute();
response.sendRedirect("itemsBought.jsp");
%> 
