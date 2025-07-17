<%@ page import="java.sql.*" session="true" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String view = request.getParameter("view");
    if (view == null) {
        view = "current"; // default to current
    }
%>

<h2>View Reservations</h2>

<form method="get" action="viewReservations.jsp" style="display:inline;">
    <input type="hidden" name="view" value="current" />
    <input type="submit" value="Current Reservations" />
</form>

<form method="get" action="viewReservations.jsp" style="display:inline;">
    <input type="hidden" name="view" value="past" />
    <input type="submit" value="Past Reservations" />
</form>

<hr/>
