<%-- 
    Document   : roombook
    Created on : Jun 17, 2022, 11:16:06 PM
    Author     : fakhr
--%>
<%@page import="java.text.*,java.sql.*" errorPage="error.jsp"%>
<%!
	String curdate,title,fname,lname,email,nat,country,phone,troom,bed,tpackage,cin,cout,sta;
	int nroom,days;
	PreparedStatement ps;
	ResultSet rs;
	public static String getDate() {
            DateFormat df=new SimpleDateFormat("yyyy-MMM-dd");
            String date=df.format(new java.util.Date());
            return date;
	}
%>
<%
    Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/seniorretirementhomemanagementsystem","root","admin"); //create connection	
    String user=(String)session.getAttribute("user");
    String rid1=request.getParameter("rid");
    int id=0;
    if(rid1==null) {	
	response.sendRedirect("home.jsp");
    } else {
	curdate=getDate();
	id =Integer.parseInt(rid1);
				
	String q ="Select * from roombook where id = ?";			
	ps=c.prepareStatement(q,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	ps.setInt(1,id);
	ResultSet rs=ps.executeQuery();				
	while(rs.next()) {
            title = rs.getString("title");
            fname = rs.getString("fname");
            lname = rs.getString("lname");
            email = rs.getString("email");
            country = rs.getString("country");
            phone = rs.getString("phone");
            troom = rs.getString("troom");
            nroom = Integer.parseInt(rs.getString("nroom"));
            bed = rs.getString("bed");
            tpackage = rs.getString("tpackage");
            cin = rs.getString("cin");
            cout = rs.getString("cout");
            sta = rs.getString("stat");
            days = rs.getInt("nodays");											
	}					
    }						
%> 

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Administrator	</title>
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
    </head>

    <body>
        <div id="wrapper">
            <nav class="navbar navbar-default top-navbar" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="home.jsp"> <%=user%> </a>
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
                        <li><a  href="home.jsp"><i class="fa fa-dashboard"></i> Status</a> </li>
                        <li><a class="active-menu" href="roombook.jsp"><i class="fa fa-bar-chart-o"></i> Room Booking</a></li>
                        <li><a href="payment.jsp"><i class="fa fa-qrcode"></i> Payment</a></li>
                        <li><a  href="profit.jsp"><i class="fa fa-qrcode"></i> Profit</a></li>
                        <li><a href="logout.jsp"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
                    </ul>
                </div>
            </nav>

            <!-- /. NAV SIDE  -->
            <div id="page-wrapper">
                <div id="page-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <h1 class="page-header">
                                Room Booking<small>	<%=curdate%> </small>
                            </h1>
                        </div>			
                        <div class="col-md-8 col-sm-8">
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                   Booking Confirmation
                                </div>
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table class="table">
                                            <tr>
                                                <th>DESCRIPTION</th>
                                                <th>INFORMATION</th>
                                            </tr>
                                            <tr>
                                                <th>Name</th>
                                                <th><%=title%> <%=fname%> <%=lname%></th>
                                            </tr>
                                            <tr>
                                                <th>Email</th>
                                                <th><%=email%> </th>
                                            </tr>
                                            <tr>
                                                <th>Country </th>
                                                <th><%=country%></th>
                                            </tr>
                                            <tr>
                                                <th>Phone No </th>
                                                <th><%=phone%></th>
                                            </tr>
                                            <tr>
                                                <th>Type Of the Room </th>
                                                <th><%=troom%></th>
                                            </tr>
                                            <tr>
                                                <th>No Of the Room </th>
                                                <th><%=nroom%></th>
                                            </tr>
                                            <tr>
                                                <th>Package Plan </th>
                                                <th><%=tpackage%></th>
                                            </tr>
                                            <tr>
                                                <th>Bedding </th>
                                                <th><%=bed%></th>
                                            </tr>
                                            <tr>
                                                <th>Check-in Date </th>
                                                <th><%=cin%></th>
                                            </tr>
                                            <tr>
                                                <th>Check-out Date</th>
                                                <th><%=cout%></th>
                                            </tr>
                                            <tr>
                                                 <th>No of days</th>
                                                 <th><%=days%></th>
                                            </tr>
                                            <tr>
                                                <th>Status Level</th>
                                                <th><%=sta%></th>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="panel-footer">
                                    <form method="post">
                                        <div class="form-group">
                                            <label>Select the Confirmation</label>
                                            <select name="conf"class="form-control">
                                                <option value selected>	</option>
                                                <option value="Confirm">Confirm</option>
                                            </select>
                                        </div>
                                        <input type="submit" name="co" value="Confirm" class="btn btn-success">
                                    </form>
                                </div>
                            </div>
                        </div>
                        <%
                            String rsql ="select * from room";
                            ps=c.prepareStatement(rsql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                            rs=ps.executeQuery();	
                            int r =0 ;
                            int sc =0;
                            int gh = 0;
                            int sr = 0;
                            int dr = 0;
                            while(rs.next()) {
                                r = r + 1;
                                String s = rs.getString("type");
                                String p = rs.getString("place");
                                if(s.equals("Superior Room")) {
                                    sc = sc+ 1;
                                }							
                                if(s.equals("Guest House")) {
                                    gh = gh + 1;
                                }
                                if(s.equals("Single Room")) {
                                    sr = sr + 1;
                                }
                                if(s.equals("Deluxe Room")) {
                                    dr = dr + 1;
                                }	
                            }
                        %>						
                        <%
                            String csql ="select * from payment";
                            ps=c.prepareStatement(csql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                            rs=ps.executeQuery();
                            int cr =0 ;
                            int csc =0;
                            int cgh = 0;
                            int csr = 0;
                            int cdr = 0;
                            while(rs.next()) {
                                cr =cr + 1;
                                String cs = rs.getString("troom");

                                 if(cs.equals("Superior Room" )) {
                                    csc = csc + 1;
                                }
                                if(cs.equals("Guest House") ){
                                    cgh = cgh + 1;
                                }
                                if(cs.equals("Single Room") ){
                                    csr = csr + 1;
                                }
                                if(cs.equals("Deluxe Room") ) {
                                    cdr = cdr + 1;
                                }
                            }
                        %>
                        <div class="col-md-4 col-sm-4">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                   Available Room Details
                                </div>
                                <div class="panel-body">
                                    <table width="200px">
                                        <tr>
                                            <td><b>Superior Room</b></td>
                                            <td><button type="button" class="btn btn-primary btn-circle">
                                                    <%  
                                                        int f1 =sc - csc;
                                                        if(f1 <=0 ) {	
                                                            out.print("NO");
                                                        } else{
                                                            out.print(f1);
                                                        }		
                                                    %> 
                                                </button>
                                            </td> 
                                        </tr>
                                        <tr>
                                            <td><b>Guest House</b></td>
                                            <td><button type="button" class="btn btn-primary btn-circle">
                                                    <% 
                                                        int f2 =  gh -cgh;
                                                        if(f2 <=0 ) {	
                                                            out.print("NO");
                                                        } else{
                                                            out.print(f2);
                                                        }
                                                    %> 
                                                </button>
                                            </td> 
                                        </tr>
                                        <tr>
                                            <td><b>Single Room</b></td>
                                            <td><button type="button" class="btn btn-primary btn-circle">
                                                    <%
                                                        int f3 =sr - csr;
                                                        if(f3 <=0 ) {	
                                                            out.print("NO");
                                                        } else{
                                                            out.print(f3);
                                                        }
                                                    %> 
                                                </button>
                                            </td> 
                                        </tr>
                                        <tr>
                                            <td><b>Deluxe Room</b></td>
                                            <td><button type="button" class="btn btn-primary btn-circle">
                                                    <% 
                                                        int f4 =dr - cdr; 
                                                        if(f4 <=0 ){	
                                                            out.print("NO");
                                                        } else{
                                                            out.print(f4);
                                                        }
                                                    %> 
                                                </button>
                                            </td> 
                                        </tr>
                                        <tr>
                                            <td><b>Total Rooms</b> </td>
                                            <td><button type="button" class="btn btn-danger btn-circle">
                                                    <% 
                                                        int f5 =r-cr; 
                                                        if(f5 <=0 ) {	
                                                            out.print("NO");
                                                        } else{
                                                            out.print(f5);
                                                        }
                                                    %> 
                                                </button>
                                            </td> 
                                        </tr>
                                    </table>
                                </div>
                                <div class="panel-footer">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END ROW  -->		
                </div>
                <!-- PAGE INNER  -->					
            </div>
            <!--  END PAGE WRAPPER  -->
        </div>
        <!-- END WRAPPER  -->

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
    </body>
</html>

<%
    if(request.getParameter("co")!=null) {	
        String st = request.getParameter("conf");
        if(st.equals("Confirm")) {
            String urb = "UPDATE roombook SET stat='"+st+"' WHERE id = "+id;
            if(f1<=0) {%>
                <script type='text/javascript'> alert('Sorry! Not Available Superior Room ')</script>
            <%} else if(f2<=0) {%>
                <script type='text/javascript'> alert('Sorry! Not Available Guest House')</script>
            <%} else if (f3 <= 0) {%>
                <script type='text/javascript'> alert('Sorry! Not Available Single Room')</script>
            <%} else if(f4<=0) {%>
                <script type='text/javascript'> alert('Sorry! Not Available Deluxe Room')</script>
            <%} else {	
                ps=c.prepareStatement(urb);
                int i=ps.executeUpdate();
                double type_of_room = 0;       
                if(troom.equals("Superior Room")) {
                    type_of_room = 320;
                } else if(troom.equalsIgnoreCase("Deluxe Room")) {
                    type_of_room = 220;
                } else if(troom.equalsIgnoreCase("Guest House")) {
                    type_of_room = 180;
                } else if(troom.equalsIgnoreCase("Single Room")) {
                    type_of_room = 150;
                }
                double type_of_bed = 0; 											
                if(bed.equalsIgnoreCase("Single")) {
                    type_of_bed = type_of_room * 4/100;
                } else if(bed.equalsIgnoreCase("Double")) {
                    type_of_bed = type_of_room * 5/100;
                } else if(bed.equalsIgnoreCase("Triple")) {
                    type_of_bed = type_of_room * 6/100;
                } else if(bed.equalsIgnoreCase("Quad")) {
                    type_of_bed = type_of_room * 7/100;
                } else if(bed.equalsIgnoreCase("None")) {
                    type_of_bed = type_of_room * 0/100;
                }
                double type_of_meal = 0; 											
                if(tpackage.equalsIgnoreCase("Package A")) {
                    type_of_meal=type_of_bed * 0;
                } else if(tpackage.equalsIgnoreCase("Package B")) {
                    type_of_meal=type_of_bed * 4;
                } else if(tpackage.equalsIgnoreCase("Package C")) {
                    type_of_meal=type_of_bed * 5;
                } else if(tpackage.equalsIgnoreCase("Package D")) {
                    type_of_meal=type_of_bed * 6;
                }
                double ttot = type_of_room * days * nroom;
                double mepr = type_of_meal * days;
                double btot = type_of_bed *days;
                double fintot = ttot + mepr + btot ;

                String psql = "INSERT INTO payment(id, title, fname, lname, troom, tbed, nroom, cin, cout, totalPrice_room,tpackage, totalPrice_package, totalPrice_bed,totalAll,noofdays) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                ps=c.prepareStatement(psql);
                ps.setInt(1,id);
                ps.setString(2,title);
                ps.setString(3,fname);
                ps.setString(4,lname);
                ps.setString(5,troom);
                ps.setString(6,bed);
                ps.setInt(7,nroom);
                ps.setString(8,cin);
                ps.setString(9,cout);
                ps.setDouble(10,ttot);
                ps.setString(11,tpackage);
                ps.setDouble(12,mepr);
                ps.setDouble(13,btot);
                ps.setDouble(14,fintot);
                ps.setInt(15,days);
                int i1=ps.executeUpdate();
                if(i1>0) {	
                    String notfree="NotFree";
                    String rpsql = "UPDATE room SET place='"+notfree+"' where bedding ='"+bed+"' and type='"+troom+"' ";
                    ps=c.prepareStatement(rpsql);
                    int i2=ps.executeUpdate();
                    if(i2>0) {	
                        response.sendRedirect("home.jsp");
                        %><script type='text/javascript'> alert('Booking Confirm');</script>
                        <script type='text/javascript'> window.location='home.jsp'</script>
                    <%}
                }
            }
        }	
    }
%>