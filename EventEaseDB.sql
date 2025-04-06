-- Switch to master database
USE master;

-- Drop database if it exists
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'WebsiteBookingDatabase')
BEGIN
    ALTER DATABASE WebsiteBookingDatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE WebsiteBookingDatabase;
END

-- Create the new database
CREATE DATABASE WebsiteBookingDatabase;

-- Switch to the new database
USE WebsiteBookingDatabase;

-- Venue Table
CREATE TABLE Venue (
    VenueID INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing VenueID
    VenueName VARCHAR(350) NOT NULL,
    Location VARCHAR(350) NOT NULL,
    Capacity INT NOT NULL,
    Image_Url VARCHAR(500)
);

-- Insert example data
INSERT INTO Venue (VenueName, Location, Capacity, Image_Url)
VALUES ('THE DOME', 'JHB', 50000, 'http://example.com/venue-image.jpg');

-- Event Table
CREATE TABLE Event (
    EventID INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing EventID
    EventName VARCHAR(350) NOT NULL,
    EventDate DATE NOT NULL DEFAULT GETDATE(),
    Description VARCHAR(MAX),
    VenueID INT NULL,
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueID)
);

-- Insert example data
INSERT INTO Event (EventName, EventDate,Description,VenueID)
VALUES ('SOWETO DERBY', '2025-08-30','GAME',03);

-- Booking Table
CREATE TABLE Bookings(
    BookingID INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing BookingID
    EventID INT NOT NULL,
    VenueID INT NOT NULL,
    BookingDate DATE NOT NULL DEFAULT GETDATE()
    FOREIGN KEY (EventID) REFERENCES Event(EventId),
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueId),
    CONSTRAINT UQ_Booking UNIQUE (EventId, VenueId)
);

    INSERT INTO Bookings (EventID, VenueID, BookingDate)
    VALUES (2, 1, '2025-05-10');


-- Final Data Check (only select from the three tables)
SELECT * FROM Venue;
SELECT * FROM Event;
SELECT * FROM Booking;