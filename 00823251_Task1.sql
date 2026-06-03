

CREATE DATABASE TicketsPort;
GO

USE TicketsPort;
GO

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1), -- Unique system ID for employee, auto-generated.
    Title NVARCHAR(10),                                                -- Courtesy title (e.g., Mr., Mrs.).
    FirstName NVARCHAR(50) NOT NULL,                 -- Employee's first name; NOT NULL mandatory.
    LastName NVARCHAR(50) NOT NULL,                 -- Employee's last name; NOT NULL mandatory.
    Email NVARCHAR(100) UNIQUE NOT NULL,     -- Unique email address; NVARCHAR for flexibility, UNIQUE prevents duplicates.
    Username NVARCHAR(50) UNIQUE NOT NULL, -- Unique login name; UNIQUE constraint crucial for authentication.
    PasswordHash NVARCHAR(255) NOT NULL,        -- Stores SECURE HASH of password (NOT plain text); NVARCHAR fits hash outputs.
    Role NVARCHAR(30) CHECK (Role IN ('Ticketing Staff', 'Ticketing Supervisor')) NOT NULL, 
	-- Employee role; CHECK constraint limits to 'Ticketing Staff'/'Ticketing Supervisor'.
    CONSTRAINT UQ_Employees_Username UNIQUE (Username) -- Redundant if UNIQUE keyword used above.
);


INSERT INTO Employees (Title, FirstName, LastName, Email, Username, PasswordHash, Role)
VALUES
('Mr.', 'James', 'Anderson', 'james.anderson@salfordair.com', 'james.a', 'pass123', 'Ticketing Staff'),
('Mrs.', 'Olivia', 'Miller', 'olivia.miller@salfordair.com', 'olivia.m', 'pass456', 'Ticketing Staff'),
('Mr.', 'William', 'Davis', 'william.davis@salfordair.com', 'william.d', 'pass789', 'Ticketing Supervisor'),
('Ms.', 'Sophia', 'Wilson', 'sophia.wilson@salfordair.com', 'sophia.w', 'passabc', 'Ticketing Staff'),
('Mr.', 'Robert', 'Taylor', 'robert.taylor@salfordair.com', 'robert.t', 'passdef', 'Ticketing Staff'),
('Mrs.', 'Emma', 'Johnson', 'emma.johnson@salfordair.com', 'emma.j', 'passghi', 'Ticketing Supervisor'),
('Mr.', 'Liam', 'Scott', 'liam.scott@salfordair.com', 'liam.s', 'passxyz', 'Ticketing Staff');



SELECT * FROM Employees


CREATE TABLE Passengers (
    PassengerID INT PRIMARY KEY IDENTITY(1,1), -- Unique system ID for passenger.
    PNR NVARCHAR(10) UNIQUE NOT NULL,         -- Passenger Name Record; UNIQUE booking identifier.
    Title NVARCHAR(5) CHECK (Title IN ('Mr.', 'Mrs.', 'Ms.')) NOT NULL, -- Courtesy title; CHECK limits valid options.
    FirstName NVARCHAR(50) NOT NULL,    -- Passenger first name.
    LastName NVARCHAR(50) NOT NULL,     -- Passenger last name.
    Email NVARCHAR(100) UNIQUE NOT NULL, -- Unique passenger email.
    DoB DATE NOT NULL,                                 -- Date of Birth; DATE type appropriate for day/month/year only.
    Meal NVARCHAR(20) CHECK (Meal IN ('Vegetarian', 'Non-Vegetarian')) NOT NULL, -- Meal preference; CHECK limits to 'Vegetarian'/'Non-Vegetarian'.
    EmergencyContact NVARCHAR(15) NULL -- Optional emergency contact number; NULL allows empty values.
);


