<%-- 
    Document   : roomdel
    Created on : Jun 18, 2022, 2:57:32 AM
    Author     : fakhr
--%>

<%@page import="java.sql.*" errorPage="error.jsp"%>
<%!
    PreparedStatement ps;
    ResultSet rs;
%>
<%
    Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/seniorretirementhomemanagementsystem","root","admin"); //create connection
%>
<%
    String rsql ="select id from room";
    ps=c.prepareStatement(rsql);
    rs=ps.executeQuery();
%>						 
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>SRHMS</title>
        <!-- Bootstrap Styles-->
        <link href="assets/css/bootstrap.css" rel="stylesheet" />
        <!-- FontAwesome Styles-->
        <link href="assets/css/font-awesome.css" rel="stylesheet" />
        <!-- Custom Styles-->
        <link href="assets/css/custom-styles.css" rel="stylesheet" />
        <!-- Google Fonts-->
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
        
        <!-- JS Scripts-->
        <!-- jQuery Js -->
        <script src="assets/js/jquery-1.10.2.js"></script>
          <!-- Bootstrap Js -->
        <script src="assets/js/bootstrap.min.js"></script>
        <!-- Metis Menu Js -->
        <script src="assets/js/jquery.metisMenu.js"></script>
          <!-- Custom Js -->
        <script src="assets/js/custom-scripts.js"></script>
    </head>
    <body>
        <%
           if(session.getAttribute("user")==null || session.getAttribute("user")==" ") {//check condition unauthorize user not direct access welcome.jsp page
                response.sendRedirect("login.jsp"); 
            }
        %>
        <div id="wrapper">
            <nav class="navbar navbar-default top-navbar" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="home.jsp">MAIN MENU </a>
                </div>
                <ul class="nav navbar-top-links navbar-right">
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                            <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                            <li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a></li>
                            <li class="divider"></li>
                            <li><a href="logout.jsp"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            
            <!-- NAV TOP  -->
            <nav class="navbar-default navbar-side" role="navigation">
                <div class="sidebar-collapse">
                    <ul class="nav" id="main-menu">
                        <li><a href="room.jsp"><i class="fa fa-dashboard"></i>Room Status</a></li>
                        <li><a href="addroom.jsp"><i class="fa fa-plus-circle"></i>Add Room</a></li>
                        <li><a class="active-menu" href="roomdel.jsp"><i class="fa fa-pencil-square-o"></i> Delete Room</a></li>
                    </ul>
                </div>
            </nav>
            
            <!--  NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <h1 class="page-header">
                               DELETE ROOM <small></small>
                            </h1>
                        </div>
                    </div> 
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                   Delete room
                                </div>
                                <div class="panel-body">
                                    <form name="form" method="post">
                                        <div class="form-group">
                                            <label>Select the Room ID *</label>
                                            <select name="id" class="form-control" required>
                                                <option value selected ></option>
                                                <%
                                                    while(rs.next()) {
                                                        int value = rs.getInt("id"); 
                                                %>
                                                 <option value="<%=value%>"><%=value%></option>
                                                <%}%>
                                            </select>
                                        </div>
                                        <input type="submit" name="del" value="Delete Room" class="btn btn-primary"> 
                                    </form>
                                    <%
                                        if(request.getParameter("del")!=null) {
                                            int did =Integer.parseInt(request.getParameter("id"));
                                            String sql ="DELETE FROM room WHERE id = "+did;
                                            ps=c.prepareStatement(sql);
                                            int i=ps.executeUpdate();
                                            if(i>0) {%>
                                                <script type="text/javascript">alert("Deleted the Room") </script>
                                                <% response.sendRedirect("roomdel.jsp");
                                            } else {%>
                                                <script>alert("Sorry ! Check The System") </script>
                                            <%}
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                        <%
                            String sql = "select * from room";
                            ps=c.prepareStatement(sql);
                            rs=ps.executeQuery();
                        %>
                        <div class="row">
                            <%
                                while(rs.next()) {
                                    String type =rs.getString("type");
                                    int id=rs.getInt("id");
                                    if(type.equalsIgnoreCase("Superior Room")) {
                            %>
                            <div class='col-md-3 col-sm-12 col-xs-12'>
                                <div class='panel panel-primary text-center no-boder bg-color-blue'>
                                    <div class='panel-body'>
                                        <i class='fa fa-users fa-5x'></i>
                                        <h3><%=rs.getString("bedding")%></h3>
                                    </div>
                                    <div class='panel-footer back-footer-blue'>
                                        <%=type%>(<%=id%>)
                                    </div>
                                </div>
                            </div>
                            <%}
                                else if (type.equalsIgnoreCase("Deluxe Room")) {
                            %>
                            <div class='col-md-3 col-sm-12 col-xs-12'>
                                <div class='panel panel-primary text-center no-boder bg-color-green'>
                                    <div class='panel-body'>
                                        <i class='fa fa-users fa-5x'></i>
                                        <h3><%=rs.getString("bedding")%></h3>
                                    </div>
                                    <div class='panel-footer back-footer-green'>
                                        <%=type%>(<%=id%>)
                                    </div>
                                </div>
                            </div>
                            <%}
                                else if(type.equalsIgnoreCase("Guest House")) {
                            %>
                            <div class='col-md-3 col-sm-12 col-xs-12'>
                                <div class='panel panel-primary text-center no-boder bg-color-brown'>
                                    <div class='panel-body'>
                                        <i class='fa fa-users fa-5x'></i>
                                        <h3><%=rs.getString("bedding")%></h3>
                                    </div>
                                    <div class='panel-footer back-footer-brown'>
                                        <%=type%>(<%=id%>)
                                    </div>
                                </div>
                            </div>
                            <%}
                                else if(type.equalsIgnoreCase("Single Room")) {
                            %>
                            <div class='col-md-3 col-sm-12 col-xs-12'>
                                <div class='panel panel-primary text-center no-boder bg-color-red'>
                                    <div class='panel-body'>
                                        <i class='fa fa-users fa-5x'></i>
                                        <h3><%=rs.getString("bedding")%></h3>
                                    </div>
                                    <div class='panel-footer back-footer-red'>
                                        <%=type%>(<%=id%>)
                                    </div>
                                </div>
                            </div>
                            <%}
                                }
                            %>
                        </div>
                    </div>
                <!-- END PAGE INNER  -->
                </div>
             <!-- END PAGE WRAPPER  -->
            </div>
        <!-- END WRAPPER  -->
        </div>            
    </body>
</html>
