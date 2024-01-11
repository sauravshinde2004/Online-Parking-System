<%-- 
    Document   : User_login
    Created on : 18 Mar, 2021, 11:09:55 AM
    Author     : JAVA-JP
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.lang.String"%>
<%@page import="java.sql.Statement"%>
<%@page import="DBconnection.SQLconnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Online Parking Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="" />
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <!-- Facebook and Twitter integration -->
        <meta property="og:title" content=""/>
        <meta property="og:image" content=""/>
        <meta property="og:url" content=""/>
        <meta property="og:site_name" content=""/>
        <meta property="og:description" content=""/>
        <meta name="twitter:title" content="" />
        <meta name="twitter:image" content="" />
        <meta name="twitter:url" content="" />
        <meta name="twitter:card" content="" />

        <link rel="shortcut icon" href="favicon.ico">
        <link href="https://fonts.googleapis.com/css?family=Quicksand:300,400,500,700" rel="stylesheet">
        <!-- Animate.css -->
        <link rel="stylesheet" href="css/animate.css">
        <!-- Icomoon Icon Fonts-->
        <link rel="stylesheet" href="css/icomoon.css">
        <!-- Bootstrap  -->
        <link rel="stylesheet" href="css/bootstrap.css">
        <!-- Flexslider  -->
        <link rel="stylesheet" href="css/flexslider.css">
        <!-- Flaticons  -->
        <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">
        <!-- Owl Carousel -->
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <!-- Theme style  -->
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="booking/booking.css">
        <!-- Modernizr JS -->
        <script src="js/modernizr-2.6.2.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

    </head>

    <script>
        $(document).ready(function () {
            $('.slectOne').on('change', function () {
                $('.slectOne').not(this).prop('checked', false);
                $('#result').html($(this).data("id"));
                if ($(this).is(":checked"))
                    $('#result').html($(this).data("id"));
                else
                    $('#result').html('Empty...!');
            });
        });
    </script>
    <body>
        <div id="colorlib-page">
            <a class="js-colorlib-nav-toggle colorlib-nav-toggle"><i></i></a>
            <aside id="colorlib-aside" role="complementary" class="border js-fullheight">
                <h1 id="colorlib-logo"></h1>
                <nav id="colorlib-main-menu" role="navigation">
                    <ul>
                        <li><a href="User_Home.jsp">Home</a></li>
                        <li><a href="parking_cost1.jsp">Parking Cost</a></li>
                        <li class="colorlib-active"><a href="Book_parking.jsp">Book Parking</a></li>
                        <li><a href="your_bookings.jsp">Your Bookings</a></li>
                        <li><a href="index.html">Logout</a></li>
                    </ul>
                </nav>
            </aside>
            <div id="colorlib-main">
                <div class="colorlib-contact">
                    <div class="colorlib-narrow-content">
                        <div class="row">
                            <div class="col-md-12 animate-box" data-animate-effect="fadeInLeft">
                                <h2 class="colorlib-heading">Online parking Booking System</h2>
                            </div>
                        </div>
                        <div class="row">
                            <center><h2>Book Parking Slot</h2></center>
                            <br><br>
                            <form  action="slot_booking.jsp" method="post">

                                <%
                                    String pdate = request.getParameter("date");
                                    String stime = request.getParameter("stime");
                                    String phrs = request.getParameter("phrs");
                                    System.out.println(phrs);
                                    System.out.println(stime);

                                    int pcost = 0;
                                    int totalcost = 0;

                                    String phrs1 = phrs + ":00";
                                    String stime1 = stime + ":00";
                                    String phrs2 = phrs1 + ":00";

                                    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
                                    timeFormat.setTimeZone(TimeZone.getTimeZone("UTC"));

                                    Date date1 = timeFormat.parse(stime1);
                                    Date date2 = timeFormat.parse(phrs2);

                                    long sum = date1.getTime() + date2.getTime();
                                    String etime = timeFormat.format(new Date(sum));

                                    System.out.println("start time : " + stime1);
                                    System.out.println("parking hrs : " + phrs2);
                                    System.out.println("End time : " + etime);

                                    Connection con = SQLconnection.getconnection();
                                    Statement st2 = con.createStatement();

                                    try {
                                        ResultSet rt = st2.executeQuery("SELECT * FROM parking_cost");
                                        while (rt.next()) {
                                            pcost = rt.getInt("cost");
                                            System.out.println(pcost);
                                        }
                                        int hrs = Integer.parseInt(phrs);
                                        totalcost = pcost * hrs;

                                        System.out.println(totalcost);

                                    } catch (Exception ex) {
                                        ex.printStackTrace();
                                    }
                                %>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-10 col-md-offset-1 col-md-pull-1 animate-box" data-animate-effect="fadeInLeft">
                                            <div class="form-group">
                                                &nbsp;&nbsp;<label>Date :</label>
                                                <input type="date" class="form-control" name="pdate" value="<%=pdate%>" readonly="">
                                            </div>
                                            <div class="form-group">
                                                &nbsp;&nbsp;<label>Start Time :</label>
                                                <input type="text" name="stime" class="form-control" value="<%=stime%>"readonly="">
                                            </div>
                                            <div class="form-group">
                                                &nbsp;&nbsp;<label>Parking Hours :</label>
                                                <input type="text" name="phrs" class="form-control" value="<%=phrs1%>"readonly="">
                                            </div>
                                            <div class="form-group">
                                                &nbsp;&nbsp;<label>Parking cost in Rupees :</label>
                                                <input type="text" name="totalcost" class="form-control" value="<%=totalcost%>"readonly="">
                                            </div>
                                            <div class="form-group">
                                                &nbsp;&nbsp;<label>Payment Mode :</label><br>
                                                &nbsp;&nbsp;Cash&nbsp;&nbsp;<input type="radio" id="cash" value="Cash" checked="" />&nbsp;&nbsp;&nbsp;&nbsp;
                                                UPI&nbsp;&nbsp;<input type="radio" value="UPI" disabled="" />&nbsp;&nbsp;&nbsp;&nbsp;
                                                Credit Card&nbsp;&nbsp;<input type="radio" value="Credit cards" disabled="" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <br><br><br><br><br>
                                    <table id="seatsBlock">
                                        <p id="notification"></p>
                                        <tr>
                                            <td></td>
                                            <td style="color: black;">1</td>
                                            <td style="color: black;">2</td>
                                            <td style="color: black;">3</td>
                                            <td style="color: black;">4</td>
                                            <td style="color: black;">5</td>
                                            <td style="color: black;"></td>
                                            <td style="color: black;">6</td>
                                            <td style="color: black;">7</td>
                                            <td style="color: black;">8</td>
                                            <td style="color: black;">9</td>
                                            <td style="color: black;">10</td>
                                        </tr>

                                        <%
                                            String slot_name;

                                            ArrayList<String> s1 = new ArrayList<>();
                                            Statement st = con.createStatement();
                                            Statement st1 = con.createStatement();
                                            Statement st4 = con.createStatement();
                                            ResultSet rs = null;
                                            ResultSet rs1 = null;
                                            ResultSet rs2 = null;
                                            try {
                                                rs1 = st1.executeQuery("SELECT * FROM slot_booking WHERE pdate ='" + pdate + "' AND  '" + stime + ":00' BETWEEN stime AND endtime ");
                                                while (rs1.next()) {
                                                    s1.add(rs1.getString("slot_name"));
                                                    System.out.println(s1);
                                                }
                                                rs2 = st4.executeQuery("SELECT * FROM slot_booking WHERE pdate ='" + pdate + "' AND  '" + etime + "' BETWEEN stime AND endtime ");
                                                while (rs2.next()) {
                                                    s1.add(rs2.getString("slot_name"));
                                                    System.out.println(s1);
                                                }
                                                rs = st.executeQuery("SELECT * FROM slot_booking WHERE pdate ='" + pdate + "' AND  '" + stime + ":00' AND '"+ etime +"' BETWEEN stime AND endtime ");
                                                if (rs.next() != true) {

                                        %>


                                        <tr>
                                            <td style="color: black;">A</td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 1" data-id="Slot 1"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 2" data-id="Slot 2"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 3" data-id="Slot 3"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 4" data-id="Slot 4"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 5" data-id="Slot 5" />
                                            </td>
                                            <td class="seatGap"></td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 6" value="Slot 1" data-id="Slot 6"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 7" data-id="Slot 7"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 8" data-id="Slot 8"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 9" data-id="Slot 9"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 10" data-id="Slot 10"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="color: black;">B</td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 11" data-id="Slot 11"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 12" data-id="Slot 12"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 13" data-id="Slot 13"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 14" data-id="Slot 14"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 15" data-id="Slot 15"/>
                                            </td>
                                            <td></td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 16" data-id="Slot 16"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 17" data-id="Slot 17"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 18" data-id="Slot 18"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 19" data-id="Slot 19"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 20" data-id="Slot 20"/>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td style="color: black;">C</td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 21" data-id="Slot 21"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 22" data-id="Slot 22"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 23" data-id="Slot 23"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 24" data-id="Slot 24"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 25" data-id="Slot 25"/>
                                            </td>
                                            <td></td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 26" data-id="Slot 26"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 27" data-id="Slot 27"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 28" data-id="Slot 28"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 29" data-id="Slot 29"/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 30" data-id="Slot 30"/>
                                            </td>
                                        </tr>


                                        <%} else {%>


                                        <tr>
                                            <td style="color: black;">A</td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 1" data-id="Slot 1" 
                                                       <% if (s1.contains("Slot 1")) {
                                                               out.print("disabled=\'disabled \'");
                                                           }%> />
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 2" data-id="Slot 2"
                                                       <% if (s1.contains("Slot 2")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 3" data-id="Slot 3"
                                                       <%if (s1.contains("Slot 3")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 4" data-id="Slot 4"
                                                       <% if (s1.contains("Slot 4")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 5" data-id="Slot 5"
                                                       <% if (s1.contains("Slot 5")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%> />
                                            </td>
                                            <td class="seatGap"></td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 6" value="Slot 1" data-id="Slot 6"
                                                       <% if (s1.contains("Slot 6")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 7" data-id="Slot 7"
                                                       <% if (s1.contains("Slot 7")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 8" data-id="Slot 8"
                                                       <% if (s1.contains("Slot 8")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 9" data-id="Slot 9"
                                                       <% if (s1.contains("Slot 9")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 10" data-id="Slot 10"
                                                       <% if (s1.contains("Slot 10")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="color: black;">B</td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 11" data-id="Slot 11"
                                                       <% if (s1.contains("Slot 11")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 12" data-id="Slot 12"
                                                       <% if (s1.contains("Slot 12")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 13" data-id="Slot 13"
                                                       <% if (s1.contains("Slot 13")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 14" data-id="Slot 14"
                                                       <% if (s1.contains("Slot 14")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 15" data-id="Slot 15"
                                                       <% if (s1.contains("Slot 15")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td></td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 16" data-id="Slot 16"
                                                       <% if (s1.contains("Slot 16")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 17" data-id="Slot 17"
                                                       <% if (s1.contains("Slot 17")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 18" data-id="Slot 18"
                                                       <% if (s1.contains("Slot 18")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 19" data-id="Slot 19"
                                                       <% if (s1.contains("Slot 19")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 20" data-id="Slot 20"
                                                       <% if (s1.contains("Slot 20")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td style="color: black;">C</td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 21" data-id="Slot 21"
                                                       <% if (s1.contains("Slot 21")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 22" data-id="Slot 22"
                                                       <% if (s1.contains("Slot 22")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 23" data-id="Slot 23"
                                                       <% if (s1.contains("Slot 23")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 24" data-id="Slot 24"
                                                       <% if (s1.contains("Slot 24")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 25" data-id="Slot 25"
                                                       <% if (s1.contains("Slot 25")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td></td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 26" data-id="Slot 26"
                                                       <% if (s1.contains("Slot 26")) {
                                                               out.print("checked=\'checked\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 27" data-id="Slot 27"
                                                       <% if (s1.contains("Slot 27")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 28" data-id="Slot 28"
                                                       <% if (s1.contains("Slot 28")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 29" data-id="Slot 29"
                                                       <% if (s1.contains("Slot 29")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                            <td>
                                                <input type="checkbox" class="slectOne" name="Slot" value="Slot 30" data-id="Slot 30"
                                                       <% if (s1.contains("Slot 30")) {
                                                               out.print("disabled=\'disabled\'");
                                                           }%>/>
                                            </td>
                                        </tr>

                                        <%
                                                }
                                            } catch (Exception ex) {
                                                ex.printStackTrace();
                                            }
                                        %>
                                    </table>
                                    <span id="result" style="color: black;"></span>
                                    <br><br><br>
                                    <div class="form-group">
                                        <br><br><br>
                                        <button type="submit" class="btn btn-success btn-md">Book</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div> 
                </div>
            </div>
        </div>


        <!-- jQuery -->
        <script src="js/jquery.min.js"></script>
        <!-- jQuery Easing -->
        <script src="js/jquery.easing.1.3.js"></script>
        <!-- Bootstrap -->
        <script src="js/bootstrap.min.js"></script>
        <!-- Waypoints -->
        <script src="js/jquery.waypoints.min.js"></script>
        <!-- Flexslider -->
        <script src="js/jquery.flexslider-min.js"></script>
        <!-- Sticky Kit -->
        <script src="js/sticky-kit.min.js"></script>
        <!-- Owl carousel -->
        <script src="js/owl.carousel.min.js"></script>
        <!-- Counters -->
        <script src="js/jquery.countTo.js"></script>
        <!-- MAIN JS -->
        <script src="js/main.js"></script>
    </body>
</html>

