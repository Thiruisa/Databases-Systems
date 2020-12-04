CREATE SCHEMA IF NOT EXISTS DatabaseCoursework;
SET SEARCH_PATH TO DatabaseCoursework, public;

CREATE TABLE IF NOT EXISTS LeadCustomer
    (CustomerID     INTEGER NOT NULL UNIQUE PRIMARY KEY,
     FirstName      VARCHAR(20) NOT NULL,
     Surname        VARCHAR(40) NOT NULL,
     BillingAddress VARCHAR(200) NOT NULL,
     email          VARCHAR(30) NOT NULL
    );

CREATE TABLE IF NOT EXISTS Passenger
    (PassengerID  INTEGER NOT NULL UNIQUE PRIMARY KEY,
     FirstName    VARCHAR(20) NOT NULL,
     Surname      VARCHAR(40) NOT NULL,
     PassportNo   VARCHAR(30) NOT NULL,
     Nationality  VARCHAR(30) NOT NULL,
	 Dob          DATE NOT NULL, CONSTRAINT Dob_CHK CHECK(Dob < current_date)
    );
	
CREATE TABLE IF NOT EXISTS Flight
    (FlightID      INTEGER NOT NULL UNIQUE PRIMARY KEY,
     FlightDate    TIMESTAMP NOT NULL, CONSTRAINT FlightDate_CHK CHECK(FlightDate >= current_date),
     Origin        VARCHAR(30) NOT NULL,
     Destination   VARCHAR(30) NOT NULL, CONSTRAINT Destination_CHK CHECK(Destination != Origin),
     MaxCapacity   INTEGER NOT NULL, CONSTRAINT MaxCapacity_CHK CHECK(MaxCapacity > 0),
	 PricePerSeat  DECIMAL NOT NULL, CONSTRAINT PricePerSeat_CHK CHECK(PricePerSeat > 0)
    );
	
CREATE TABLE IF NOT EXISTS FlightBooking 
	(BookingID   INTEGER NOT NULL UNIQUE PRIMARY KEY,
	 CustomerID  INTEGER REFERENCES LeadCustomer(CustomerID) on DELETE RESTRICT on UPDATE CASCADE NOT NULL,
	 FlightID    INTEGER REFERENCES Flight(FlightID) on DELETE CASCADE on UPDATE CASCADE NOT NULL,
	 NumSeats    INTEGER NOT NULL, CONSTRAINT Numseat_CHK CHECK(NumSeats > 0),
	 Status      CHAR(1) NOT NULL, CONSTRAINT Status_CHK CHECK(Status like 'R%' OR Status like 'C%'),
	 BookingTime TIMESTAMP NOT NULL, CONSTRAINT BookingTime_CHK CHECK(BookingTime >= current_date),
	 TotalCost   DECIMAL NOT NULL, CONSTRAINT TotalCost_CHK CHECK(TotalCost > 0)
	);
	
CREATE TABLE IF NOT EXISTS SeatBooking
	(BookingID   INTEGER NOT NULL REFERENCES FlightBooking(BookingID) on DELETE CASCADE on UPDATE CASCADE NOT NULL,
	 PassengerID INTEGER NOT NULL REFERENCES Passenger(PassengerID) on DELETE RESTRICT on UPDATE CASCADE NOT NULL,
	 SeatNumber  CHAR(4) NOT NULL, PRIMARY KEY(BookingID, PassengerID, SeatNumber)
	);
	
DROP TABLE IF EXISTS LeadCustomer CASCADE;
DROP TABLE IF EXISTS Passenger CASCADE;
DROP TABLE IF EXISTS Flight CASCADE;
DROP TABLE IF EXISTS FlightBooking CASCADE;
DROP TABLE IF EXISTS SeatBooking CASCADE;