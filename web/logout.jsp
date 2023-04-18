<%-- 
    Document   : logout
    Created on : Jun 18, 2022, 3:54:14 AM
    Author     : fakhr
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% 
            session.invalidate(); //destroy session
            response.sendRedirect("login.jsp");
        %>
    </body>
</html>
