<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Rep Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e6f2ff;
            padding: 30px;
        }
        .dashboard {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #222;
        }
        .dashboard ul {
            list-style: none;
            padding: 0;
        }
        .dashboard li {
            background: #0073e6;
            color: white;
            padding: 12px 20px;
            margin: 10px 0;
            border-radius: 6px;
            font-size: 16px;
        }
        .dashboard li a {
            color: white;
            text-decoration: none;
            display: block;
        }
        .dashboard li:hover {
            background: #005bb5;
        }
    </style>
</head>
<body>
    <div class="dashboard">
        <h1>Welcome, Customer Representative</h1>

        <ul>
            <li><a href="EditDeleteSchedule.jsp">🛠️ Edit/Delete Train Schedules</a></li>
            <li><a href="ReplyQuestions.jsp">💬 Reply to Customer Questions</a></li>
            <li><a href="ScheduleByStation.jsp">🚉 View Train Schedules by Station</a></li>
            <li><a href="ReservationsByTransit.jsp">📋 View Customers by Transit Line and Date</a></li>
        </ul>
    </div>
</body>
</html>
