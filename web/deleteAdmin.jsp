<%-- 
    Document   : deleteAdmin
    Created on : Jun 20, 2022, 11:34:09 PM
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
    String eid=request.getParameter("eid");
    int id = Integer.parseInt(eid);		
    String newsql ="DELETE FROM admin WHERE id ="+id;
    ps=c.prepareStatement(newsql);
    int i=ps.executeUpdate();
    if(i>0) {%>
	<script language="javascript" type="text/javascript"> alert("Admin name and password Deleted") </script>
    <%}
    response.sendRedirect("admin.jsp");
%>

