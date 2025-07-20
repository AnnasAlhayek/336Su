<%@ page import="java.sql.*" %>
<%	
	String email = request.getParameter("email");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if(username == null || username.trim().isEmpty() ||
       password == null || password.trim().isEmpty()) {
        out.println("Username and Password cannot be empty.");
    } else {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/336project", "root", "dave");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO Login (Email, Username, Password) VALUES (?, ?, ?)");
            ps.setString(1, email);
            ps.setString(2, username);
            ps.setString(3, password);

            int result = ps.executeUpdate(); // returns number of rows affected

            if(result > 0) {
                out.println("Account registered successfully!");
                // Optionally redirect after successful registration
                response.sendRedirect("Login.jsp");
            } else {
                out.println("Registration failed.");
            }

            con.close();
        } catch(Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>
