
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head><title>Reservation Menu</title></head>
<body>

<h2>Welcome <%= username %> — Reservation Menu</h2>

<ul>
    <li><a href="makeReservation.jsp">Make a New Reservation</a></li>
    <li><a href="cancelReservation.jsp">Cancel a Reservation</a></li>
    <li><a href="viewReservations.jsp">View Current & Past Reservations</a></li>
</ul>

<br>
<a href="Success.jsp">Return to Dashboard</a>

</body>
</html>
