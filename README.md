README.txt

=======================================
RailwayBookingSystem - CS 336 Summer 2025
=======================================

Project Summary:
--------------------------------------------------------------------
This project implements an online railway booking system that allows:
- Customers to register, login, look at train schedules, and make/cancel reservations (one-way or round-trip, with discounts for children, seniors, and disabled passengers).
- Customer Representatives to edit and delete train schedules and answer customer questions.
- Admins to manage customer representatives and generate reports on sales, reservations, and customers.

Technology stack:
- Backend: MySQL database, JDBC, Java
- Frontend: HTML, JSP
- Server: Apache Tomcat (local deployment)

Database Schema:
--------------------------------------------------------------------
The database schema is provided in `schema.sql`.  

Key tables:
- Customer
- Employee
- Station
- Train
- Schedule
- Stop
- Reservation
- Question

Key Views for admin reports:
- MonthlySales
- Top5TransitLines
- CustomerRevenue

Test Accounts:
--------------------------------------------------------------------
Admin account:
  Username: admin
  Password: secure4

Customer Representative account:
  Username: rep1
  Password: rep123

Test Customer account:
  Username: johndoe
  Password: password123

Test Data:
--------------------------------------------------------------------
Example Train:
  TrainID: 1001
  TransitLineName: Northeast Corridor

Example Stations:
  StationID: 1 - Trenton
  StationID: 2 - Princeton
  StationID: 3 - New Brunswick

Example Schedule:
  ScheduleID: 2001
  TrainID: 1001
  Origin: Trenton (StationID 1)
  Destination: New York Penn (StationID 10)
  Departure: 2025-08-01 07:00:00
  Arrival: 2025-08-01 09:00:00
  TravelTime: 120 minutes
  Fare: $50.00

Additional Notes:
--------------------------------------------------------------------
- Passenger discounts are computed at application level:
  - Child: 25% discount
  - Senior: 35% discount
  - Disabled: 50% discount
- Round-trip tickets double the fare.

Access control summary:
--------------------------------------------------------------------
- Customers can only access their own reservations and ask questions.
- Customer Representatives can manage schedules and answer questions.
- Admins can manage reps and run reports.

Thank you for reviewing our project!

Team:
Annas Alhayek, Shrij Dave, Darsh Patel, Beshoy Yacoub

