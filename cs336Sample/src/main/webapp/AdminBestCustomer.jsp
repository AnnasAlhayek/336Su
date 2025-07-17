<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Best Customer</title>
</head>
<body>
	<h2>Best Customer</h2>
<%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "dave");
        stmt = con.createStatement();

        rs = stmt.executeQuery("SELECT * FROM CustomerRevenue ORDER BY Revenue DESC LIMIT 1");

        if (rs.next()) {
%>
            <h2>🏆 Best Customer</h2>
            <p><strong>Name:</strong> <%= rs.getString("FullName") %></p>
            <p><strong>Email:</strong> <%= rs.getString("Email") %></p>
            <p><strong>Total Revenue:</strong> $<%= rs.getBigDecimal("Revenue") %></p>
<%
        } else {
            out.println("<p>No customers found.</p>");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>
    <br><a href="AdminSuccess.jsp">Back to Dashboard</a>
</body>
</html>
