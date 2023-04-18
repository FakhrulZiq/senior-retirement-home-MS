<%-- 
    Document   : usersetting
    Created on : Jun 18, 2022, 2:52:58 AM
    Author     : fakhr
--%>
<%@page import="java.sql.*" errorPage="error.jsp"%>
<%!
    PreparedStatement pst;
    ResultSet rs;
%>
<%
    Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/seniorretirementhomemanagementsystem","root","admin"); //create connection
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
        <link href="assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
        
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
                            <li><a href="usersetting.jsp"><i class="fa fa-user fa-fw"></i>Super Admin</a></li>
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
                        <li><a class="active-menu" href="settings.jsp"><i class="fa fa-dashboard"></i>User Dashboard</a></li>
                    </ul>
                </div>
            </nav>
            
            <!--  NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <h1 class="page-header">
                               ADMINISTRATOR<small> accounts </small>
                            </h1>
                        </div>
                    </div> 
                    <%
                        String sql = "SELECT * FROM admin";
                        pst=c.prepareStatement(sql);
                        rs=pst.executeQuery();
                    %>                
                    <div class="row">
                        <div class="col-md-12">
                            <!-- Advanced Tables -->
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                            <thead>
                                                <tr>
                                                    <th>User ID</th>
                                                    <th>User name</th>
                                                    <th>Password</th>
                                                    <th>Update</th>
                                                    <th>Remove</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    String us="",ps="";
                                                    int id=0;
                                                    while(rs.next()) {
                                                        id = rs.getInt("id");
                                                        us = rs.getString("username");
                                                        ps = rs.getString("pass");
                                                        if(id % 2 ==0 ) {
                                                %>
                                                <tr class='gradeC'>
                                                    <td><%=id%></td>
                                                    <td><%=us%></td>
                                                    <td><%=ps%></td>
                                                    <td><button class='btn btn-primary btn' data-toggle='modal' data-target='#myModal'> Update  </button></td>
                                                    <td><a href="deleteAdmin.jsp?eid=<%=id%>" <button class='btn btn-danger'> <i class='fa fa-edit' ></i> Delete</button></td>
                                                </tr>
                                                <%}
                                                    else
                                                {%>
                                                <tr class='gradeU'>
                                                    <td><%=id%></td>
                                                    <td><%=us%></td>
                                                    <td><%=ps%></td>
                                                    <td><button class='btn btn-primary btn' data-toggle='modal' data-target='#myModal'> Update </button></td>
                                                    <td><a href="deleteAdmin.jsp?eid=<%=id%>" <button class='btn btn-danger'> <i class='fa fa-edit' ></i> Delete</button></td>
                                                </tr>
                                                <%}
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            <!--End Advanced Tables -->
                            </div>
                            <div class="panel-body">
                                <button class="btn btn-primary btn" data-toggle="modal" data-target="#myModal1"> Add New Admin </button>
                                <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                <h4 class="modal-title" id="myModalLabel">Add the User name and Password</h4>
                                            </div>
                                            <form method="post">
                                                <div class="modal-body">
                                                    <div class="form-group">
                                                        <label>Add new User name</label>
                                                        <input name="newus"  class="form-control" placeholder="Enter User name">
                                                    </div>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="form-group">
                                                        <label>New Password</label>
                                                        <input name="newps"  class="form-control" placeholder="Enter Password">
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                    <input type="submit" name="in" value="Add" class="btn btn-primary">
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                            if(request.getParameter("in")!=null) {
                                String newus = request.getParameter("newus");
                                String newps = request.getParameter("newps");
                                String newsql ="Insert into admin (username,pass) values ('"+newus+"','"+newps+"')";
                                pst=c.prepareStatement(newsql);
                                int i=pst.executeUpdate();
                                if(i>0) {%>
                                    <script language="javascript" type="text/javascript"> alert("New Admin name and password Added") </script>
                                <%}
                                response.sendRedirect("admin.jsp");
                            }
                        %>
                        <div class="panel-body">
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Change the User name and Password</h4>
                                        </div>
                                        <form method="post" action="usersetting.jsp">
                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <label>Change User name</label>
                                                    <input name="usname" value="<%=us%>" class="form-control" placeholder="Enter User name">
                                                </div>
                                            </div>
                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <label>Change Password</label>
                                                    <input name="pasd" value="<%=ps%>" class="form-control" placeholder="Enter Password">
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                <input type="submit" name="up" value="Update" class="btn btn-primary">
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <!-- End Row -->
                    </div>
                    <!-- /. ROW  -->
                    <% 
                        if(request.getParameter("up")!=null) {
                            String usname = request.getParameter("usname");
                            String passwr = request.getParameter("pasd");
                             
                            String upsql = "UPDATE admin SET usname='"+usname+"',pass='"+passwr+"' WHERE id = "+id;
                            pst=c.prepareStatement(upsql);
                            int i=pst.executeUpdate();
                            if(i>0) {%>
                                <script language="javascript" type="text/javascript"> alert("User name and password updated") </script>
                            <%}
                            response.sendRedirect("admin.jsp");
                        }												
                    %>
                <!-- END PAGE INNER  -->
                </div>
             <!-- END PAGE WRAPPER  -->
            </div>
         <!-- END WRAPPER  -->
        </div>
    </body>
</html>
