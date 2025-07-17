<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Revenue Report</title>
</head>
<body>
<%
    String revenueType = request.getParameter("revenueType");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "dave");

        if ("line".equals(revenueType)) {
            ps = con.prepareStatement(
                "SELECT t.TransitLineName, SUM(r.TotalFare) AS TotalRevenue " +
                "FROM Reservation r " +
                "JOIN Schedule s ON r.ScheduleID = s.ScheduleID " +
                "JOIN Train t ON s.TrainID = t.TrainID " +
                "GROUP BY t.TransitLineName " +
                "ORDER BY TotalRevenue DESC"
            );
        } else if ("customer".equals(revenueType)) {
            ps = con.prepareStatement(
                "SELECT CONCAT(l.FirstName, ' ', l.LastName) AS CustomerName, SUM(r.TotalFare) AS TotalRevenue " +
                "FROM Reservation r " +
                "JOIN Login l ON r.Email = l.Email " +
                "GROUP BY CustomerName " +
                "ORDER BY TotalRevenue DESC"
            );
        }

        rs = ps.executeQuery();
%>

    <h2>Revenue Report <%= revenueType.equals("line") ? "by Transit Line" : "by Customer" %></h2>
    <table border="1">
        <tr>
            <th><%= revenueType.equals("line") ? "Transit Line" : "Customer Name" %></th>
            <th>Total Revenue</th>
        </tr>
<%
        while (rs.next()) {
%>
        <tr>
            <td><%= rs.getString(1) %></td>
            <td>$<%= rs.getBigDecimal("TotalRevenue") %></td>
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
