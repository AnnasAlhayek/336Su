
create database 336project;
USE 336project;

CREATE TABLE Login ( 
Email VARCHAR(100) PRIMARY KEY, 
Username VARCHAR(50) UNIQUE, 
Password VARCHAR(100) NOT NULL, 
FirstName VARCHAR(50), 
LastName VARCHAR(50), 
PassengerType ENUM('Adult', 'Child', 'Senior', 'Disabled') DEFAULT 'Adult' ); 

INSERT INTO Login (
    Email, 
    Username, 
    Password, 
    FirstName, 
    LastName, 
    PassengerType
) VALUES (
    'john.doe@example.com',
    'johndoe',
    'password123',     -- In practice, use a hashed password!
    'John',
    'Doe',
    'Adult'
);

-- EMPLOYEE 
CREATE TABLE Employee ( 
SSN CHAR(9) PRIMARY KEY, 
Username VARCHAR(50) UNIQUE NOT NULL, 
Password VARCHAR(100) NOT NULL, 
FirstName VARCHAR(50), 
LastName VARCHAR(50), 
Role ENUM('Admin', 'CustomerRep') NOT NULL 
); 
-- STATION 
CREATE TABLE Station ( 
StationID INT PRIMARY KEY, 
Name VARCHAR(100), 
City VARCHAR(100), 
State CHAR(2) 
); 
-- TRAIN 
CREATE TABLE Train ( 
TrainID INT PRIMARY KEY, 
TransitLineName VARCHAR(100) 
); 
-- SCHEDULE 
CREATE TABLE Schedule ( 
ScheduleID INT PRIMARY KEY, 
TrainID INT NOT NULL, 
OriginStationID INT NOT NULL,
DestinationStationID INT NOT NULL, 
DepartureDateTime DATETIME, 
ArrivalDateTime DATETIME, 
TravelTime INT, -- in minutes 
Fare DECIMAL(6,2), 
FOREIGN KEY (TrainID) REFERENCES Train(TrainID), 
FOREIGN KEY (OriginStationID) REFERENCES Station(StationID), FOREIGN KEY (DestinationStationID) REFERENCES Station(StationID) ); 
-- STOP 
CREATE TABLE Stop ( 
ScheduleID INT, 
StationID INT, 
StopOrder INT, 
ArrivalTime TIME, 
DepartureTime TIME, 
PRIMARY KEY (ScheduleID, StationID), 
FOREIGN KEY (ScheduleID) REFERENCES Schedule(ScheduleID), FOREIGN KEY (StationID) REFERENCES Station(StationID) ); 
-- RESERVATION 
CREATE TABLE Reservation ( 
ReservationNumber INT PRIMARY KEY, 
Email VARCHAR(100) NOT NULL, 
ScheduleID INT NOT NULL, 
ReservationDate DATE, 
TravelDate DATETIME, 
TotalFare DECIMAL(6,2), 
TripType ENUM('OneWay', 'RoundTrip') DEFAULT 'OneWay', FOREIGN KEY (Email) REFERENCES Login(Email), FOREIGN KEY (ScheduleID) REFERENCES Schedule(ScheduleID) ); 
-- QUESTION 
CREATE TABLE Question ( 
QuestionID INT PRIMARY KEY, 
Email VARCHAR(100), 
QuestionText VARCHAR(500), 
AnswerText VARCHAR(500), 
ResponderSSN CHAR(9), 
FOREIGN KEY (Email) REFERENCES Login(Email), FOREIGN KEY (ResponderSSN) REFERENCES Employee(SSN)
); 
-- VIEWS 
-- Monthly Sales Report 
CREATE VIEW MonthlySales AS 
SELECT 
DATE_FORMAT(ReservationDate, '%Y-%m') AS Month, SUM(TotalFare) AS TotalRevenue 
FROM Reservation 
GROUP BY Month; 
-- Top 5 Most Active Transit Lines 
CREATE VIEW TopTransitLines AS 
SELECT 
t.TransitLineName, 
COUNT(r.ReservationNumber) AS TotalReservations FROM Reservation r 
JOIN Schedule s ON r.ScheduleID = s.ScheduleID JOIN Train t ON s.TrainID = t.TrainID 
GROUP BY t.TransitLineName 
ORDER BY TotalReservations DESC 
LIMIT 5; 
-- Customer Revenue 
CREATE VIEW CustomerRevenue AS 
SELECT 
c.Email, 
CONCAT(c.FirstName, ' ', c.LastName) AS FullName, SUM(r.TotalFare) AS Revenue 
FROM Login c 
JOIN Reservation r ON c.Email = r.Email 
GROUP BY c.Email, FullName 
ORDER BY Revenue DESC;

Select * from Reservation;

-- Insert two stations
INSERT INTO Station (StationID, Name, City, State) VALUES 
(1, 'New York', 'New York', 'NY'),
(2, 'Boston', 'Boston', 'MA');

-- Insert one train
INSERT INTO Train (TrainID, TransitLineName) VALUES 
(100, 'Northeast Express');

-- Insert one schedule between those stations
INSERT INTO Schedule (ScheduleID, TrainID, OriginStationID, DestinationStationID, DepartureDateTime, ArrivalDateTime, TravelTime, Fare)
VALUES (
    1001,
    100,
    1,  -- New York
    2,  -- Boston
    '2025-07-20 08:00:00',
    '2025-07-20 11:30:00',
    210,
    49.99
);

select * from Schedule;
select * from Station;
select * from Train;