<%@ page import="java.sql.*" %>
<%
out.println("Loaded BrowseQA.jsp<br>");
try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "Thesimpsons1");

    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM Question");

    boolean hasResults = false;
    while(rs.next()) {
        hasResults = true;
        out.println("<p><b>Question:</b> " + rs.getString("QuestionText") + "<br>");
        out.println("<b>Answer:</b> " + (rs.getString("AnswerText") != null ? rs.getString("AnswerText") : "<i>Not answered yet</i>") + "</p><hr>");
    }

    if (!hasResults) {
        out.println("<p>No questions found.</p>");
    }

    con.close();
} catch(Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
