<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Manage Customer Representatives</title>
</head>
<body>
<h2>Manage Customer Representatives</h2>
<h3>Enter the SSN of the person you want to manage, then fill out as many of the remaining boxes</h3>

<!-- Form for Add/Edit/Delete -->
<form method="post" action="AdminHandleRep.jsp">
    SSN:        <input type="text" name="SSN" required /><br/>
    Username:   <input type="text" name="Username" /><br/>
    Password:   <input type="password" name="Password" /><br/>
    First Name: <input type="text" name="FirstName" /><br/>
    Last Name:  <input type="text" name="LastName" /><br/>
    <input type="submit" name="action" value="Add"/>
    <input type="submit" name="action" value="Edit"/>
    <input type="submit" name="action" value="Delete"/>
</form>

<hr/>
<h3>Current Customer Reps:</h3>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "dave");

        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM Employee WHERE Role='CustomerRep'");

        out.println("<table border='1'><tr><th>SSN</th><th>Username</th><th>First Name</th><th>Last Name</th></tr>");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getString("SSN") + "</td>");
            out.println("<td>" + rs.getString("Username") + "</td>");
            out.println("<td>" + rs.getString("FirstName") + "</td>");
            out.println("<td>" + rs.getString("LastName") + "</td></tr>");
        }
        out.println("</table>");

        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
</body>
</html>
