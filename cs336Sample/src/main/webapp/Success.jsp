<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<%
    String origin = request.getParameter("origin");
    if (origin == null) origin = "";

    String destination = request.getParameter("destination");
    if (destination == null) destination = "";

    String travelDate = request.getParameter("travelDate");
    if (travelDate == null) travelDate = "";

    String sortBy = request.getParameter("sortBy");
    if (sortBy == null || sortBy.isEmpty()) sortBy = "DepartureDateTime";

    if (session.getAttribute("username") == null) {
%>
    You are not logged in<br/>
    <a href="Login.jsp">Please Login</a>
<%
    } else {
%>
<!DOCTYPE html>
<html>
<head>
    <title>Train Schedule Search</title>
</head>
<body>
    Welcome <%=session.getAttribute("username")%> , you are now logged in

    <h3>Search Train Schedules</h3>
    <form method="get" action="Success.jsp">
        <label>Origin:</label>
        <input type="text" name="origin" value="<%= origin %>" /><br><br>

        <label>Destination:</label>
        <input type="text" name="destination" value="<%= destination %>" /><br><br>

        <label>Date of Travel:</label>
        <input type="date" name="travelDate" value="<%= travelDate %>" /><br><br>

        <label>Sort By:</label>
        <select name="sortBy">
            <option value="DepartureDateTime" <%= sortBy.equals("DepartureDateTime") ? "selected" : "" %>>Departure Time</option>
            <option value="ArrivalDateTime" <%= sortBy.equals("ArrivalDateTime") ? "selected" : "" %>>Arrival Time</option>
            <option value="Fare" <%= sortBy.equals("Fare") ? "selected" : "" %>>Fare</option>
        </select><br><br>

        <input type="submit" value="Search" />
    </form>

    <hr/>

    <h3>Search Results:</h3>
    <table border="1">
        <tr>
            <th>Schedule ID</th>
            <th>Train</th>
            <th>Origin</th>
            <th>Destination</th>
            <th>Departure</th>
            <th>Arrival</th>
            <th>Fare</th>
            <th>Travel Time (min)</th>
        </tr>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "Thesimpsons1");

        StringBuilder query = new StringBuilder(
            "SELECT s.*, t.TransitLineName, o.Name AS OriginName, d.Name AS DestinationName " +
            "FROM Schedule s " +
            "JOIN Train t ON s.TrainID = t.TrainID " +
            "JOIN Station o ON s.OriginStationID = o.StationID " +
            "JOIN Station d ON s.DestinationStationID = d.StationID " +
            "WHERE 1=1 "
        );

        if (!origin.isEmpty()) {
            query.append("AND o.Name = ? ");
        }
        if (!destination.isEmpty()) {
            query.append("AND d.Name = ? ");
        }
        if (!travelDate.isEmpty()) {
            query.append("AND DATE(s.DepartureDateTime) = ? ");
        }

        query.append("ORDER BY s.").append(sortBy);

        ps = con.prepareStatement(query.toString());

        int paramIndex = 1;
        if (!origin.isEmpty()) ps.setString(paramIndex++, origin);
        if (!destination.isEmpty()) ps.setString(paramIndex++, destination);
        if (!travelDate.isEmpty()) ps.setString(paramIndex++, travelDate);

        rs = ps.executeQuery();

        boolean found = false;
        while (rs.next()) {
            found = true;
%>
        <tr>
            <td><%= rs.getInt("ScheduleID") %></td>
            <td><%= rs.getString("TransitLineName") %></td>
            <td><%= rs.getString("OriginName") %></td>
            <td><%= rs.getString("DestinationName") %></td>
            <td><%= rs.getTimestamp("DepartureDateTime") %></td>
            <td><%= rs.getTimestamp("ArrivalDateTime") %></td>
            <td>$<%= rs.getBigDecimal("Fare") %></td>
            <td><%= rs.getInt("TravelTime") %></td>
        </tr>
<%
        }

        if (!found) {
%>
        <tr><td colspan="8"><i>No matching schedules found.</i></td></tr>
<%
        }

    } catch (Exception e) {
%>
        <tr><td colspan="8"><b>Error:</b> <%= e.getMessage() %></td></tr>
<%
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
    </table>

    <h3>Reservations</h3>
    <form action="reservationMenu.jsp" method="get">
        <input type="submit" value="Make or Cancel Reservations">
    </form>

    <br>
    <a href="Logout.jsp">Log out</a>
</body>
</html>
<% } %>

    