INSERT INTO Passengers (PNR, Title, FirstName, LastName, Email, DoB, Meal, EmergencyContact)
VALUES 
('SAL123', 'Mr.', 'John', 'Smith', 'john.smith@gmail.com', '1985-06-15', 'Vegetarian', '447911223344'),
('SAL456', 'Mrs.', 'Emily', 'Brown', 'emily.brown@yahoo.com', '1990-08-22', 'Non-Vegetarian', NULL),
('SAL789', 'Mr.', 'Michael', 'Johnson', 'michael.johnson@mail.com', '1978-02-12', 'Vegetarian', '447922334455'),
('SAL321', 'Ms.', 'Sarah', 'Williams', 'sarah.williams@gmail.com', '1989-09-30', 'Non-Vegetarian', NULL),
('SAL654', 'Mr.', 'Robert', 'Davis', 'robert.davis@yahoo.com', '1983-12-05', 'Vegetarian', '447933445566'),
('SAL987', 'Mrs.', 'Olivia', 'Miller', 'olivia.miller@mail.com', '1995-07-18', 'Non-Vegetarian', NULL),
('SAL741', 'Mr.', 'David', 'Wilson', 'david.wilson@gmail.com', '1981-04-22', 'Vegetarian', '447955667788'),
('SAL852', 'Ms.', 'Luna', 'Gray', 'luna.gray@salfordair.com', '1992-03-19', 'Vegetarian', '447900112233');


SELECT * FROM Passengers

CREATE TABLE Flights (
    FlightID INT PRIMARY KEY IDENTITY(1,1), -- Unique system ID for flight.
    FlightNumber NVARCHAR(10) UNIQUE NOT NULL,     -- Unique airline flight identifier.
    [From] NVARCHAR(50) NOT NULL,               -- Origin location (using brackets as 'From' is keyword).
    [To] NVARCHAR(50) NOT NULL,                    -- Destination location (using brackets as 'To' is keyword).
    DepartureTime DATETIME2(0) NOT NULL,    -- Precise departure date/time (second precision); DATETIME2 recommended.
    ArrivalTime DATETIME2(0) NOT NULL,         -- Precise arrival date/time (second precision).
    AircraftType NVARCHAR(30) NOT NULL        -- Type of aircraft operating the flight.

    CONSTRAINT UQ_Flights_FlightNumber UNIQUE (FlightNumber)  -- Redundant if UNIQUE keyword used above.
);


INSERT INTO Flights ([FlightNumber], [From], [To], DepartureTime, ArrivalTime, AircraftType)
VALUES
('SA101', 'Manchester', 'Dubai', '2025-04-15 08:00:00', '2025-04-15 16:00:00', 'Boeing 777'),
('SA202', 'London', 'NewYork', '2025-05-20 12:30:00', '2025-05-20 18:00:00', 'Airbus A380'),
('SA303', 'Paris', 'Tokyo', '2025-06-10 22:00:00', '2025-06-11 14:00:00', 'Boeing 787'),
('SA404', 'Frankfurt', 'LA', '2025-07-01 09:00:00', '2025-07-01 18:30:00', 'Boeing 747'),
('SA505', 'Manchester', 'Shiraz', '2025-10-10 07:30:00', '2025-10-10 15:00:00', 'Airbus A330'),
('SA606', 'London', 'Toronto', '2025-09-05 14:45:00', '2025-09-05 20:10:00', 'Boeing 767'),
('SA707', 'Birmingham', 'Istanbul', '2025-08-18 10:20:00', '2025-08-18 15:40:00', 'Boeing 737'),
('SA808', 'Edinburgh', 'Doha', '2025-11-25 06:50:00', '2025-11-25 14:15:00', 'Airbus A350');

SELECT * FROM Flights


CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY IDENTITY(1,1), -- Unique ID for the reservation transaction.
    PassengerID INT NOT NULL,                     -- Links to Passengers table (FK).
    FlightID INT NOT NULL,                           -- Links to Flights table (FK).
    ReservationDate DATETIME2(0) NOT NULL,       -- Timestamp when reservation was made; Validated by trigger.
    Status NVARCHAR(20) NOT NULL CHECK (Status IN ('Pending', 'Confirmed', 'Cancelled')), -- Booking status; CHECK limits valid values.
    
	CONSTRAINT FK_Reservations_Passenger FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
    CONSTRAINT FK_Reservations_Flight FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);



