<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit/Delete Train Schedules</title>
</head>
<body>
    <h2>Edit or Delete a Train Schedule</h2>

    <!-- Form to delete a schedule -->
    <form method="post">
        <label>Enter Schedule ID to Delete:</label>
        <input type="text" name="deleteID" required>
        <input type="submit" name="deleteBtn" value="Delete Schedule">
    </form>

    <hr>

    <!-- Form to update a schedule -->
    <form method="post">
        <label>Schedule ID to Edit:</label>
        <input type="text" name="editID" required><br>

        <label>New Transit Line:</label>
        <input type="text" name="line"><br>

        <label>New Origin:</label>
        <input type="text" name="origin"><br>

        <label>New Destination:</label>
        <input type="text" name="destination"><br>

        <label>New Departure Time (HH:MM:SS):</label>
        <input type="text" name="time"><br>

        <input type="submit" name="updateBtn" value="Update Schedule">
    </form>

    <hr>

<%
if(request.getMethod().equalsIgnoreCase("POST")) {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/336project", "root", "Thesimpsons1");

    if (request.getParameter("deleteBtn") != null) {
        int deleteID = Integer.parseInt(request.getParameter("deleteID"));
        PreparedStatement ps = con.prepareStatement("DELETE FROM Schedule WHERE ScheduleID = ?");
        ps.setInt(1, deleteID);
        int rows = ps.executeUpdate();
        out.println(rows > 0 ? "<p>Schedule deleted.</p>" : "<p>No schedule found with that ID.</p>");
    }

    if (request.getParameter("updateBtn") != null) {
        int editID = Integer.parseInt(request.getParameter("editID"));
        String line = request.getParameter("line");
        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
        String time = request.getParameter("time");

        PreparedStatement ps = con.prepareStatement(
            "UPDATE Schedule SET TransitLine=?, Origin=?, Destination=?, DepartureTime=? WHERE ScheduleID=?");
        ps.setString(1, line);
        ps.setString(2, origin);
        ps.setString(3, destination);
        ps.setString(4, time);
        ps.setInt(5, editID);

        int rows = ps.executeUpdate();
        out.println(rows > 0 ? "<p>Schedule updated.</p>" : "<p>No schedule found or no changes made.</p>");
    }

    con.close();
}
%>

</body>
</html>
