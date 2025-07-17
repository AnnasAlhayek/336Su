<%@ page import="java.sql.*" session="true" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int resNum = Integer.parseInt(request.getParameter("resNum"));

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "Thesimpsons1");

            PreparedStatement ps = con.prepareStatement("DELETE FROM Reservation WHERE ReservationNumber = ? AND Email = ?");
            ps.setInt(1, resNum);
            ps.setString(2, email);
            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("Reservation #" + resNum + " cancelled successfully.");
            } else {
                out.println("Reservation not found or doesn't belong to you.");
            }

            con.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>

<h2>Cancel a Reservation</h2>
<form method="post">
    Reservation Number: <input type="number" name="resNum" required><br><br>
    <input type="submit" value="Cancel Reservation">
</form>

<a href="reservationMenu.jsp">Back to Reservation Menu</a>