INSERT INTO Reservations (PassengerID, FlightID, ReservationDate, Status)
VALUES 
(1, 1, '2025-03-25 10:30', 'Confirmed'),
(2, 2, '2025-04-01 14:45', 'Pending'),
(3, 3, '2025-04-10 16:00', 'Cancelled'),
(4, 4, '2025-05-05 09:20', 'Confirmed'),
(5, 1, '2025-04-02 11:00', 'Confirmed'),
(6, 2, '2025-04-10 13:30', 'Pending'),
(7, 3, '2025-05-01 08:45', 'Confirmed'),
(1, 5, '2025-10-10 07:30', 'Confirmed');



SELECT * FROM Reservations


CREATE TABLE Tickets (
    TicketID INT PRIMARY KEY IDENTITY(1,1),      -- Unique ID for the issued ticket.
    ReservationID INT NOT NULL,                    -- Links to Reservations (FK); ON DELETE CASCADE implies dependency.
    FlightID INT NOT NULL,                       -- Direct link to Flights (FK).
    IssueDate DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE), -- Date ticket was issued. <<< DEFAULT ADDED
    IssueTime TIME NOT NULL DEFAULT CAST(GETDATE() AS TIME), -- Time ticket was issued. <<< DEFAULT ADDED
    Fare DECIMAL(10,2) NOT NULL,                 -- Base ticket price; DECIMAL for financial accuracy (10 digits total, 2 decimal).
    SeatNumber NVARCHAR(5) NULL,                 -- Assigned seat number; Allows NULL if unassigned.
    Class NVARCHAR(20) CHECK (Class IN ('Business', 'Economy', 'FirstClass')) NOT NULL, -- Travel class; CHECK limits valid options.
    EmployeeID INT NOT NULL,                     -- Links to issuing Employee (FK).
--  SeatStatus NVARCHAR(20) DEFAULT 'Available', -- NOTE: SeatStatus is NOT included here, assuming it's added later via ALTER as per iterative approach.
    CONSTRAINT FK_Tickets_Reservation FOREIGN KEY (ReservationID) REFERENCES Reservations(ReservationID) ON DELETE CASCADE,
    CONSTRAINT FK_Tickets_Flight FOREIGN KEY (FlightID) REFERENCES Flights(FlightID),
    CONSTRAINT FK_Tickets_Employee FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    CONSTRAINT UQ_Tickets_Reservation_Seat UNIQUE (ReservationID, SeatNumber, Class),      -- Unique seat per reservation.
    CONSTRAINT UQ_Tickets_Flight_Seat UNIQUE (FlightID, SeatNumber)      -- Unique seat per flight overall.
);




INSERT INTO Tickets (ReservationID, FlightID, IssueDate, IssueTime, Fare, SeatNumber, Class, EmployeeID)
VALUES
(1, 1, '2025-04-01', '10:30', 500.00, '2A', 'Business', 1),   -- Reservation 1, Flight 1
(2, 2, '2025-04-02', '11:00', 350.00, '4B', 'Economy', 2),    -- Reservation 2, Flight 2
(3, 3, '2025-04-03', '12:15', 700.00, '6C', 'FirstClass', 3), -- Reservation 3, Flight 3
(4, 4, '2025-04-04', '13:45', 400.00, '3D', 'Economy', 4),    -- Reservation 4, Flight 4
(5, 1, '2025-04-05', '14:30', 550.00, NULL , 'Business', 5),  -- Reservation 5, Flight 1 (Seat = NULL)
(6, 2, '2025-04-06', '15:00', 300.00, '7E', 'Economy', 6),    -- Reservation 6, Flight 2
(7, 3, '2025-04-07', '16:20', 650.00, '1F', 'Business', 1);   -- Reservation 7, Flight 3


INSERT INTO Tickets (ReservationID, FlightID, Fare, SeatNumber, Class, EmployeeID)
VALUES
(8, 5, 750.00, '9A', 'Business', 2); -- Reservation 8, Flight 5


SELECT * FROM Tickets;


