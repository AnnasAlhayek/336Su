<%@ page import ="java.sql.*" %>
<%
String username = request.getParameter("Username");
String password = request.getParameter("Password");
Class.forName("com.mysql.cj.jdbc.Driver");

Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project","root","dave");
Statement st = con.createStatement();
ResultSet rs;
rs = st.executeQuery("select * from adminlog where Username='" + username + "' and Password='" + password+ "'");
if (rs.next()) {
session.setAttribute("Username", username); // the username will be stored in the session
out.println("welcome " + username);
out.println("<a href='Adminlogout.jsp'>Log out</a>");
response.sendRedirect("AdminSuccess.jsp");
} else {
out.println("Invalid password <a href='AdminLogin.jsp'>try again</a>");
}
%>