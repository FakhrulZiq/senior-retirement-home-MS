<%-- 
    Document   : room
    Created on : Jun 18, 2022, 2:56:11 AM
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
        
        <!-- CSS -->
            <!-- Bootstrap Styles-->
            <link href="assets/css/bootstrap.css" rel="stylesheet" />
            <!-- FontAwesome Styles-->
            <link href="assets/css/font-awesome.css" rel="stylesheet" />
            <!-- Custom Styles-->
            <link href="assets/css/custom-styles.css" rel="stylesheet" />
            <!-- Google Fonts-->
            <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
        <!-- END CSS -->
       
        <!-- JS Scripts-->
            <!-- jQuery Js -->
            <script src="assets/js/jquery-1.10.2.js"></script>
            <!-- Bootstrap Js -->
            <script src="assets/js/bootstrap.min.js"></script>
            <!-- Metis Menu Js -->
            <script src="assets/js/jquery.metisMenu.js"></script> 
            <!-- Custom Js -->
            <script src="assets/js/custom-scripts.js"></script>
        <!-- END JS SCRIPTS -->
        
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
                            <li><a href="usersetting.jsp"><i class="fa fa-user fa-fw"></i> User Profile</a></li>
                            <li class="divider"></li>
                            <li><a href="logout.jsp"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
                        </ul>		
                        <!-- /.dropdown-user -->
                    </li>
                    <!-- /.dropdown -->
                </ul>
            </nav>

            <!--/. NAV TOP  -->
            <nav class="navbar-default navbar-side" role="navigation">
                <div class="sidebar-collapse">
                    <ul class="nav" id="main-menu">
                        <li><a href="room.jsp"><i class="fa fa-dashboard"></i>Rooms Status</a></li>
                        <li><a  class="active-menu" href="addroom.jsp"><i class="fa fa-plus-circle"></i>Add Room</a></li>
                        <li><a  href="roomdel.jsp"><i class="fa fa-desktop"></i> Delete Room</a></li>
                    </ul>		
                </div>
            </nav>

            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <!-- PAGE INNER -->
                <div id="page-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <h1 class="page-header">
                               NEW ROOM <small></small>
                            </h1>
                        </div>
                    </div> 

                    <div class="row">
                        <div class="col-md-5 col-sm-5">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    ADD NEW ROOM
                                </div>
                                <div class="panel-body">
                                    <form name="form" method="post">
                                        <div class="form-group">
                                            <label>Type Of Room *</label>
                                            <select name="troom" class="form-control" required>
                                                <option value selected ></option>
                                                <option value="Superior Room">SUPERIOR ROOM</option>
                                                <option value="Deluxe Room">DELUXE ROOM</option>
                                                <option value="Guest House">GUEST HOUSE</option>
                                                <option value="Single Room">SINGLE ROOM</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Bedding Type</label>
                                            <select name="bed" class="form-control" required>
                                                <option value selected ></option>
                                                <option value="Single">Single</option>
                                                <option value="Double">Double</option>
                                                <option value="Triple">Triple</option>
                                                <option value="Quad">Quad</option>
                                                <option value="Triple">None</option>                                              
                                            </select>           
                                        </div>
                                        <input type="submit" name="add" value="Add New" class="btn btn-primary"> 
                                    </form>
                                    <%
                                        if(request.getParameter("add")!=null){
                                            String room = request.getParameter("troom");
                                            String bed = request.getParameter("bed");
                                            String place = "Free";

                                            String check="SELECT * FROM room WHERE type = '"+room+"' AND bedding = '"+bed+"'";
                                            pst=c.prepareStatement(check);
                                            rs=pst.executeQuery();
                                            if(rs.next()) { %>
                                                <script type='text/javascript'> alert('Room Already Exists')</script>
                                            <%} else {
                                                String sql ="INSERT INTO room( type, bedding,place) VALUES ('"+room+"','"+bed+"','"+place+"')" ;
                                                pst=c.prepareStatement(sql);
                                                int i=pst.executeUpdate();
                                                if(i>0){ %>
                                                    <script>alert("New Room Added") </script>
                                                <%}else {%>
                                                    <script>alert("Sorry ! Check The System") </script>
                                                <%}
                                            }
                                        }
                                    %>
                                </div>  
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 col-sm-6">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        ROOMS INFORMATION
                                    </div>
                                    <div class="panel-body">

                                        <!-- Advanced Tables -->
                                        <div class="panel panel-default">
                                            <%
                                                String sql = "select * from room";// limit 0,10";
                                                pst=c.prepareStatement(sql);
                                                rs=pst.executeQuery();
                                            %>
                                            <div class="panel-body">
                                                <div class="table-responsive">
                                                    <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                                        <thead>
                                                            <tr>
                                                                <th>Room ID</th>
                                                                <th>Room Type</th>
                                                                <th>Bedding</th> 
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        <%
                                                            int id=0;
                                                            while(rs.next()){
                                                                id = rs.getInt("id");
                                                                if(id % 2 == 0){%>
                                                            <tr class=odd gradeX>
                                                                <td><%=id%></td>
                                                                <td><%=rs.getString("type")%></td>
                                                                <th><%=rs.getString("bedding")%></th>
                                                            </tr>
                                                                <%} else {%>
                                                            <tr class=even gradeC>
                                                                <td><%=id%></td>
                                                                <td><%=rs.getString("type")%></td>
                                                                <th><%=rs.getString("bedding")%></th>
                                                            </tr>
                                                                <%}
                                                                    }
                                                                %>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <!--End Advanced Tables -->				   
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <!-- /. PAGE INNER  -->
                </div>
             <!-- /. PAGE WRAPPER  -->
            </div>
         <!-- /. WRAPPER  -->
        </div>

        
    </body>
</html>
