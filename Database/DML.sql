-- TASK 1B

-- Create a new flight with values: flight ID = 108, origin = 'STN', destination = 'BHD',
-- flight date = '29/7/2020', maximum capacity = 10, and price per seat = 70.

INSERT INTO Flight VALUES (108, '29/7/2020', 'STN', 'BHD', 10, 70);


-- Create a new flight with values: flight ID = 109, origin = 'STN', destination = 'BHD',
-- flight date ='29/7/2019', maximum capacity = 10, and price per seat = 70.

INSERT INTO Flight VALUES (109, '29/7/2019', 'STN', 'BHD', 10, 70);


-- Create a new flight with values: flight ID = 110, origin = 'STN', destination = ‘STN’,
-- flight date = '29/7/2020', maximum capacity = 10, and price per seat = 70.

INSERT INTO Flight VALUES (110, '29/7/2020', 'STN', 'STN', 10, 70);

SELECT * FROM Flight;

-- TASK 1C

-- Create a new passenger with values: PassengerID = 1025, FirstName = 'Ernesto', 
-- Surname = 'Picazo', PassportNo = ' 3434313', Nationality = 'Spanish', DoB='30/7/1987'.

INSERT INTO Passenger VALUES (1025, 'Ernesto', 'Picazo', ' 3434313', 'Spanish', '30/7/1987');


-- Create a new passenger with values: PassengerID = 1026, FirstName = 'Ernesto', 
-- Surname = ‘Smith’, PassportNo = '8383883', Nationality= ‘British’, DoB='30/2/2014'

INSERT INTO Passenger VALUES (1026, 'Ernesto', 'Smith', '8383883', 'British', '30/2/2014');

SELECT * FROM Passenger;


-- TASK 3
-- Check the availability of seats on all flights by showing the flight ID number, 
-- flight date along with the number of booked seats, number of available seats and maximum capacity. 

-- Check availability on ALL flights.

SELECT Flight.FlightID AS "FlightID", Flight.FlightDate AS "Flight Date", 
Flight.MaxCapacity AS "Max Capacity", COALESCE(SUM(FlightBooking.NumSeats),0) AS "Number of Booked Seats", 
Flight.MaxCapacity - COALESCE(SUM(FlightBooking.NumSeats),0) AS "Number of Avaliable Seats" 
FROM Flight LEFT JOIN FlightBooking ON Flight.FlightID = FlightBooking.FlightID 
GROUP BY Flight.FlightID ORDER BY Flight.FlightID ASC;


-- Check availability on a specific flight with flightID = 103.

SELECT Flight.FlightID AS "FlightID", Flight.FlightDate AS "Flight Date", 
Flight.MaxCapacity AS "Max Capacity", COALESCE(SUM(FlightBooking.NumSeats),0) AS "Number of Booked Seats", 
Flight.MaxCapacity - COALESCE(SUM(FlightBooking.NumSeats),0) AS "Number of Avaliable Seats" 
FROM Flight LEFT JOIN FlightBooking ON Flight.FlightID = FlightBooking.FlightID
WHERE Flight.FlightID = 103 GROUP BY Flight.FlightID ORDER BY Flight.FlightID ASC;


-- Check availability on specific flights with destination = ‘BRS’.

SELECT Flight.FlightID AS "FlightID", Flight.FlightDate AS "Flight Date", 
Flight.MaxCapacity AS "Max Capacity", COALESCE(SUM(FlightBooking.NumSeats),0) AS "Number of Booked Seats", 
Flight.MaxCapacity - COALESCE(SUM(FlightBooking.NumSeats),0) AS "Number of Avaliable Seats", 
Flight.Destination AS "Destination"
FROM Flight LEFT JOIN FlightBooking ON Flight.FlightID = FlightBooking.FlightID
WHERE Flight.Destination = 'BRS' GROUP BY Flight.FlightID ORDER BY Flight.FlightID ASC;


-- Check availability on specific flights with date = ‘2020-07-24’

SELECT Flight.FlightID AS "FlightID", Flight.FlightDate AS "Flight Date", 
Flight.MaxCapacity AS "Max Capacity", COALESCE(SUM(FlightBooking.NumSeats),0) AS "Number of Booked Seats", 
Flight.MaxCapacity - COALESCE(SUM(FlightBooking.NumSeats),0) AS "Number of Avaliable Seats" 
FROM Flight LEFT JOIN FlightBooking ON Flight.FlightID = FlightBooking.FlightID
WHERE Flight.FlightDate = '2020-07-24' GROUP BY Flight.FlightID ORDER BY Flight.FlightID ASC;



