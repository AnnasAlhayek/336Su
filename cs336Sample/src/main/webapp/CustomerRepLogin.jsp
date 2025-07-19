<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Representative Portal</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f6f9fc;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        }
        h1, h2 {
            text-align: center;
            color: #333;
        }
        form {
            margin-bottom: 20px;
        }
        input[type="text"],
        input[type="password"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        input[type="submit"] {
            background-color: #0056b3;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #003d80;
        }
        .note {
            text-align: center;
            font-size: 14px;
            color: #555;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Customer Representative Login</h1>

        <!-- Login Form -->
        <form action="CustomerRepDashboard.jsp" method="post">
            <label>Username:</label>
            <input type="text" name="username" required>

            <label>Password:</label>
            <input type="password" name="password" required>

            <input type="submit" value="Login">
        </form>

        <hr>

        <h2>Customer Support Tools</h2>

        <form action="BrowseQA.jsp" method="get">
            <input type="submit" value="📖 Browse Questions and Answers">
        </form>

        <form action="SearchQuestions.jsp" method="get">
            <input type="text" name="keyword" placeholder="Search questions by keyword" required>
            <input type="submit" value="🔍 Search">
        </form>

        <form action="SendQuestion.jsp" method="post">
            <label>Your Name or Email:</label>
            <input type="text" name="username" required>

            <label>Your Question:</label>
            <textarea name="questionText" rows="4" required placeholder="Type your question here..."></textarea>

            <input type="submit" value="✉️ Send Question">
        </form>

        <p class="note">Still need help? Email us at <strong>customerRep@gmail.com</strong></p>
    </div>
</body>
</html>
