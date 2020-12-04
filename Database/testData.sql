SET SEARCH_PATH TO coursework, public;


DELETE FROM SeatBooking;
DELETE FROM FlightBooking;
DELETE FROM Passenger;
DELETE FROM LeadCustomer;
DELETE FROM Flight;

-- Insert LeadCustomer

INSERT INTO LeadCustomer VALUES (1, 'Wilman', 'Kala', '121 Elm Street NP8 7TL', 'Wilman@hotmail.com');
INSERT INTO LeadCustomer VALUES (2, 'John', 'Smith', '36 Spring Road NY7 8PL', 'John@hotmail.com');
INSERT INTO LeadCustomer VALUES (3, 'Sally', 'Talyor', '19 Park Street SE7 3IP', 'Sally@hotmail.com');
INSERT INTO LeadCustomer VALUES (4, 'Moses', 'Rivers', '56 Temple Road SE13 9GY', 'Moses@hotmail.com');
INSERT INTO LeadCustomer VALUES (5, 'Rowena', 'Kaiser', '78 Winter Street NR8 9UY', 'Rowena@hotmail.com');
INSERT INTO LeadCustomer VALUES (6, 'Paige', 'Barclay', '15 Autumn Lane NU7 8NM', 'Paige@hotmail.com');


-- Insert Flight

INSERT INTO Flight VALUES (200, '2020-10-20', 'STN', 'BHD', 10, 85);
INSERT INTO Flight VALUES (201, '2020-09-20', 'BHD', 'STN', 20, 95);
INSERT INTO Flight VALUES (202, '2020-08-20', 'STN', 'BHD', 10, 50);
INSERT INTO Flight VALUES (203, '2020-07-20', 'BHD', 'STN', 50, 80);
INSERT INTO Flight VALUES (204, '2020-06-20', 'STN', 'BHD', 30, 75);
INSERT INTO Flight VALUES (205, '2020-05-20', 'BHD', 'STN', 20, 80);


-- Insert Passenger

INSERT INTO Passenger VALUES (5050, 'Wilman', 'Kala', '20965375', 'British', '1990-01-01');
INSERT INTO Passenger VALUES (6050, 'John', 'Smith', '20947375', 'British', '1993-01-01');
INSERT INTO Passenger VALUES (7050, 'Sally', 'Talyor', '20985475', 'British', '1999-01-01');
INSERT INTO Passenger VALUES (8050, 'Moses', 'Rivers', '20665375', 'British', '1989-01-01');
INSERT INTO Passenger VALUES (9050, 'Rowena', 'Kaiser', '21235375', 'British', '1969-01-01');
INSERT INTO Passenger VALUES (4050, 'Paige', 'Barclay', '20965885', 'British', '1987-01-01');


-- Insert FlightBooking

INSERT INTO FlightBooking VALUES (100, 1, 200, 1, 'R', NOW(), 85);
INSERT INTO FlightBooking VALUES (101, 2, 200, 1, 'R', NOW(), 85);
INSERT INTO FlightBooking VALUES (102, 2, 201, 2, 'R', NOW(), 190);
INSERT INTO FlightBooking VALUES (103, 1, 202, 1, 'R', NOW(), 50);
INSERT INTO FlightBooking VALUES (104, 3, 202, 3, 'R', NOW(), 150);
INSERT INTO FlightBooking VALUES (105, 4, 203, 1, 'R', NOW(), 80);
INSERT INTO FlightBooking VALUES (106, 5, 203, 1, 'R', NOW(), 80);
INSERT INTO FlightBooking VALUES (107, 5, 204, 2, 'R', NOW(), 150);
INSERT INTO FlightBooking VALUES (108, 6, 205, 1, 'R', NOW(), 80);


-- Insert SeatBooking

INSERT INTO SeatBooking VALUES (100, 5050, '1A');
INSERT INTO SeatBooking VALUES (101, 6050, '2A');
INSERT INTO SeatBooking VALUES (102, 7050, '3A');
INSERT INTO SeatBooking VALUES (102, 8050, '3B');
INSERT INTO SeatBooking VALUES (103, 9050, '4A');
INSERT INTO SeatBooking VALUES (104, 4050, '5A');
INSERT INTO SeatBooking VALUES (104, 5050, '5B');
INSERT INTO SeatBooking VALUES (104, 6050, '5C');
INSERT INTO SeatBooking VALUES (105, 8050, '6A');
INSERT INTO SeatBooking VALUES (106, 7050, '7A');
INSERT INTO SeatBooking VALUES (107, 9050, '8A');
INSERT INTO SeatBooking VALUES (107, 4050, '8B');
INSERT INTO SeatBooking VALUES (108, 6050, '9A');




SELECT COUNT(*) FROM LeadCustomer;
-- 6 Rows
SELECT COUNT(*) FROM Flight;
-- 6 Rows
SELECT COUNT(*) FROM Passenger;
-- 6 Rows
SELECT COUNT(*) FROM FlightBooking;
-- 9 Rows
SELECT COUNT(*) FROM SeatBooking;
-- 13 Rows