-- TASK 4

-- Check status of all seats for flightID = 101. 

SELECT Flight.FlightID AS "FlightID", COUNT(DISTINCT FlightBooking) AS "Number of Bookings", 
COALESCE(CASE WHEN FlightBooking.Status = 'R' THEN SUM(FlightBooking.NumSeats) END,0) AS "Seat Reserved", 
COALESCE(CASE WHEN FlightBooking.Status = 'C' THEN SUM(FlightBooking.NumSeats) END,0) AS "Seat Cancelled"
FROM FlightBooking, Flight WHERE FlightBooking.FlightID = 101 AND Flight.FlightID = FlightBooking.FlightID
GROUP BY FlightBooking.Status, Flight.FlightID;



-- TASK 5

-- Produce Ranked list of lead customers by total spend. 

SELECT LeadCustomer.CustomerID AS "CustomerID", FirstName AS "First Name", Surname AS "Surname",
count(FlightBooking.CustomerID) AS "Number Of Bookings", SUM(FlightBooking.TotalCost) AS "Total Cost"
FROM LeadCustomer, FlightBooking WHERE LeadCustomer.CustomerID = FlightBooking.CustomerID AND
FlightBooking.Status != 'C' GROUP BY LeadCustomer.CustomerID ORDER BY SUM(FlightBooking.TotalCost) DESC;



-- TASK 6

-- Check if a customer exists as part of inserting a new flight booking. Check for lead customer 
-- with customerID= 12 or with Surname ‘Sayers’. Show results.   If found, insert flight booking 
-- with details: BookingID = 513, customerID=12, FlightID=103 , NumSeats = 3 , Status = 'R'.  
-- If customer not found, then the process of inserting a flight booking should be cancelled. 
  
BEGIN;

SELECT LeadCustomer.CustomerID AS "CustomerID", LeadCustomer.FirstName AS "First Name",
LeadCustomer.Surname AS "Surname", LeadCustomer.BillingAddress AS "Billing Address", LeadCustomer.email AS "Email"

FROM LeadCustomer WHERE CustomerID = 12 OR Surname = 'Sayers';

ROLLBACK;

INSERT INTO FlightBooking(BookingID, CustomerID, FlightID, NumSeats, Status, BookingTime, TotalCost)
VALUES (513, 12, 103, 3, 'R', current_date, 90);

ROLLBACK;

COMMIT;

END;

SELECT * FROM LeadCustomer;
SELECT * FROM FlightBooking;
 
 
-- Insert a new lead customer as part of inserting a new flight booking. The details of the lead 
-- customer are customerID= 9, FirstName = ‘Dan’ , Surname = ‘Sayers’, Billing Address = '39a Morley Lane, 
-- Southampton', email = 'D.Smith@hotmail.com'.  If the lead customer is inserted correctly, insert flight 
-- booking with details: BookingID = 514, customerID=9 , FlightID=103 , NumSeats = 3 , Status = 'R'.  
-- If there are any problems, then the process of inserting a flight booking should be cancelled. 
 
BEGIN;

INSERT INTO LeadCustomer(CustomerID, FirstName, Surname, BillingAddress, email)
VALUES(9, 'Dan', 'Sayers', '39a Morley Lane, Southampton', 'D.Smith@hotmail.com');

ROLLBACK;

INSERT INTO FlightBooking(BookingID, CustomerID, FlightID, NumSeats, Status, BookingTime, TotalCost)
VALUES (514, 9, 103, 3, 'R', current_date, 90);
 
ROLLBACK;

COMMIT;

END;
 
SELECT * FROM LeadCustomer;
SELECT * FROM FlightBooking; 

 
-- Insert a new lead customer as part of inserting a new flight booking. The details of the lead 
-- customer are customerID= 13, FirstName = ‘Ben’ , Surname = ‘Morgan’, Billing Address = '1 The Street, 
-- Norwich, email = 'b.morgan@hotmail.com'.  If the lead customer is inserted correctly, insert flight 
-- booking with details: BookingID = 515, customerID=13, FlightID=103 , NumSeats = 3 , Status = 'R'. 
-- If there are any problems, then the process of inserting a flight booking should be cancelled. 
 
BEGIN;

