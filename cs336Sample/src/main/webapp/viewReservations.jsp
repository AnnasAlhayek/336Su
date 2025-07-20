<%@ page import="java.sql.*" session="true" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String view = request.getParameter("view");
    if (view == null) {
        view = "current"; // default view
    }

    // Set up DB connection
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "dave");

    // Determine the WHERE clause
    String whereClause = view.equals("past") ?
        "TravelDate < NOW()" :
        "TravelDate >= NOW()";

    PreparedStatement ps = con.prepareStatement(
        "SELECT r.ReservationNumber, r.ReservationDate, r.TravelDate, r.TotalFare, r.TripType, " +
        "s.Origin, s.Destination, s.DepartureTime, s.TransitLine " +
        "FROM Reservation r " +
        "JOIN Schedule s ON r.ScheduleID = s.ScheduleID " +
        "WHERE r.Email = ? AND " + whereClause +
        " ORDER BY r.TravelDate DESC"
    );
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();
%>

<html>
<head>
    <title>Your Reservations</title>
</head>
<body>

<h2>View Reservations</h2>

<form method="get" action="viewReservations.jsp" style="display:inline;">
    <input type="hidden" name="view" value="current" />
    <input type="submit" value="Current Reservations" />
</form>

<form method="get" action="viewReservations.jsp" style="display:inline;">
    <input type="hidden" name="view" value="past" />
    <input type="submit" value="Past Reservations" />
</form>

<hr/>

<h3><%= view.equals("past") ? "Past" : "Current" %> Reservations</h3>

<table border="1">
    <tr>
        <th>Reservation #</th>
        <th>Reservation Date</th>
        <th>Travel Date</th>
        <th>Fare</th>
        <th>Trip Type</th>
        <th>Origin</th>
        <th>Destination</th>
        <th>Departure Time</th>
        <th>Transit Line</th>
    </tr>

<%
    boolean hasResults = false;
    while (rs.next()) {
        hasResults = true;
%>
    <tr>
        <td><%= rs.getInt("ReservationNumber") %></td>
        <td><%= rs.getDate("ReservationDate") %></td>
        <td><%= rs.getTimestamp("TravelDate") %></td>
        <td>$<%= rs.getBigDecimal("TotalFare") %></td>
        <td><%= rs.getString("TripType") %></td>
        <td><%= rs.getString("Origin") %></td>
        <td><%= rs.getString("Destination") %></td>
        <td><%= rs.getString("DepartureTime") %></td>
        <td><%= rs.getString("TransitLine") %></td>
    </tr>
<%
    }
    if (!hasResults) {
%>
    <tr><td colspan="9">No <%= view %> reservations found.</td></tr>
<%
    }
    rs.close();
    ps.close();
    con.close();
%>
</table>

</body>
</html>
