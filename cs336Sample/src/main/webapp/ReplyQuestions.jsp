<%@ page import="java.sql.*" %>
<%
String ssn = "111223333"; // You can get this from session if you implement login

if(request.getMethod().equalsIgnoreCase("POST")) {
    int questionID = Integer.parseInt(request.getParameter("questionID"));
    String answerText = request.getParameter("answerText");

    try {
    	Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/YOUR_DB", "USER", "PASS");

        PreparedStatement ps = con.prepareStatement(
            "UPDATE Question SET AnswerText=?, ResponderSSN=? WHERE QuestionID=?");
        ps.setString(1, answerText);
        ps.setString(2, ssn);
        ps.setInt(3, questionID);

        ps.executeUpdate();

        con.close();
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
}
%>

<h3>Unanswered Questions</h3>
<%
try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "Thesimpsons1");

    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM Question WHERE AnswerText IS NULL");

    while(rs.next()) {
        out.println("<form method='post'>");
        out.println("<p><b>From:</b> " + rs.getString("Email") + "</p>");
        out.println("<p><b>Question:</b> " + rs.getString("QuestionText") + "</p>");
        out.println("<textarea name='answerText' rows='3' cols='50'></textarea><br>");
        out.println("<input type='hidden' name='questionID' value='" + rs.getInt("QuestionID") + "'>");
        out.println("<input type='submit' value='Submit Answer'><hr>");
        out.println("</form>");
    }

    con.close();
} catch(Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
