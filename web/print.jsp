<%-- 
    Document   : print
    Created on : Jun 18, 2022, 1:35:10 AM
    Author     : fakhr
--%>
<%@page import="java.sql.*" errorPage="error.jsp"%>
<%!
    String title,fname,lname,troom,bed,cin,cout,tpackage;
    int id,nroom,days,totalPrice_room,totalPrice_package,totalPrice_bed,fintot;
    PreparedStatement ps;
    ResultSet rs;
%>
<html>
    <head>
	<meta charset="utf-8">
	<title>Invoice</title>
	<link rel="stylesheet" href="style.css">
	<link rel="license" href="https://www.opensource.org/licenses/mit-license/">
	<script src="script.js"></script>
	<style>
            /* reset */
            *{
                border: 0;
                box-sizing: content-box;
                color: inherit;
                font-family: inherit;
                font-size: inherit;
                font-style: inherit;
                font-weight: inherit;
                line-height: inherit;
                list-style: none;
                margin: 0;
                padding: 0;
                text-decoration: none;
                vertical-align: top;
            }
            
            /* content editable */
            *[contenteditable] { border-radius: 0.25em; min-width: 1em; outline: 0; }
            *[contenteditable] { cursor: pointer; }
            *[contenteditable]:hover, *[contenteditable]:focus, td:hover *[contenteditable], td:focus *[contenteditable], img.hover { background: #DEF; box-shadow: 0 0 1em 0.5em #DEF; }
            span[contenteditable] { display: inline-block; }
            
            /* heading */
            h1 { font: bold 100% sans-serif; letter-spacing: 0.5em; text-align: center; text-transform: uppercase; }
            
            /* table */
            table { font-size: 75%; table-layout: fixed; width: 100%; }
            table { border-collapse: separate; border-spacing: 2px; }
            th, td { border-width: 1px; padding: 0.5em; position: relative; text-align: left; }
            th, td { border-radius: 0.25em; border-style: solid; }
            th { background: #EEE; border-color: #BBB; }
            td { border-color: #DDD; }
            
            /* page */
            html { font: 16px/1 'Open Sans', sans-serif; overflow: auto; padding: 0.5in; }
            html { background: #999; cursor: default; }
            body { box-sizing: border-box; height: 11in; margin: 0 auto; overflow: hidden; padding: 0.5in; width: 8.5in; }
            body { background: #FFF; border-radius: 1px; box-shadow: 0 0 1in -0.25in rgba(0, 0, 0, 0.5); }
            
            /* header */
            header { margin: 0 0 3em; }
            header:after { clear: both; content: ""; display: table; }
            header h1 { background: #000; border-radius: 0.25em; color: #FFF; margin: 0 0 1em; padding: 0.5em 0; }
            header address { float: left; font-size: 75%; font-style: normal; line-height: 1.25; margin: 0 1em 1em 0; }
            header address p { margin: 0 0 0.25em; }
            header span, header img { display: block; float: right; }
            header span { margin: 0 0 1em 1em; max-height: 25%; max-width: 60%; position: relative; }
            header img { max-height: 100%; max-width: 100%; }
            header input { cursor: pointer; -ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=0)"; height: 100%; left: 0; opacity: 0; position: absolute; top: 0; width: 100%; }
            
            /* article */
            article, article address, table.meta, table.inventory { margin: 0 0 3em; }
            article:after { clear: both; content: ""; display: table; }
            article h1 { clip: rect(0 0 0 0); position: absolute; }
            article address { float: left; font-size: 125%; font-weight: bold; }
            
            /* table meta & balance */
            table.meta, table.balance { float: right; width: 36%; }
            table.meta:after, table.balance:after { clear: both; content: ""; display: table; }
            
            /* table meta */
            table.meta th { width: 40%; }
            table.meta td { width: 60%; }
            
            /* table items */
            table.inventory { clear: both; width: 100%; }
            table.inventory th { font-weight: bold; text-align: center; }
            table.inventory td:nth-child(1) { width: 26%; }
            table.inventory td:nth-child(2) { width: 38%; }
            table.inventory td:nth-child(3) { text-align: right; width: 12%; }
            table.inventory td:nth-child(4) { text-align: right; width: 12%; }
            table.inventory td:nth-child(5) { text-align: right; width: 12%; }

            /* table balance */
            table.balance th, table.balance td { width: 50%; }
            table.balance td { text-align: right; }

            /* aside */

            aside h1 { border: none; border-width: 0 0 1px; margin: 0 0 1em; }
            aside h1 { border-color: #999; border-bottom-style: solid; }

            /* javascript */
            .add, .cut{
                border-width: 1px;
                display: block;
                font-size: .8rem;
                padding: 0.25em 0.5em;	
                float: left;
                text-align: center;
                width: 0.6em;
            }
            .add, .cut
            {
                background: #9AF;
                box-shadow: 0 1px 2px rgba(0,0,0,0.2);
                background-image: -moz-linear-gradient(#00ADEE 5%, #0078A5 100%);
                background-image: -webkit-linear-gradient(#00ADEE 5%, #0078A5 100%);
                border-radius: 0.5em;
                border-color: #0076A3;
                color: #FFF;
                cursor: pointer;
                font-weight: bold;
                text-shadow: 0 -1px 2px rgba(0,0,0,0.333);
            }
            .add { margin: -2.5em 0 0; }
            .add:hover { background: #00ADEE; }
            .cut { opacity: 0; position: absolute; top: 0; left: -1.5em; }
            .cut { -webkit-transition: opacity 100ms ease-in; }
            tr:hover .cut { opacity: 1; }
            @media print {
                * { -webkit-print-color-adjust: exact; }
                html { background: none; padding: 0; }
                body { box-shadow: none; margin: 0; }
                span:empty { display: none; }
                .add, .cut { display: none; }
            }
            @page { margin: 0; }
        </style>	
    </head>
    <body>
	<%
            if(session.getAttribute("user")==null || session.getAttribute("user")==" ") {//check condition unauthorize user not direct access welcome.jsp page
                response.sendRedirect("login.jsp"); 
            }
        %>
	
	<%
            Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/seniorretirementhomemanagementsystem","root","admin"); //create connection	
            int pid = Integer.parseInt(request.getParameter("pid"));
            String q ="select * from payment where id = "+pid;
            ps=c.prepareStatement(q);
            rs=ps.executeQuery();

            while(rs.next()) {
		id = rs.getInt("id");
		title =  rs.getString("Title");
		fname = rs.getString("FName");
		lname = rs.getString("LName");
		troom = rs.getString("troom");
		bed = rs.getString("tbed");
		nroom = rs.getInt("nroom");
		cin = rs.getString("cin");
		cout = rs.getString("cout");
		tpackage = rs.getString("tpackage");
		totalPrice_room = rs.getInt("totalPrice_room");
		totalPrice_package = rs.getInt("totalPrice_package");
		totalPrice_bed = rs.getInt("totalPrice_bed");
		fintot = rs.getInt("totalAll");
		days = rs.getInt("noofdays");
            }
	
            double type_of_room = 0;       
            double type_of_bed = 0;       
            double type_of_meal = 0;       
            
            if(troom.equalsIgnoreCase("Superior Room")) {
		type_of_room = 320;
            } else if(troom.equalsIgnoreCase("Deluxe Room")) {
		type_of_room = 220;
            } else if(troom.equalsIgnoreCase("Guest House")) {
		type_of_room = 180;
            } else if(troom.equalsIgnoreCase("Single Room")) {
		type_of_room = 150;
            } 
            if(bed.equalsIgnoreCase("Single")) {
		type_of_bed = type_of_room * 1/100;
            } else if(bed.equalsIgnoreCase("Double")) {
		type_of_bed = type_of_room * 2/100;
            } else if(bed.equalsIgnoreCase("Triple")) {
		type_of_bed = type_of_room * 3/100;
            } else if(bed.equalsIgnoreCase("Quad")) {
                type_of_bed = type_of_room * 4/100;
            } else if(bed.equalsIgnoreCase("None")) {
		type_of_bed = type_of_room * 0/100;
            }
            if(tpackage.equalsIgnoreCase("Room only")) {
		type_of_meal=type_of_bed * 0;
            } else if(tpackage.equalsIgnoreCase("Breakfast")) {
		type_of_meal=type_of_bed * 2;
            } else if(tpackage.equalsIgnoreCase("Half Board")) {
		type_of_meal=type_of_bed * 3;
            } else if(tpackage.equalsIgnoreCase("Full Board")) {
		type_of_meal=type_of_bed * 4;
            }
	%>
	<header>
            <h1>Invoice</h1>
            <address>
		<p>MENTARI Retirement Home,</p>
		<p>Jalan Panglima Megah,<br>Kuala Terengganu,<br>Malaysia.</p>
		<p>(+60) 011-4935 0493</p>
            </address>
            <span><img alt="" src="assets/img/Mentari.png"></span>
	</header>
	<article>
            <h1>Recipient</h1>
            <address>
		<p><%=title%> <%=fname%> <%=lname%> <br></p>
            </address>
            
            <table class="meta">
		<tr>
                    <th><span >Invoice #</span></th>
                    <td><span ><%=id%></span></td>
		</tr>
		<tr>
                    <th><span >Date</span></th>
                    <td><span ><%=cout%> </span></td>
		</tr>
            </table>
            
            <table class="inventory">
		<thead>
                    <tr>
			<th><span >Item</span></th>
			<th><span >No of Days</span></th>
			<th><span >Rate</span></th>
			<th><span >Quantity</span></th>
			<th><span >Price</span></th>
                    </tr>
		</thead>
		<tbody>
                    <tr>
			<td><span ><%=troom%></span></td>
			<td><span ><%=days%> </span></td>
			<td><span data-prefix>RM </span><span ><%=type_of_room%></span></td>
			<td><span ><%=nroom%> </span></td>
			<td><span data-prefix>RM </span><span><%=totalPrice_room%></span></td>
                    </tr>
                    <tr>
			<td><span ><%=bed%>  Bed </span></td>
			<td><span ><%=days%></span></td>
			<td><span data-prefix>RM </span><span ><%=type_of_bed%></span></td>
			<td><span ><%=nroom%> </span></td>
			<td><span data-prefix>RM </span><span><%=totalPrice_bed%></span></td>
                    </tr>
                    <tr>
			<td><span ><%=tpackage%>  </span></td>
			<td><span ><%=days%></span></td>
			<td><span data-prefix>RM </span><span ><%=type_of_meal%></span></td>
			<td><span ><%=nroom%> </span></td>
			<td><span data-prefix>RM </span><span><%=totalPrice_package%></span></td>
                    </tr>
		</tbody>
            </table>
                    
            <table class="balance">
		<tr>
                    <th><span >Total</span></th>
                    <td><span data-prefix>RM </span><span><%=fintot%></span></td>
		</tr>
		<tr>
                    <th><span >Amount Paid</span></th>
                    <td><span data-prefix>RM </span><span >0.00</span></td>
		</tr>
		<tr>
                    <th><span >Balance Due</span></th>
                    <td><span data-prefix>RM </span><span><%=fintot%></span></td>
		</tr>
            </table>
	</article>
	<aside>
            <h1><span >Contact us</span></h1>
		<div>
                    <p align="center">Email :- info@mentarirh.com || Web :- www.mentariretirementhome.com || Phone :- +60 011-4935 0493 </p>
		</div>
	</aside>
    </body>
</html>

<%
    String free="Free";
    String rpsql = "UPDATE room SET place='"+free+"' where cusid="+id;
    ps=c.prepareStatement(rpsql);
    int i=0;//ps.executeUpdate();
    if(i>0) {
	String delsql= "DELETE FROM roombook WHERE id="+id;
	ps=c.prepareStatement(delsql);
	int ii=0;//ps.executeUpdate();
	if(ii>0)
	{%>
		<script type='text/javascript'> alert("Record Deleted.")</script>	
	<%}
    }
%>