CREATE TABLE Baggage (
    BaggageID INT PRIMARY KEY IDENTITY(1,1),    -- Unique ID per baggage item/record.
    TicketID INT NOT NULL,                   -- Links to Tickets table (FK).
    FlightID INT NOT NULL,                  -- Links to Flights table (FK).
    WeightKG DECIMAL(5,2) NOT NULL,    -- Baggage weight in kg; DECIMAL for precision (up to 999.99).
    Status NVARCHAR(20) CHECK (Status IN ('CheckedIn', 'Loaded')) NOT NULL,    -- Baggage handling status; CHECK limits valid values.
    BaggageFee AS (
        CASE 
            WHEN WeightKG > 20 THEN (WeightKG - 20) * 100 
            ELSE 0 
        END
    ) PERSISTED,     -- Computed column for excess baggage fee (£100/kg over 20kg); PERSISTED stores value.
    FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);




INSERT INTO Baggage (TicketID, FlightID, WeightKG, Status)
VALUES
(1, 1, 18.5, 'CheckedIn'),
(2, 2, 25.0, 'Loaded'),
(3, 3, 22.3, 'CheckedIn'),
(4, 4, 15.0, 'CheckedIn'),
(5, 5, 30.0, 'Loaded'),
(6, 1, 12.0, 'CheckedIn'),
(7, 2, 22.0, 'Loaded'),
(8, 5, 28.5, 'CheckedIn');


SELECT * FROM Baggage

CREATE TABLE AdditionalServices (
    ServiceID INT PRIMARY KEY IDENTITY(1,1),   -- Unique ID for service bundle per ticket.
    TicketID INT NOT NULL,                                 -- Links to Tickets (FK); ON DELETE CASCADE implies dependency.
    ExtraBaggageKG DECIMAL(5,2) NOT NULL DEFAULT 0,  -- Purchased extra baggage allowance/weight (kg); distinct from actual weight.
    UpgradedMeal BIT NOT NULL DEFAULT 0,  -- Flag (1=Yes, 0=No) for meal upgrade purchase (£20); BIT is efficient.
    PreferredSeat BIT NOT NULL DEFAULT 0,    -- Flag (1=Yes, 0=No) for preferred seat purchase (£30).
    TotalServiceFee AS (
        (ExtraBaggageKG * 100) + 
        (CASE WHEN UpgradedMeal = 1 THEN 20 ELSE 0 END) + 
        (CASE WHEN PreferredSeat = 1 THEN 30 ELSE 0 END)
    ) PERSISTED,                                                     -- Computed column for total ancillary fee; PERSISTED stores value.
    FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID) ON DELETE CASCADE
);


INSERT INTO AdditionalServices (TicketID, ExtraBaggageKG, UpgradedMeal, PreferredSeat)
VALUES 
(1, 5.0, 1, 1),   -- Total = 500 + 20 + 30 = 550
(2, 0.0, 0, 0),   -- Total = 0
(3, 2.5, 1, 0),   -- Total = 250 + 20 = 270
(4, 0.0, 0, 1),   -- Total = 30
(5, 10.0, 1, 1),  -- Total = 1000 + 20 + 30 = 1050
(6, 3.0, 0, 0),   -- Total = 300
(7, 0.0, 1, 1),   -- Total = 50
(8, 1.5, 0, 0);   -- Total = 150



SELECT * FROM AdditionalServices


-- adding PNR to be able look up passenger from reservation table.

ALTER TABLE Reservations
ADD PNR NVARCHAR(10);

UPDATE Reservations
SET PNR = P.PNR
FROM Reservations R
JOIN Passengers P ON R.PassengerID = P.PassengerID;



ALTER TABLE Tickets
ADD SeatStatus NVARCHAR(20) DEFAULT 'Available';




--َAvoid booking in past dates by passengers.
CREATE TRIGGER trg_CheckReservationDate
ON Reservations
INSTEAD OF INSERT
AS
BEGIN
 -- Check if inserted reservation date is in the past
    IF EXISTS (
        SELECT 1 
        FROM inserted 
        WHERE ReservationDate < CAST(GETDATE() AS DATE)
    )
    BEGIN
        RAISERROR ('Reservation date cannot be in the past.', 16, 1);
        ROLLBACK;
    END
    ELSE
   -- Allow valid insert
    BEGIN
        INSERT INTO Reservations (PassengerID, FlightID, ReservationDate, Status)
        SELECT PassengerID, FlightID, ReservationDate, Status
        FROM inserted;
    END
