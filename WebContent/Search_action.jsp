<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
    <%@ page language="java" import="java.sql.*, java.text.*,java.sql.Date, gabes.*"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table style="text-align: left; width: 100%;" border="1" cellpadding="2"
cellspacing="2">
<tbody>
<tr>
<td style="vertical-align: top;">ItemID<br>
</td>
<td style="vertical-align: top;">Start Date<br>
</td>
<td style="vertical-align: top; width: 253px;">End Date<br>
</td>
<td style="vertical-align: top; width: 245px;">Item Name<br>
</td>
<td style="vertical-align: top; width: 282px;">Item Description<br>
</td>
<td style="vertical-align: top;">Category<br>
</td>
<td style="vertical-align: top;">Status<br>
</td>
<td style="vertical-align: top;">Current Bid<br>
</td>
</tr>
<%

try {
	String itemID1 = request.getParameter("itemID");
	String bidmin1 = request.getParameter("itemID");
	String bidmax1 = request.getParameter("itemID");
	String startDate = request.getParameter("startDate");
	Date startDate1 = null;
	if(startDate.trim().length() > 0){
		DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		try {
		    java.util.Date startDate2 = df.parse(startDate);
		    startDate1 = new java.sql.Date(startDate2.getTime());
		   
		} catch (Exception e) {
		    e.printStackTrace();
		    response.sendRedirect("Search.jsp?error=3");
		}
	}
	String endDate = request.getParameter("endDate");
	Date endDate1 = null;
	if(startDate.trim().length() > 0){
		DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		try {
		    java.util.Date startDate2 = df.parse(endDate);
		    endDate1 = new java.sql.Date(startDate2.getTime());
		   
		} catch (Exception e) {
		    e.printStackTrace();
		    response.sendRedirect("Search.jsp?error=3");
		}
	}
	int itemID = -1;
	int bidmin = -1;
 	int bidmax = -1;
	if(itemID1.trim().length() > 0) {
	itemID = Integer.parseInt(itemID1);
	}
	if(bidmin1.trim().length() > 0) {
		bidmin = Integer.parseInt(bidmin1);
		if(bidmin < 0){
			bidmin = 0;
		}
	}
	if(bidmax1.trim().length() > 0) {
		bidmax = Integer.parseInt(bidmax1);
	}
	
	String itemName = request.getParameter("itemName");
	String keyword = request.getParameter("keyword");
	String category = request.getParameter("category");
	System.out.println(keyword);
	ResultSet users = admin.search(itemID, keyword, category, bidmin, bidmax, startDate1, endDate1, itemName);
	System.out.println(users);
if(users == null){
	response.sendRedirect("Search.jsp?error=2");
}
else{
	int x = 0;
while(users.next()){  x++; %>
<tr>
<td style="vertical-align: top;"><%try{out.println(users.getString(1));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(users.getString(2));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top; width: 253px;"><%try{out.println(users.getString(3));}catch(Exception ex){out.println("noo");}  %><br>
</td>
<td style="vertical-align: top; width: 245px;"><%try{out.println(users.getString(4));}catch(Exception ex){out.println("noo");}  %><br>
</td>
<td style="vertical-align: top; width: 282px;"><%try{out.println(users.getString(5));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(users.getString(6));}catch(Exception ex){out.println("noo");}  %><br>
</td>
<td style="vertical-align: top; width: 282px;"><%try{out.println(users.getString(8));}catch(Exception ex){out.println("noo");} %><br>
</td>
</td>
<td style="vertical-align: top; width: 282px;"><%try{out.println(users.getString(7));}catch(Exception ex){out.println("noo");} %><br>
</td>
</tr>
<%}if(x==0){
	response.sendRedirect("Search.jsp?error=2");
}

} }catch(java.lang.NumberFormatException e){
	response.sendRedirect("Search.jsp?error=1");
	//e.printStackTrace();
} catch(Exception ex){
	ex.printStackTrace();
	}%>
</tbody>
</table>
</body>
</html>