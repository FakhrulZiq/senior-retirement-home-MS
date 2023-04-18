<%-- 
    Document   : customerdel
    Created on : Jun 20, 2022, 11:46:48 PM
    Author     : fakhr
--%>

<%@page import="java.sql.*" errorPage="error.jsp"%>
<%!
	PreparedStatement ps;
%>
<%
	Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/seniorretirementhomemanagementsystem","root","admin"); //create connection
%>
<%
String sid=request.getParameter("sid");
int id = Integer.parseInt(sid);
if(sid==null)
{%>
	<script>alert("Sorry ! Wrong Entry") </script>

<%
	response.sendRedirect("home.jsp");
}

else{
String view="update roombook set stat='checked out' where id ="+id;
ps=c.prepareStatement(view);
int i=ps.executeUpdate();
	if(i>0)
	{%>
		<script>alert("Customer Checked Out.Entry Updated Successfully.") </script>
<%	
response.sendRedirect("home.jsp");
}


}


%>
