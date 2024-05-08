-- Create database
CREATE DATABASE Hospital_System;
GO

-- Use the newly created database
USE Hospital_System;
GO

--Create schema
CREATE SCHEMA Hospital;
GO

-- Create tables under Hospital schema
---- Creating Departments table
CREATE TABLE Hospital.Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);
-- Creating patients table
CREATE TABLE Hospital.Patients (
    PatientID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Address VARCHAR(255),
    DateOfBirth DATE,
    Insurance VARCHAR(100),
    Email VARCHAR(255), 
    Telephone VARCHAR(20),
    Username VARCHAR(50) UNIQUE,
    Password VARCHAR(50),
    DateLeft DATE NULL, 
    RegistrationDate DATETIME DEFAULT GETDATE()
);
-- Creating Doctors table
CREATE TABLE Hospital.Doctors (
    DoctorID INT PRIMARY KEY,
    FullName VARCHAR(100),
    DepartmentID INT,
    Specialization VARCHAR(100),
    LicenseNumber VARCHAR(50) UNIQUE,
    Email VARCHAR(255), 
    Telephone VARCHAR(20),
    RegistrationDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (DepartmentID) REFERENCES Hospital.Departments(DepartmentID)
);
-- Creating Medical Records table
CREATE TABLE Hospital.MedicalRecords (
    RecordID INT PRIMARY KEY,
    PatientID INT,
    Diagnosis VARCHAR(255),
    Medication VARCHAR(255),
    Allergies VARCHAR(255),
    LastUpdated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (PatientID) REFERENCES Hospital.Patients(PatientID)
);
-- Creating Appointments table
CREATE TABLE Hospital.Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME,
    Status VARCHAR(20),
    AppointmentNotes VARCHAR(1000), 
    FollowUpDate DATE NULL, 
    FOREIGN KEY (PatientID) REFERENCES Hospital.Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Hospital.Doctors(DoctorID)
);

-- Insert data into Departments table

INSERT INTO Hospital.Departments (DepartmentID, DepartmentName)
VALUES
    (101, 'Cardiology'),
    (102, 'Pediatrics'),
    (103, 'Oncology'),
    (104, 'Dermatology'),
    (105, 'Gastroenterologists'),
    (106, 'Orthopedics'),
    (107, 'Psychiatry'),
    (108, 'Urology'),
    (109, 'Gynecology'),
    (110, 'ENT');

-- Insert data into Patients table
INSERT INTO Hospital.Patients (PatientID, FullName, Address, DateOfBirth, Insurance, Email, Telephone, Username, Password, DateLeft)
VALUES
    (1001, 'Nanaji', '123 Main St, City', '1985-05-10', 'ABC Insurance', 'nanaji@example.com', '123-456-7890', 'Nanaji', 'Sujatha', NULL),
    (1002, 'Chandirani', '456 Oak St, Town', '1990-08-15', 'XYZ Insurance', 'chan@example.com', '987-654-3210', 'Chandirani456', 'Rani', NULL),
    (1003, 'Chandrakala', '789 Elm St, Village', '1978-12-20', 'DEF Insurance', 'kala@example.com', '555-123-9876', 'Chandrakala', 'abc123', NULL),
    (1004, 'Chandravathi', '321 Pine St, Town', '1992-04-25', 'GHI Insurance', 'vathi@example.com', '555-987-6543', 'Chandravathi', 'qwerty', NULL),
    (1005, 'Sasikala', '654 Cedar St, City', '1980-10-05', 'JKL Insurance', 'sasi@example.com', '111-222-3333', 'Sasikala', 'password', NULL),
    (1006, 'Ramadevi', '987 Maple St, Town', '1975-03-15', 'MNO Insurance', 'Rama@example.com', '444-555-6666', 'Ramadevi', 'Dev123', NULL),
    (1007, 'Sirisha', '741 Birch St, Village', '1995-07-30', 'PQR Insurance', 'kanti@example.com', '777-888-9999', 'kanti', 'Sirisha123', NULL),
    (1008, 'Rajanikanth', '852 Oak St, City', '1989-01-18', 'STU Insurance', 'kanth@example.com', '666-777-8888', 'Rajani', 'Kanth', NULL),
    (1009, 'Ramesh Babu', '963 Willow St, Town', '1982-06-12', 'VWX Insurance', 'Ramesh@example.com', '333-444-5555', 'Ramesh', 'Babu', NULL),
    (1010, 'Murali Krishna', '159 Walnut St, Village', '1998-09-08', 'YZA Insurance', 'krishna@example.com', '999-888-7777', 'Murali', 'Krishna', NULL);

