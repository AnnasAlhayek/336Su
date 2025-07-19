<%@ page import="java.sql.*" %>
<%
String email = request.getParameter("username");
String questionText = request.getParameter("questionText");

try {
	Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "Thesimpsons1");

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO Question (Email, QuestionText) VALUES (?, ?)");
    ps.setString(1, email);
    ps.setString(2, questionText);

    int result = ps.executeUpdate();

    out.println(result > 0 ? "Question submitted!" : "Failed to submit question.");

    con.close();
} catch(Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
