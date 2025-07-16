<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login Form</title>
</head>
<body>
    <form action="checkLoginDetails.jsp" method="POST">
        Username: <input type="text" name="username"/> <br/>
        Password: <input type="password" name="password"/> <br/>
        <input type="submit" value="Submit"/>
        <p>Don't have an account? <a href="Register.jsp">Register here</a></p>
    </form>
</body>
</html>
