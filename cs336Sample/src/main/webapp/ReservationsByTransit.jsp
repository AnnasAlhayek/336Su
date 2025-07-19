<%@ page import="java.sql.*" %>

<form method="get">
    Transit Line: <input type="text" name="line" required><br>
    Travel Date: <input type="date" name="date" required><br>
    <input type="submit" value="Search">
</form>

<%
String line = request.getParameter("line");
String date = request.getParameter("date");

if(line != null && date != null) {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "Thesimpsons1");

        String sql = "SELECT r.Email, r.TravelDate, r.ReservationNumber, s.TransitLine " +
                     "FROM Reservation r JOIN Schedule s ON r.ScheduleID = s.ScheduleID " +
                     "WHERE s.TransitLine = ? AND DATE(r.TravelDate) = ?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, line);
        ps.setString(2, date);

        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            out.println("<p>Customer Email: " + rs.getString("Email") +
                        " | Transit Line: " + rs.getString("TransitLine") +
                        " | Travel Date: " + rs.getString("TravelDate") +
                        " | Reservation #: " + rs.getInt("ReservationNumber") + "</p>");
        }

        con.close();
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
}
%>
