<%@ page import="java.sql.*" %>
<%
String keyword = request.getParameter("keyword");

try {
	Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "Thesimpsons1");

    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM Questions WHERE QuestionText LIKE ?");
    ps.setString(1, "%" + keyword + "%");

    ResultSet rs = ps.executeQuery();
    while(rs.next()) {
        out.println("<p><b>Question:</b> " + rs.getString("QuestionText") + "<br>");
        out.println("<b>Answer:</b> " + (rs.getString("AnswerText") != null ? rs.getString("AnswerText") : "<i>Not answered yet</i>") + "</p><hr>");
    }

    con.close();
} catch(Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