END;


--Test 1, Valid date
INSERT INTO Reservations (PassengerID, FlightID, ReservationDate, Status)
VALUES (3, 2, CAST(GETDATE() AS DATETIME2), 'Confirmed');

--Test 2, Past date
INSERT INTO Reservations (PassengerID, FlightID, ReservationDate, Status)
VALUES (4, 1, '2022-01-01', 'Pending');


SELECT 
    P.PassengerID,
    P.Title + ' ' + P.FirstName + ' ' + P.LastName AS FullName,
    R.ReservationID,
    R.ReservationDate,
    R.Status
FROM Passengers P
JOIN Reservations R ON P.PassengerID = R.PassengerID
WHERE R.Status = 'Pending';


SELECT 
    PassengerID,
    Title + ' ' + FirstName + ' ' + LastName AS FullName,
    DoB,
    DATEDIFF(YEAR, DoB, GETDATE()) AS Age
FROM Passengers
WHERE DATEDIFF(YEAR, DoB, GETDATE()) > 40;



CREATE PROCEDURE sp_SearchPassengerByLastName
    @LastNamePart NVARCHAR(50)
AS
BEGIN
    SELECT 
        P.PassengerID,
        P.Title + ' ' + P.FirstName + ' ' + P.LastName AS FullName,
        P.Email,
        T.TicketID,
        T.IssueDate,
        T.IssueTime,
        T.Fare,
        T.Class
    FROM Passengers P
    INNER JOIN Reservations R ON P.PassengerID = R.PassengerID
    INNER JOIN Tickets T ON R.ReservationID = T.ReservationID
    WHERE P.LastName LIKE '%' + @LastNamePart + '%'
    ORDER BY T.IssueDate DESC, T.IssueTime DESC;
END;


EXEC sp_SearchPassengerByLastName @LastNamePart = 'Smith';




CREATE PROCEDURE sp_TodayBusinessPassengers
AS
BEGIN
    SELECT 
        P.PassengerID,
        P.Title + ' ' + P.FirstName + ' ' + P.LastName AS FullName,
        P.Meal,
        T.Class,
        T.IssueDate
    FROM Passengers P
    INNER JOIN Reservations R ON P.PassengerID = R.PassengerID
    INNER JOIN Tickets T ON R.ReservationID = T.ReservationID
    WHERE 
        CAST(T.IssueDate AS DATE) = CAST(GETDATE() AS DATE)
        AND T.Class = 'Business';
END;



EXEC sp_TodayBusinessPassengers;



CREATE PROCEDURE sp_InsertEmployee
    @Title NVARCHAR(5),
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(100),
    @Username NVARCHAR(50),
    @PasswordHash NVARCHAR(255),
    @Role NVARCHAR(30)
AS
BEGIN
   -- Check if Email or Username is not existed.
    IF EXISTS (SELECT 1 FROM Employees WHERE Email = @Email OR Username = @Username)
    BEGIN
        RAISERROR('Email or Username already exists.', 16, 1);
        RETURN;
    END;
	 -- Add new employee
    INSERT INTO Employees (Title, FirstName, LastName, Email, Username, PasswordHash, Role)
    VALUES (@Title, @FirstName, @LastName, @Email, @Username, @PasswordHash, @Role);
END;


-- Test Insert Employee 1
EXEC sp_InsertEmployee
    @Title = 'Mr.',
    @FirstName = 'Liam',
    @LastName = 'Walker',
    @Email = 'liam.walker@salfordair.com',
    @Username = 'liam.w',
    @PasswordHash = 'passliam',
    @Role = 'Ticketing Staff';

-- Test Insert Employee 2
EXEC sp_InsertEmployee
    @Title = 'Ms.',
    @FirstName = 'Ella',
    @LastName = 'Moore',
    @Email = 'ella.moore@salfordair.com',
    @Username = 'ella.m',
    @PasswordHash = 'passemoore',
    @Role = 'Ticketing Supervisor';




