<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Top 5 Transit Lines</title>
</head>
<body>
    <h2>Top 5 Most Active Transit Lines</h2>
    <table border="1">
        <tr>
            <th>Transit Line</th>
            <th>Total Reservations</th>
        </tr>
<%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "dave");
        stmt = con.createStatement();

        rs = stmt.executeQuery("SELECT * FROM TopTransitLines");

        while (rs.next()) {
%>
        <tr>
            <td><%= rs.getString("TransitLineName") %></td>
            <td><%= rs.getInt("TotalReservations") %></td>
        </tr>
<%
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>
    </table>
    <br><a href="AdminSuccess.jsp">Back to Dashboard</a>
</body>
</html>
