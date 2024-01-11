<%-- 
    Document   : User_login
    Created on : 18 Mar, 2021, 11:09:55 AM
    Author     : JAVA-JP
--%>

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
        <!-- Modernizr JS -->
        <script src="js/modernizr-2.6.2.min.js"></script>

        <script src="https://cdn.jsdelivr.net/timepicker.js/latest/timepicker.min.js"></script>
        <link href="https://cdn.jsdelivr.net/timepicker.js/latest/timepicker.min.css" rel="stylesheet"/>  


        <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-timepicker/1.8.9/jquery.timepicker.min.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-timepicker/1.8.9/jquery.timepicker.min.js"></script>

    </head>
    
    <%
        if (request.getParameter("Slot_booked") != null) {
    %>
    <script>alert('Slot Booked');</script>
    <%            }
    %>
    <script>
        $(function () {
            for (var i = 1; i <= 6; i += 1) {
                $('#meeting').append('<option value="0' + i + '">' + i + '   hrs' + '</option>');
            }

            for (var i = 6; i <= 18; i += 1) {
                $('#stime1').append('<option value="' + i + ':00">' + i + '   :00' + '</option>');
            }
            function setEndTime() {
                var meetingLength = parseInt($('#meeting').find('option:selected').val() || 0);
                var selectedTime = $('#stime').timepicker('getTime');
                if (selectedTime == null || selectedTime == "") {
                    alert("Please select the start time.");
                } else {
                    selectedTime.setMinutes(selectedTime.getMinutes() + parseInt(meetingLength, 10), 0);
                    $('#etime').timepicker('setTime', selectedTime);
                }
            }

            $('#stime').timepicker({
                'timeFormat': 'h:i a',
                'minTime': '8:00 AM',
                'maxTime': '5:00 PM',
                'step': 30
            }).on(function () {
                setEndTime();
            });

            $('#etime').timepicker({
                'timeFormat': 'h:i a',
                'minTime': '8:00 AM',
                'maxTime': '5:00 PM',
                'step': 5
            });

            $('#meeting').bind('change', function () {
                setEndTime();
            });
        });



    </script>
    <script>
        function getInputDateFormat(date) {
            return date.toISOString().split('T')[0];
        }

        function validDate() {
            var today = new Date();
            var maxDate = new Date();
            maxDate.setDate(maxDate.getDate() + 365);

            document.getElementsByName("date")[0].setAttribute('min', getInputDateFormat(today));
            document.getElementsByName("date")[0].setAttribute('max', getInputDateFormat(maxDate));
        }
    </script>
    <body onload="validDate()">
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
                            <div class="col-md-1">
                            </div>
                            <div class="col-md-6 col-md-push-2">
                                <div class="row">
                                    <div class="col-md-10 col-md-offset-1 col-md-pull-1 animate-box" data-animate-effect="fadeInLeft">
                                        <form  action="Book_parking1.jsp" method="post">
                                            <div class="form-group">
                                                &nbsp;&nbsp;<label>Select Date :</label>
                                                <input type="date" class="form-control" name="date" id="date" required="required">
                                            </div>
                                            <div class="form-group">
                                                &nbsp;&nbsp;<label>Select Parking Time :</label>
                                                <select name="stime" required="required" class="form-control">
                                                    <option value="">--Select Time--</option>
                                                    <option>06:00</option>
                                                    <option>07:00</option>
                                                    <option>08:00</option>
                                                    <option>09:00</option>
                                                    <option>10:00</option>
                                                    <option>11:00</option>
                                                    <option>12:00</option>
                                                    <option>13:00</option>
                                                    <option>14:00</option>
                                                    <option>15:00</option>
                                                    <option>16:00</option>
                                                    <option>17:00</option>
                                                    <option>18:00</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                &nbsp;&nbsp;<label>Enter Parking Hours :</label>
                                                <select name="phrs" id="meeting" class="form-control" required="required">
                                                    <option value="">--Select Hours--</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <button type="submit" class="btn btn-success btn-md">Select Slot</button>
                                            </div>
                                        </form>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div> 
                </div>
            </div>
        </div>
        <script>
            var timepicker = new TimePicker('time', {
                lang: 'en',
                theme: 'dark'
            });
            timepicker.on('change', function (evt) {

                var value = (evt.hour || '00') + ':' + (evt.minute || '00');
                evt.element.value = value;

            });
        </script>
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