CREATE PROCEDURE sp_UpdatePassengerDetails
    @PassengerID INT,
    @Title NVARCHAR(5),
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(100),
    @DoB DATE,
    @Meal NVARCHAR(20)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Passengers WHERE PassengerID = @PassengerID)
    BEGIN
        RAISERROR('Passenger not found.', 16, 1);
        RETURN;
    END;
    UPDATE Passengers
    SET 
        Title = @Title,
        FirstName = @FirstName,
        LastName = @LastName,
        Email = @Email,
        DoB = @DoB,
        Meal = @Meal
    WHERE PassengerID = @PassengerID;
END;



-- Test Update Passenger 1
EXEC sp_UpdatePassengerDetails
    @PassengerID = 1,
    @Title = 'Mr.',
    @FirstName = 'Jonathan',
    @LastName = 'Smith',
    @Email = 'jonathan.smith@salfordair.com',
    @DoB = '1985-06-15',
    @Meal = 'Vegetarian';

-- Test Update Passenger 2
EXEC sp_UpdatePassengerDetails
    @PassengerID = 2,
    @Title = 'Mrs.',
    @FirstName = 'Emily',
    @LastName = 'Brown',
    @Email = 'emily.brown@salfordair.com',
    @DoB = '1990-08-22',
    @Meal = 'Non-Vegetarian';



CREATE VIEW vw_EmployeeBoardingRevenue AS
SELECT 
    E.EmployeeID,
    E.Title + ' ' + E.FirstName + ' ' + E.LastName AS EmployeeName,
    T.TicketID,
    T.IssueDate,
    T.SeatNumber,
    T.Class,
    F.FlightNumber,
    T.Fare,

   -- Extra Costs
    ISNULL(S.ExtraBaggageKG * 100, 0) AS BaggageFee,
    CASE WHEN S.UpgradedMeal = 1 THEN 20 ELSE 0 END AS MealFee,
    CASE WHEN S.PreferredSeat = 1 THEN 30 ELSE 0 END AS SeatFee,

     -- Total Costs
    T.Fare 
    + ISNULL(S.ExtraBaggageKG * 100, 0)
    + CASE WHEN S.UpgradedMeal = 1 THEN 20 ELSE 0 END
    + CASE WHEN S.PreferredSeat = 1 THEN 30 ELSE 0 END AS TotalRevenue

FROM Tickets T
INNER JOIN Employees E ON T.EmployeeID = E.EmployeeID
INNER JOIN Flights F ON T.FlightID = F.FlightID
LEFT JOIN AdditionalServices S ON T.TicketID = S.TicketID;



SELECT * 
FROM vw_EmployeeBoardingRevenue
WHERE EmployeeID = 1;


-- Example query to get total revenue per employee & flight using the view:
SELECT
    EmployeeID,
    EmployeeName,
    FlightNumber,
    SUM(TotalRevenue) AS TotalRevenuePerFlight
FROM vw_EmployeeBoardingRevenue
GROUP BY EmployeeID, EmployeeName, FlightNumber
ORDER BY EmployeeID, FlightNumber;






CREATE TRIGGER trg_UpdateSeatStatusOnInsert
ON Tickets
AFTER INSERT
AS
BEGIN
    UPDATE T
    SET SeatStatus = 'Reserved'
    FROM Tickets T
    INNER JOIN inserted I ON T.TicketID = I.TicketID;
END;


INSERT INTO Tickets (
    ReservationID, FlightID, IssueDate, IssueTime, Fare,
    SeatNumber, Class, EmployeeID
)
VALUES (
    5, 1, CAST(GETDATE() AS DATE), '11:30', 380.00,
    '4A', 'Economy', 1);

--To check if Seatstatus was changed or not.
SELECT TicketID, SeatNumber, SeatStatus FROM Tickets WHERE SeatNumber = '4A';



