<%@ page import="java.sql.*, java.time.LocalDate" session="true" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int scheduleID = Integer.parseInt(request.getParameter("scheduleID"));
    String tripType = request.getParameter("tripType");
    String travelDate = request.getParameter("travelDate");

    double fare = 0;
    double finalFare = 0;
    String passengerType = "Adult";
    int reservationNum = 1;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "Thesimpsons1");

        // Get fare
        PreparedStatement ps = con.prepareStatement("SELECT Fare FROM Schedule WHERE ScheduleID = ?");
        ps.setInt(1, scheduleID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) fare = rs.getDouble("Fare");

        // Get passenger type
        ps = con.prepareStatement("SELECT PassengerType FROM Login WHERE Email = ?");
        ps.setString(1, email);
        rs = ps.executeQuery();
        if (rs.next()) passengerType = rs.getString("PassengerType");

        // Apply discount
        finalFare = passengerType.matches("Child|Senior|Disabled") ? fare * 0.9 : fare;

        // Generate reservation number
        Statement stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT MAX(ReservationNumber) AS max FROM Reservation");
        if (rs.next()) reservationNum = rs.getInt("max") + 1;

        // Insert reservation
        ps = con.prepareStatement("INSERT INTO Reservation VALUES (?, ?, ?, ?, ?, ?, ?)");
        ps.setInt(1, reservationNum);
        ps.setString(2, email);
        ps.setInt(3, scheduleID);
        ps.setDate(4, Date.valueOf(LocalDate.now()));
        ps.setTimestamp(5, Timestamp.valueOf(travelDate + " 00:00:00"));
        ps.setDouble(6, finalFare);
        ps.setString(7, tripType);
        ps.executeUpdate();

        con.close();
%>
        <h3>Reservation Confirmed!</h3>
        <p>Reservation #: <%= reservationNum %></p>
        <p>Schedule ID: <%= scheduleID %></p>
        <p>Trip Type: <%= tripType %></p>
        <p>Passenger Type: <%= passengerType %></p>
        <p>Total Fare: $<%= String.format("%.2f", finalFare) %></p>
        <a href="reservationMenu.jsp">Return to Reservation Menu</a>
<%
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