INSERT INTO LeadCustomer(CustomerID, FirstName, Surname, BillingAddress, email)
VALUES(13, 'Ben', 'Morgan', '1 The Street, Norwich', 'b.morgan@hotmail.com');

ROLLBACK;

INSERT INTO FlightBooking(BookingID, CustomerID, FlightID, NumSeats, Status, BookingTime, TotalCost)
VALUES (515, 13, 103, 3, 'R', current_date, 90);
 
ROLLBACK;

COMMIT;

END;

SELECT * FROM LeadCustomer;
SELECT * FROM FlightBooking;


 
-- Insert a new lead customer as part of inserting a new flight booking. The details of the lead 
-- customer are customerID= 14, FirstName = ‘Peter’ , Surname = ‘Brown’, Billing Address = '3a Hill Street, 
-- Southampton', email = ‘P.Brown@hotmail.com'.  If the lead customer is inserted correctly, insert flight 
-- booking with details: BookingID = 516, customerID= 14, FlightID=103, NumSeats = 2 , Status = 'R'.  
-- If there are any problems, then the process of inserting a flight booking should be cancelled. 

BEGIN;

INSERT INTO LeadCustomer(CustomerID, FirstName, Surname, BillingAddress, email)
VALUES(14, 'Peter', 'Brown', '3a Hill Street, Southampton', 'P.Brown@hotmail.com');

ROLLBACK;

INSERT INTO FlightBooking(BookingID, CustomerID, FlightID, NumSeats, Status, BookingTime, TotalCost)
VALUES (516, 14, 103, 2, 'R', current_date, 60);
 
ROLLBACK;

COMMIT;

END;

SELECT * FROM LeadCustomer;
SELECT * FROM FlightBooking;



-- TASK 7

-- Allocate seats to passengers  
-- Allocate seat for passenger 1024 in flight booking 510. The seat allocated is ‘8A’. 
 
INSERT INTO SeatBooking VALUES (510, 1024, '8A');

SELECT * FROM SeatBooking;

 
-- Allocate seat for passenger 1025 in flight booking 510. The seat allocated is ‘8B’. 

INSERT INTO SeatBooking VALUES (510, 1025, '8B');

SELECT * FROM SeatBooking;


-- TASK 8

-- Given bookingID cancel booking for BookingID = 509.   
-- Select from flight booking table to show it has been cancelled.  

UPDATE FlightBooking SET Status = 'C' WHERE BookingID = 509;
 
SELECT * FROM FlightBooking WHERE BookingID = 509;

SELECT * FROM FlightBooking;
 
 
-- Rerun task 4 (status of flights) for FlightID = 104 as that has been affected. 

SELECT Flight.FlightID AS "FlightID", COUNT(DISTINCT FlightBooking) AS "Number of Bookings", 
COALESCE(CASE WHEN FlightBooking.Status = 'R' THEN SUM(FlightBooking.NumSeats) END,0) AS "Seat Reserved", 
COALESCE(CASE WHEN FlightBooking.Status = 'C' THEN SUM(FlightBooking.NumSeats) END,0) AS "Seat Cancelled"
FROM FlightBooking, Flight WHERE FlightBooking.FlightID = 104 AND Flight.FlightID = FlightBooking.FlightID
GROUP BY FlightBooking.Status, Flight.FlightID;


-- Rerun task 5 (ranked list of lead customers) to see what has changed.  

SELECT LeadCustomer.CustomerID AS "CustomerID", FirstName AS "First Name", Surname AS "Surname",
count(FlightBooking.CustomerID) AS "Number Of Bookings", SUM(FlightBooking.TotalCost) AS "Total Cost"
FROM LeadCustomer, FlightBooking WHERE LeadCustomer.CustomerID = FlightBooking.CustomerID AND
FlightBooking.Status != 'C' GROUP BY LeadCustomer.CustomerID ORDER BY SUM(FlightBooking.TotalCost) DESC;



-- TASK 2

-- Delete lead customer with CustomerID = 3.

DELETE FROM LeadCustomer WHERE CustomerID = 3;


-- Run task 8 (cancel a booking) for bookingID 504. 

UPDATE FlightBooking SET Status = 'C' WHERE BookingID = 504;
 
SELECT * FROM FlightBooking WHERE BookingID = 504;

SELECT * FROM FlightBooking;


-- Delete lead customer with CustomerID=3. 

DELETE FROM LeadCustomer WHERE CustomerID = 3;

SELECT * FROM LeadCustomer;

SELECT * FROM FlightBooking;