CREATE FUNCTION ufn_CountCheckedInBaggage (
    @FlightID INT,
    @TargetDate DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @CheckedInCount INT;

    SELECT @CheckedInCount = COUNT(*)
    FROM Baggage B
    INNER JOIN Tickets T ON B.TicketID = T.TicketID
    WHERE 
        B.Status = 'CheckedIn'
        AND T.FlightID = @FlightID
        AND CAST(T.IssueDate AS DATE) = @TargetDate;

    RETURN @CheckedInCount;
END;

SELECT dbo.ufn_CountCheckedInBaggage(5, CAST(GETDATE() AS DATE)) AS BaggageCountToday;


-- Query to find passengers with tickets where the fare is above the average fare of all tickets
SELECT
    P.PassengerID,
    P.FirstName,
    P.LastName,
    T.TicketID,
    T.Fare
FROM Passengers AS P
JOIN Reservations AS R ON P.PassengerID = R.PassengerID
JOIN Tickets AS T ON R.ReservationID = T.ReservationID
WHERE T.Fare > (SELECT AVG(Fare) FROM Tickets);    -- Subquery calculates the average fare








-- Lists of flights of a period of time issued by specific staffs

CREATE PROCEDURE sp_GetFlightsWithIssuedTickets
    @StartDate DATE,
    @EndDate DATE,
    @Class NVARCHAR(20),
    @EmployeeID INT = NULL 
AS
BEGIN
    SELECT DISTINCT 
        F.FlightNumber,
        F.[From] AS [From],
        F.[To] AS [To],
        T.IssueDate,
        T.Class,
        E.FirstName + ' ' + E.LastName AS IssuedBy
    FROM Flights F
    INNER JOIN Tickets T ON F.FlightID = T.FlightID
    INNER JOIN Employees E ON T.EmployeeID = E.EmployeeID
    WHERE 
        CAST(T.IssueDate AS DATE) BETWEEN @StartDate AND @EndDate
        AND T.Class = @Class
        AND (@EmployeeID IS NULL OR T.EmployeeID = @EmployeeID)
    ORDER BY T.IssueDate;
END;


-- Without Employee Selected
EXEC sp_GetFlightsWithIssuedTickets '2025-03-01', '2025-05-01', 'Economy';

-- With Selected Employee
EXEC sp_GetFlightsWithIssuedTickets '2025-03-01', '2025-05-01', 'Business', 1;





--Lists of extra costs for each passengers.
CREATE VIEW vw_PassengerServiceDetails AS
SELECT 
    P.PassengerID,
    P.PNR,
    P.FirstName + ' ' + P.LastName AS FullName,
    T.TicketID,
    T.SeatNumber,
    ISNULL(A.ExtraBaggageKG * 100, 0) AS BaggageFee,
    CASE WHEN A.UpgradedMeal = 1 THEN 20 ELSE 0 END AS MealFee,
    CASE WHEN A.PreferredSeat = 1 THEN 30 ELSE 0 END AS SeatFee,
    T.Fare,
    '£' + FORMAT(
        T.Fare 
        + ISNULL(A.ExtraBaggageKG * 100, 0)
        + CASE WHEN A.UpgradedMeal = 1 THEN 20 ELSE 0 END
        + CASE WHEN A.PreferredSeat = 1 THEN 30 ELSE 0 END,
    'N2') AS TotalCost
FROM Passengers P
JOIN Reservations R ON P.PassengerID = R.PassengerID
JOIN Tickets T ON R.ReservationID = T.ReservationID
LEFT JOIN AdditionalServices A ON T.TicketID = A.TicketID;



SELECT * FROM vw_PassengerServiceDetails WHERE PassengerID = 1;




--SeatNum=Null
INSERT INTO Tickets (
    ReservationID, FlightID, IssueDate, IssueTime, Fare,
    SeatNumber, Class, EmployeeID
)
VALUES (
    1, 1, CAST(GETDATE() AS DATE), '14:00', 500.00,
    NULL, 'Business', 1
);



--SeatNum=Null
INSERT INTO Tickets (
    ReservationID, FlightID, IssueDate, IssueTime, Fare,
    SeatNumber, Class, EmployeeID
)
VALUES (
    1, 1, CAST(GETDATE() AS DATE), '14:00', 500.00,
    '10A', 'Business', 1
);




