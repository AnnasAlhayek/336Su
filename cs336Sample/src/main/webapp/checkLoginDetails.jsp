<%@ page import ="java.sql.*" %>
<%
String username = request.getParameter("username");
String password = request.getParameter("password");
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project","root","Thesimpsons1");
Statement st = con.createStatement();
ResultSet rs;
rs = st.executeQuery("select * from Login where username='" + username + "' and password='" + password+ "'");
if (rs.next()) {
session.setAttribute("username", username); // the username will be stored in the session
session.setAttribute("email", rs.getString("Email"));
out.println("welcome " + username);
out.println("<a href='Logout.jsp'>Log out</a>");
response.sendRedirect("Success.jsp");
} else {
out.println("Invalid password <a href='Login.jsp'>try again</a>");
}
%>
