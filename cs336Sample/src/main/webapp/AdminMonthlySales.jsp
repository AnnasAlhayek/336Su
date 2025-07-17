<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Monthly Sales Report</title>
</head>
<body>
    <h2>Monthly Sales Report</h2>

<%
    String selectedMonth = request.getParameter("month");
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "dave");

    // Fetch all available months for dropdown
    Statement monthStmt = con.createStatement();
    ResultSet monthRs = monthStmt.executeQuery("SELECT DISTINCT Month FROM MonthlySales ORDER BY Month DESC");
%>

    <form method="get" action="AdminMonthlySales.jsp">
        <label for="month">Select Month:</label>
        <select name="month" id="month">
            <option value="">-- All Months --</option>
<%
    while (monthRs.next()) {
        String month = monthRs.getString("Month");
        String selectedAttr = (month.equals(selectedMonth)) ? "selected" : "";
%>
            <option value="<%= month %>" <%= selectedAttr %>><%= month %></option>
<%
    }
    monthRs.close();
    monthStmt.close();
%>
        </select>
        <input type="submit" value="View Report">
    </form>

    <br/>

<%
    String query;
    if (selectedMonth != null && !selectedMonth.isEmpty()) {
        query = "SELECT * FROM MonthlySales WHERE Month = ?";
    } else {
        query = "SELECT * FROM MonthlySales";
    }

    PreparedStatement stmt = con.prepareStatement(query);
    if (selectedMonth != null && !selectedMonth.isEmpty()) {
        stmt.setString(1, selectedMonth);
    }

    ResultSet rs = stmt.executeQuery();
%>

    <table border="1">
        <tr>
            <th>Month</th>
            <th>Total Revenue ($)</th>
        </tr>
<%
    while (rs.next()) {
%>
        <tr>
            <td><%= rs.getString("Month") %></td>
            <td><%= rs.getBigDecimal("TotalRevenue") %></td>
        </tr>
<%
    }

    rs.close();
    stmt.close();
    con.close();
%>
    </table>

<br><a href="AdminSuccess.jsp">Back to Dashboard</a>
</body>
</html>
