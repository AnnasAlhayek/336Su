<%@ page import="java.sql.*, java.util.*" %>
<%
    String ssn = request.getParameter("SSN");
    String username = request.getParameter("Username");
    String password = request.getParameter("Password");
    String firstName = request.getParameter("FirstName");
    String lastName = request.getParameter("LastName");
    String action = request.getParameter("action");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336project", "root", "dave");

        if ("Add".equals(action)) {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO Employee (SSN, Username, Password, FirstName, LastName, Role) VALUES (?, ?, ?, ?, ?, 'CustomerRep')"
            );
            ps.setString(1, ssn);
            ps.setString(2, username);
            ps.setString(3, password);
            ps.setString(4, firstName);
            ps.setString(5, lastName);
            ps.executeUpdate();

        } else if ("Edit".equals(action)) {
            // Build dynamic SQL only for fields that are filled in
            StringBuilder sql = new StringBuilder("UPDATE Employee SET ");
            List<String> updates = new ArrayList<>();
            List<String> values = new ArrayList<>();

            if (username != null && !username.trim().isEmpty()) {
                updates.add("Username = ?");
                values.add(username);
            }
            if (password != null && !password.trim().isEmpty()) {
                updates.add("Password = ?");
                values.add(password);
            }
            if (firstName != null && !firstName.trim().isEmpty()) {
                updates.add("FirstName = ?");
                values.add(firstName);
            }
            if (lastName != null && !lastName.trim().isEmpty()) {
                updates.add("LastName = ?");
                values.add(lastName);
            }

            if (updates.isEmpty()) {
                out.println("Nothing to update. <a href='AdminManageReps.jsp'>Go back</a>");
                return;
            }

            sql.append(String.join(", ", updates));
            sql.append(" WHERE SSN = ? AND Role = 'CustomerRep'");

            PreparedStatement ps = con.prepareStatement(sql.toString());
            int index = 1;
            for (String val : values) {
                ps.setString(index++, val);
            }
            ps.setString(index, ssn); // SSN as final condition
            ps.executeUpdate();

        } else if ("Delete".equals(action)) {
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM Employee WHERE SSN = ? AND Role = 'CustomerRep'"
            );
            ps.setString(1, ssn);
            ps.executeUpdate();
        }

        con.close();
        response.sendRedirect("AdminManageReps.jsp");

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
