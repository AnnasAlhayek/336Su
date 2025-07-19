<%@ page import="java.sql.*" %>
<form method="get">
    <label>Station:</label>
    <input type="text" name="station" required>
    <input type="submit" value="Search">
</form>

<%
String station = request.getParameter("station");
if (station != null && !station.trim().equals("")) {
    try {
    	Class.forName("com.mysql.jdbc.Driver");

        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "Thesimpsons1");

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM TrainSchedule WHERE Origin=? OR Destination=?");
        ps.setString(1, station);
        ps.setString(2, station);

        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            out.println("<p>Train: " + rs.getString("TrainNumber") +
                        " | From: " + rs.getString("Origin") +
                        " | To: " + rs.getString("Destination") +
                        " | Departs: " + rs.getString("DepartureTime") + "</p>");
        }

        con.close();
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
}
%>
