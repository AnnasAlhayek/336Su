<%@ page session="true" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<html>
<head><title>Make Reservation</title></head>
<body>
    <h2>Make a Reservation</h2>
    <form action="confirmReservation.jsp" method="post">
        Schedule ID: <input type="number" name="scheduleID" required><br><br>
        Trip Type:
        <select name="tripType">
            <option value="OneWay">One Way</option>
            <option value="RoundTrip">Round Trip</option>
        </select><br><br>
        Travel Date: <input type="date" name="travelDate" required><br><br>
        <input type="submit" value="Continue">
    </form>
</body>
</html>
