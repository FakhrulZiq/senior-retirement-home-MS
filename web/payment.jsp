<%-- 
    Document   : payment
    Created on : Jun 18, 2022, 1:18:37 AM
    Author     : fakhr
--%>
<%@page import="java.sql.*" errorPage="error.jsp"%>
<%
    String user=(String)session.getAttribute("user");
    Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/seniorretirementhomemanagementsystem","root","admin"); //create connection	
    PreparedStatement ps;
    ResultSet rs;
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
        <!-- Morris Chart Styles-->
   
        <!-- Custom Styles-->
        <link href="assets/css/custom-styles.css" rel="stylesheet" />
        <!-- Google Fonts-->
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
        <!-- TABLE STYLES-->
        <link href="assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
        
        <!-- JS Scripts-->
        <!-- jQuery Js -->
        <script src="assets/js/jquery-1.10.2.js"></script>
        <!-- Bootstrap Js -->
        <script src="assets/js/bootstrap.min.js"></script>
        <!-- Metis Menu Js -->
        <script src="assets/js/jquery.metisMenu.js"></script>
        <!-- DATA TABLE SCRIPTS -->
        <script src="assets/js/dataTables/jquery.dataTables.js"></script>
        <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
        <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
            });
        </script>
        <!-- Custom Js -->
        <script src="assets/js/custom-scripts.js"></script>
    </head>
    <body>
        <%
            if(session.getAttribute("user")==null || session.getAttribute("user")==" ") {//check condition unauthorize user not direct access welcome.jsp page
                response.sendRedirect("loginStaff.jsp"); 
            }
        %>
        <!-- wrapper -->
        <div id="wrapper">
            <nav class="navbar navbar-default top-navbar" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="home.jsp"><%=user%> </a>
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
                        <!-- dropdown-user -->
                    </li>
                    <!-- dropdown -->
                </ul>
            </nav>
                
            <!-- NAV TOP  -->
            <nav class="navbar-default navbar-side" role="navigation">
                <div class="sidebar-collapse">
                    <ul class="nav" id="main-menu">
                        <li><a href="home.jsp"><i class="fa fa-dashboard"></i> Status</a></li>
                        <li><a href="roombook.jsp"><i class="fa fa-bar-chart-o"></i>Room Booking</a></li>
                        <li><a class="active-menu" href="payment.jsp"><i class="fa fa-qrcode"></i> Payment</a></li>
                        <li><a  href="room.jsp"><i class="fa fa-qrcode"></i> Manage Room</a></li>
                        <li><a  href="reservation.jsp"><i class="fa fa-qrcode"></i>Reservation</a></li>
                        <li><a href="logout.jsp" ><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>  
                    </ul>
                </div>
            </nav>
            
            <!--  NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <h1 class="page-header">
                               Payment Details<small> </small>
                            </h1>
                        </div>
                    </div> 
                    
                    <!-- ROW  -->
                     <div class="row">
                        <div class="col-md-12">
                            <!-- Advanced Tables -->
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                            <thead>
                                                <tr>
                                                    <th>Name</th>
                                                    <th>Room type</th>
                                                    <th>Bed Type</th>
                                                    <th>Check in</th>
                                                    <th>Check out</th>
                                                    <th>No of Room</th>
                                                    <th>Type of Package</th>
                                                    <th>Room Rent</th>
                                                    <th>Bed Rent</th>
                                                    <th>Total Package</th>
                                                    <th>Total All</th>
                                                    <th>Print</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    String q="select * from payment";
                                                    ps=c.prepareStatement(q);
                                                    rs=ps.executeQuery();		
                                                    while(rs.next()) {
                                                        int id = rs.getInt("id");
                                                        if(id % 2 ==1 ) {
                                                %>
                                                <tr class='gradeC'>
                                                    <td><%=rs.getString("title")%> <%=rs.getString("fname")%> <%=rs.getString("lname")%></td>
                                                    <td><%=rs.getString("troom")%></td>
                                                    <td><%=rs.getString("tbed")%></td>
                                                    <td><%=rs.getString("cin")%></td>
                                                    <td><%=rs.getString("cout")%></td>
                                                    <td><%=rs.getString("nroom")%></td>
                                                    <td><%=rs.getString("tpackage")%></td>
                                                    <td><%=rs.getString("totalPrice_room")%></td>
                                                    <td><%=rs.getString("totalPrice_package")%></td>
                                                    <td><%=rs.getString("totalPrice_bed")%></td>
                                                    <td><%=rs.getString("totalAll")%></td>
                                                    <td><a href="print.jsp?pid=<%=id%>" <button class='btn btn-primary'> <i class='fa fa-print' ></i> Print</button></td>
                                                </tr>
                                                <%}
                                                    else {
                                                %>
                                                <tr class='gradeU'>
                                                    <td><%=rs.getString("title")%> <%=rs.getString("fname")%> <%=rs.getString("lname")%></td>
                                                    <td><%=rs.getString("troom")%></td>
                                                    <td><%=rs.getString("tbed")%></td>
                                                    <td><%=rs.getString("cin")%></td>
                                                    <td><%=rs.getString("cout")%></td>
                                                    <td><%=rs.getString("nroom")%></td>
                                                    <td><%=rs.getString("tpackage")%></td>
                                                    <td><%=rs.getString("totalPrice_room")%></td>
                                                    <td><%=rs.getString("totalPrice_package")%></td>
                                                    <td><%=rs.getString("totalPrice_bed")%></td>
                                                    <td><%=rs.getString("totalAll")%></td>
                                                    <td><a href=print.jsp?pid="+id ." <button class='btn btn-primary'> <i class='fa fa-print' ></i> Print</button></td>
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
                        </div>
                    <!-- End Row  -->
                    </div>
                <!-- End Page Inner  -->
                </div>
            <!-- End Nav Slide -->
            </div>
        <!-- End Wrapper  --> 
        </div>
    </body>
</html>