-- Insert data into Doctors table
INSERT INTO Hospital.Doctors (DoctorID, FullName, DepartmentID, Specialization, LicenseNumber, Email, Telephone)
VALUES
    (2001, 'Dr. Subrahmanyeswara Rao', 101, 'Cardiology', 'CARD123', 'Sub@example.com', '555-123-4567'),
    (2002, 'Dr. Sohith', 102, 'Pediatrics', 'PEDI456', 'sohith@example.com', '555-987-6543'),
    (2003, 'Dr. Deepthi', 103, 'Oncology', 'ONCO789', 'Deepthi@example.com', '555-111-2222'),
    (2004, 'Dr. Deepya', 104, 'Dermatology', 'DERM101', 'deep@example.com', '555-333-4444'),
    (2005, 'Dr. Sumathi', 105, 'Gastroenterologists', 'NEUR202', 'sumathi@example.com', '555-555-6666'),
    (2006, 'Dr. Mallikarjuna', 106, 'Orthopedics', 'ORTH303', 'mallikarjuna@example.com', '555-777-8888'),
    (2007, 'Dr. Uma Mahesh', 107, 'Psychiatry', 'PSYC404', 'Uma@example.com', '555-999-0000'),
    (2008, 'Dr. Harsha Vardhan ', 108, 'Urology', 'UROL505', 'Harsha@example.com', '555-222-3333'),
    (2009, 'Dr. Venu Gopal', 109, 'Gynecology', 'GYNE606', 'venu@example.com', '555-888-9999'),
    (2010, 'Dr. Rajeswari', 110, 'ENT', 'ENT707', 'raj@example.com', '555-444-5555');
	

-- Insert data into MedicalRecords table
INSERT INTO Hospital.MedicalRecords (RecordID, PatientID, Diagnosis, Medication, Allergies)
VALUES
    (3001, 1001, 'Cancer', 'Lisinopril', 'Penicillin'),
    (3002, 1002, 'Cancer', 'Flonase', 'None'),
    (3003, 1003, 'Diabetes', 'Insulin', 'Sulfa Drugs'),
    (3004, 1004, 'Bronchitis', 'Albuterol', 'None'),
    (3005, 1005, 'Arthritis', 'Ibuprofen', 'Aspirin'),
    (3006, 1006, 'Depression', 'Prozac', 'None'),
    (3007, 1007, 'Migraine', 'Sumatriptan', 'None'),
    (3008, 1008, 'High Cholesterol', 'Atorvastatin', 'Statins'),
    (3009, 1009, 'Cancer', 'Xanax', 'None'),
    (3010, 1010, 'Hypothyroidism', 'Levothyroxine', 'None');
	
-- Insert data into Appointments table
INSERT INTO Hospital.Appointments (AppointmentID, PatientID, DoctorID, AppointmentDate, Status, AppointmentNotes, FollowUpDate)
VALUES
    (4001, 1001, 2001, '2024-04-10 10:00:00', 'Scheduled', 'Annual checkup', '2024-04-10'),
    (4002, 1002, 2002, '2024-04-15 14:30:00', 'Scheduled', 'Follow-up for flu', '2024-05-15'),
	(4011, 1003, 2002, '2024-04-15 14:30:00', 'Scheduled', 'Follow-up for flu', '2024-05-15'),
    (4003, 1003, 2003, '2024-04-20 09:00:00', 'Cancelled', 'Follow-up for diabetes', '2024-05-20'),
    (4004, 1004, 2004, '2024-04-25 11:30:00', 'Completed', 'Checkup for bronchitis', '2024-03-25'),
    (4005, 1005, 2005, '2024-05-01 13:00:00', 'Completed', 'Appointment rescheduled', '2024-03-25'),
    (4006, 1006, 2006, '2024-05-05 15:30:00', 'Scheduled', 'Discuss treatment options', '2024-06-05'),
    (4007, 1007, 2007, '2024-05-10 16:30:00', 'Scheduled', 'Migraine treatment', '2024-06-10'),
    (4008, 1008, 2008, '2024-05-15 08:00:00', 'Cancelled', 'Cholesterol check', '2024-06-15'),
    (4009, 1009, 2009, '2024-05-20 10:30:00', 'Scheduled', 'Anxiety evaluation', '2024-06-20'),
    (4010, 1010, 2010, '2024-05-25 12:00:00', 'Cancelled', 'Thyroid check', '2024-06-25');

--Part 2---

-- Adding constraint to Appointments table to check that appointment date is not in the past
ALTER TABLE Hospital.Appointments
ADD CONSTRAINT CHK_AppointmentDate CHECK (AppointmentDate >= CAST(GETDATE() AS DATE));


--List older than 40 ---

SELECT Patients.*
FROM Hospital.Patients AS Patients
JOIN Hospital.MedicalRecords AS MedicalRecords
ON Patients.PatientID = MedicalRecords.PatientID
WHERE DATEDIFF(YEAR, Patients.DateOfBirth, GETDATE()) > 40
AND MedicalRecords.Diagnosis LIKE '%Cancer%';


-----Stored Procedures ---

-- a) Search the database for matching character strings by name of medicine:--

CREATE PROCEDURE SearchMedicineByName
    @MedicineName VARCHAR(100)
AS
BEGIN
    SELECT *
    FROM Hospital.MedicalRecords
    WHERE Medication LIKE '%' + @MedicineName + '%';
END;


-- b)  Return a full list of diagnosis and allergies for a specific patient who has an appointment today:

CREATE PROCEDURE GetPatientDiagnosisAndAllergiesForToday
    @PatientID INT
