<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reservation Search Results</title>
</head>
<body>
<%
    String searchType = request.getParameter("searchType");
    String query = request.getParameter("query");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "dave");

        if ("line".equals(searchType)) {
            ps = con.prepareStatement(
                "SELECT r.ReservationNumber, l.FirstName, l.LastName, t.TransitLineName, r.TravelDate, r.TotalFare " +
                "FROM Reservation r " +
                "JOIN Schedule s ON r.ScheduleID = s.ScheduleID " +
                "JOIN Train t ON s.TrainID = t.TrainID " +
                "JOIN Login l ON r.Email = l.Email " +
                "WHERE t.TransitLineName LIKE ?");
            ps.setString(1, "%" + query + "%");
        } else if ("customer".equals(searchType)) {
            ps = con.prepareStatement(
                "SELECT r.ReservationNumber, l.FirstName, l.LastName, t.TransitLineName, r.TravelDate, r.TotalFare " +
                "FROM Reservation r " +
                "JOIN Schedule s ON r.ScheduleID = s.ScheduleID " +
                "JOIN Train t ON s.TrainID = t.TrainID " +
                "JOIN Login l ON r.Email = l.Email " +
                "WHERE CONCAT(l.FirstName, ' ', l.LastName) LIKE ?");
            ps.setString(1, "%" + query + "%");
        }

        rs = ps.executeQuery();
%>
    <h2>Reservation Search Results</h2>
    <table border="1">
        <tr>
            <th>Reservation #</th>
            <th>Customer Name</th>
            <th>Transit Line</th>
            <th>Travel Date</th>
            <th>Total Fare</th>
        </tr>
<%
        while (rs.next()) {
%>
        <tr>
            <td><%= rs.getInt("ReservationNumber") %></td>
            <td><%= rs.getString("FirstName") %> <%= rs.getString("LastName") %></td>
            <td><%= rs.getString("TransitLineName") %></td>
            <td><%= rs.getTimestamp("TravelDate") %></td>
            <td>$<%= rs.getBigDecimal("TotalFare") %></td>
        </tr>
<%
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>
    </table>
    <br><a href="AdminSuccess.jsp">Back to Dashboard</a>
</body>
</html>
