<%-- 
    Document   : home
    Created on : Jun 17, 2022, 8:44:08 PM
    Author     : fakhr
--%>
<%@page import="java.sql.*" errorPage="error.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>SRHMS</title>
        
        <!-- CSS -->
        <!-- Bootstrap Styles-->
        <link href="assets/css/bootstrap.css" rel="stylesheet" />
        <!-- FontAwesome Styles-->
        <link href="assets/css/font-awesome.css" rel="stylesheet" />
        <!-- Morris Chart Styles-->
        <link href="assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
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
        <!-- Morris Chart Js -->
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>
        <!-- Custom Js -->
        <script src="assets/js/custom-scripts.js"></script>
        
    </head>
    <body>
        <%
            if(session.getAttribute("user")==null || session.getAttribute("user")==" ") {//check condition unauthorize user not direct access welcome.jsp page
                response.sendRedirect("login.jsp"); 
            }
        %>
        
        <!-- WARAPPER -->
        <div id="wrapper">
            <!-- NAV USER -->
            <nav class="navbar navbar-default top-navbar" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="home.jsp"> <%String un=(String)session.getAttribute("user");%><%=un%> </a>
                </div>
                <ul class="nav navbar-top-links navbar-right">
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                            <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                            <li><a href="admin.jsp"><i class="fa fa-user fa-fw"></i>Super Admin</a></li>
                            <li class="divider"></li>
                            <li><a href="logout.jsp"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
                
            <!--/. NAV TOP  -->
            <nav class="navbar-default navbar-side" role="navigation">
                <div class="sidebar-collapse">
                    <ul class="nav" id="main-menu">
                        <li><a class="active-menu" href="#"><i class="fa fa-dashboard"></i> Status</a></li>
                        <li><a href="roombook.jsp"><i class="fa fa-bar-chart-o"></i> Room Booking</a></li>
                        <li><a href="payment.jsp"><i class="fa fa-qrcode"></i> Payment</a></li>
                        <li><a  href="room.jsp"><i class="fa fa-qrcode"></i> Manage Room</a></li>
                        <li><a  href="reservation.jsp"><i class="fa fa-qrcode"></i>Reservation</a></li>
                        <li><a href="logout.jsp"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
                    </ul>
                </div>
            </nav>
            
            <!-- /. PAGE WRAPPER  -->
            <div id="page-wrapper">
                <!-- PAGE INNER -->
                <div id="page-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <h1 class="page-header">
                                Status <small>Room Booking </small>
                            </h1>
                        </div>
                    </div>
                   <%
			try {
                            Class.forName("com.mysql.jdbc.Driver"); //load driver

                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/seniorretirementhomemanagementsystem","root","admin"); //create connection		
                            String q = "select * from roombook where stat=?";
                            PreparedStatement ps=con.prepareStatement(q,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                            ps.setString(1,"Not Confirm");
                            ResultSet rs = ps.executeQuery();
                            rs.last();
                            int c1=rs.getRow();
                            rs.first();
                            rs.previous();																
                    %>
                    
                    <!-- /. ROW  -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-default">
                                <div class="panel-heading"></div>
                                <div class="panel-body">
                                    <div class="panel-group" id="accordion">
                                        <div class="panel panel-primary">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
                                                        <button class="btn btn-default" type="button">
                                                            New Room Bookings  <span class="badge"><%=c1%></span>
                                                        </button>
                                                    </a>
                                                </h4>
                                            </div>
                                            <div id="collapseTwo" class="panel-collapse in" style="height: auto;">
                                                <!-- basic table -->
                                                <div class="panel-body">
                                                    <div class="panel panel-default">
                                                        <div class="panel-body">
                                                            <div class="table-responsive">
                                                                <table class="table">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>#</th>
                                                                            <th>Name</th>
                                                                            <th>Email</th>
                                                                            <th>Country</th>
                                                                            <th>Room</th>
                                                                            <th>Bedding</th>
                                                                            <th>Package</th>
                                                                            <th>Check In</th>
                                                                            <th>Check Out</th>
                                                                            <th>Status</th>
                                                                            <th>More</th>					
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>     
                                                                    <%			
                                                                        while(rs.next()){	
                                                                            int id=rs.getInt("id");
                                                                    %>
                                                                        <tr>
                                                                            <th><%=id%></th>
                                                                            <th><%=rs.getString("fname")%> <%=rs.getString("lname")%></th>
                                                                            <th><%=rs.getString("email")%></th>
                                                                            <th><%=rs.getString("country")%></th>
                                                                            <th><%=rs.getString("troom")%></th>
                                                                            <th><%=rs.getString("bed")%></th>
                                                                            <th><%=rs.getString("tpackage")%></th>
                                                                            <th><%=rs.getString("cin")%></th>
                                                                            <th><%=rs.getString("cout")%></th>
                                                                            <th><%=rs.getString("stat")%></th>
                                                                            <th><a href="roombook.jsp?rid=<%=id%>" class='btn btn-primary'>Action</a></th>
                                                                        </tr>
									<%}%>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                <!-- End  Basic Table  --> 
                                                </div>
                                            </div>
                                        </div>
                                        <%
                                            String q2 = "SELECT * FROM roombook where stat=?";
                                            ps=con.prepareStatement(q2,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                                            ps.setString(1,"Confirm");
                                            rs=ps.executeQuery();	
                                            rs.last();
                                            int r=rs.getRow();
                                            rs.first();
                                            rs.previous();							
					%>
                                        <div class="panel panel-info">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="collapsed">
                                                        <button class="btn btn-primary" type="button">
                                                            Booked Rooms  <span class="badge"><%=r%></span>
                                                        </button>
                                                    </a>
                                                </h4>
                                            </div>
                                            <div id="collapseOne" class="panel-collapse collapse" style="height: 0px;">
                                                <div class="panel-body">
                                                    <%
                                                        while(rs.next()){			
                                                            int id = rs.getInt("id");
                                                    %>
                                                    <div class='col-md-3 col-sm-12 col-xs-12'>
                                                        <div class='panel panel-primary text-center no-boder bg-color-blue'>
                                                            <div class='panel-body'>
                                                                <i class='fa fa-users fa-5x'></i>
                                                                <h3><%=rs.getString("fname")%></h3>
                                                            </div>
                                                            <div class='panel-footer back-footer-blue'>
                                                                <a href="show.jsp?sid=<%=id%>">
                                                                    <button  class='btn btn-primary btn' data-toggle='modal' data-target='#myModal'> Show </button>
                                                                </a>
                                                                <%=rs.getString("troom")%>
                                                                <a href="customerdel.jsp?sid=<%=id%>" style="color:brown;font-weight:bold">Delete</a>
                                                            </div>
                                                        </div>	
                                                    </div>																																																				
                                                    <%	} %>
                                                </div>						
                                            </div>						
                                        </div>
                                        <%
                                            con.close();
                                            } catch (Exception e) {
                                                out.println(e);
                                            }	
                                        %>    
                                    </div>
                                </div>
                            </div>
                        </div>
            
                        <!-- DEOMO-->
                        <div class='panel-body'>
                            <button class='btn btn-primary btn' data-toggle='modal' data-target='#myModal'>
                                Update 
                            </button>
                            <div class='modal fade' id='myModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>
                                <div class='modal-dialog'>
                                    <div class='modal-content'>
                                        <div class='modal-header'>
                                            <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>
                                            <h4 class='modal-title' id='myModalLabel'>Change the User name and Password</h4>
                                        </div>
                                        <form method="post">
                                            <div class='modal-body'>
                                                <div class='form-group'>
                                                    <label>Change User name</label>
                                                    <input name='usname' value='<%=un%>' class='form-control' placeholder='Enter User name'>
                                                </div>
                                            </div>
                                            <div class='modal-body'>
                                                <div class='form-group'>
                                                    <label>Change Password</label>
                                                    <input name='pasd' value='' class='form-control' placeholder='Enter Password'>
                                                </div>
                                            </div>
                                            <div class='modal-footer'>
                                                <button type='button' class='btn btn-default' data-dismiss='modal'>Close</button>
                                                <input type='submit' name='up' value='Update' class='btn btn-primary'>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--end DEMO-->    
                    </div>
                    <!-- /.end ROW  -->	
                </div>
                <!-- /. PAGE INNER  -->
            </div>
            <!-- /. PAGE WRAPPER  -->
        </div>
        <!-- /. WRAPPER  -->
    </body>
</html>