AS
BEGIN
    DECLARE @Today DATE = CAST(GETDATE() AS DATE);

    SELECT MedicalRecords.Diagnosis, MedicalRecords.Allergies
    FROM Hospital.MedicalRecords
    INNER JOIN Hospital.Appointments ON MedicalRecords.PatientID = Appointments.PatientID
    WHERE MedicalRecords.PatientID = @PatientID
    AND CONVERT(DATE, Appointments.AppointmentDate) = @Today;
END;


-- C)Update the details for an existing doctor:
CREATE PROCEDURE UpdateDoctorDetails
    @DoctorID INT,
    @FullName VARCHAR(100),
    @DepartmentID INT,
    @Specialization VARCHAR(100),
    @LicenseNumber VARCHAR(50),
    @Email VARCHAR(100),
    @Telephone VARCHAR(20)
AS
BEGIN
    UPDATE Hospital.Doctors
    SET FullName = @FullName,
        DepartmentID = @DepartmentID,
        Specialization = @Specialization,
        LicenseNumber = @LicenseNumber,
        Email = @Email,
        Telephone = @Telephone
    WHERE DoctorID = @DoctorID;
END;


-- D) Delete the appointment whose status is already completed

CREATE PROCEDURE DeleteCompletedAppointments
AS
BEGIN
    DELETE FROM Hospital.Appointments
    WHERE Status = 'completed';
END;


-- Comprehensive View of Hospital Appointments

CREATE VIEW Hospital.AllAppointmentsView AS
SELECT
    A.AppointmentID,
    A.AppointmentDate,
    D.FullName AS DoctorName,
    D.Specialization AS DoctorSpecialty,
    Dep.DepartmentName
FROM
    Hospital.Appointments A
LEFT JOIN
    Hospital.Doctors D ON A.DoctorID = D.DoctorID
INNER JOIN
    Hospital.Departments Dep ON D.DepartmentID = Dep.DepartmentID;


	--Testing All Appointments View
	SELECT * FROM Hospital.AllAppointmentsView;

-- Trigger to change the state of an appointment to "available" when it is cancelled

CREATE TRIGGER UpdateAppointmentStateOnCancellation
ON Hospital.Appointments
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Status)
    BEGIN
        UPDATE Hospital.Appointments
        SET Status = 'available'
        WHERE Status = 'cancelled';
    END
END;

--Testing: Update the status of an appointment to 'cancelled'

UPDATE Hospital.Appointments
SET Status = 'cancelled'
WHERE AppointmentID = 4009; -- Provide the appropriate AppointmentID here
SELECT * FROM Hospital.Appointments WHERE AppointmentID = 4009

-- Number of Completed Appointments for Gastroenterologists

SELECT COUNT(*) AS CompletedAppointments
FROM Hospital.Appointments A
JOIN Hospital.Doctors D ON A.DoctorID = D.DoctorID
WHERE A.Status = 'completed'
AND D.Specialization = 'Gastroenterologists';



----Additonal Queires ---------

-- 1. Query to find doctors with the highest number of appointments:

SELECT TOP 1
    D.FullName AS DoctorName,
    D.Specialization,
    COUNT(A.AppointmentID) AS AppointmentCount
FROM
    Hospital.Doctors AS D
JOIN
    Hospital.Appointments AS A ON D.DoctorID = A.DoctorID
GROUP BY
    D.FullName,
    D.Specialization
ORDER BY
    AppointmentCount DESC;


-- 2. View to display patient appointments with doctor details:

CREATE VIEW Hospital.PatientAppointmentDetails AS
SELECT A.AppointmentID, A.AppointmentDate, A.Status,
       P.FullName AS PatientName, P.Email AS PatientEmail,
       D.FullName AS DoctorName, D.Specialization, D.Email AS DoctorEmail
FROM Hospital.Appointments AS A
JOIN Hospital.Patients AS P ON A.PatientID = P.PatientID
JOIN Hospital.Doctors AS D ON A.DoctorID = D.DoctorID;

--Testing Patient Appointment Details
SELECT * FROM Hospital.PatientAppointmentDetails;

--3. Stored procedure to retrieve patient details by username

CREATE PROCEDURE GetPatientDetailsByUsername
    @Username VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Hospital.Patients
    WHERE Username = @Username;
END;

--4 Function to calculate patient age based on date of birth:

CREATE FUNCTION CalculatePatientAge
(@DateOfBirth DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Age INT;
    SET @Age = DATEDIFF(YEAR, @DateOfBirth, GETDATE());
    RETURN @Age;
END;

---Test with known date of birth values
DECLARE @DateOfBirth1 DATE = '1990-05-15';
DECLARE @DateOfBirth2 DATE = '1985-03-25';
DECLARE @DateOfBirth3 DATE = '1978-11-10';

-- Call the function and store the result
DECLARE @Age1 INT = dbo.CalculatePatientAge(@DateOfBirth1);
DECLARE @Age2 INT = dbo.CalculatePatientAge(@DateOfBirth2);
DECLARE @Age3 INT = dbo.CalculatePatientAge(@DateOfBirth3);

-- Output the results
SELECT @Age1 AS Age1, @Age2 AS Age2, @Age3 AS Age3;

