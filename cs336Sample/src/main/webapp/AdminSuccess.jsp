
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Home Page</title>
</head>

<h3>View Monthly Sales Report</h3>
<form action="AdminMonthlySales.jsp" method="get">
    <label for="month">Select Month:</label>
    <select name="month" id="month">
        <option value="2025-07">July 2025</option>
        <option value="2025-06">June 2025</option>
        <option value="2025-05">May 2025</option>
        
    </select>
    <input type="submit" value="View Report">
</form>

<h3>Search Reservations</h3>
<form action="AdminSearchReservations.jsp" method="get">
    <label>
        <input type="radio" name="searchType" value="line" checked>
        By Transit Line
    </label>
    <label>
        <input type="radio" name="searchType" value="customer">
        By Customer Name
    </label><br><br>

    <input type="text" name="query" placeholder="Enter line name or customer name" required>
    <input type="submit" value="Search">
</form>

<h3>View Revenue Report</h3>
<form action="AdminRevenueReport.jsp" method="get">
    <label>
        <input type="radio" name="revenueType" value="line" checked>
        By Transit Line
    </label>
    <label>
        <input type="radio" name="revenueType" value="customer">
        By Customer Name
    </label><br><br>

    <input type="submit" value="View Revenue Report">
</form>

<h3>View Best Customer</h3>
<form action="AdminBestCustomer.jsp">
    <input type="submit" value="View Best Customer">
</form>

<h3>Best 5 Most Active Train Lines</h3>

<form action="AdminTopTransitLines.jsp">
    <input type="submit" value="Top 5 Transit Lines">
</form>
