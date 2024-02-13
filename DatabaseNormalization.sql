-- Title: Database Normalization 
-- Author: Ruthanne Ward
-- Description: This SQL file is used to normalize the Parks_Info table to 1NF and 2NF.


-- Create Table Parks_Info. 
CREATE TABLE Parks_Info (
    ID SERIAL PRIMARY KEY, -- Create ID column and specify as the primary key. 
    ParkName VARCHAR(255), -- Create Parkname column and specify character as the data type.
    Facilities VARCHAR(255) -- Create Facilities column and specify character as the data type.
);

-- Insert data into Parks_Info. 
INSERT INTO Parks_Info (ParkName, Facilities) VALUES
('Central Park', 'Playground, Restroom, Picnic area'), -- Central Park has a playground, restroom and picnic area.
('Liberty Park', 'Restroom, Picnic area'), -- Liberty Park has a restroom and picnic area.
('Riverside Park', 'Playground, Bike Path'); -- Riverside Park has a playgorunf and bike path.

--Normalize to 1NF by creating two seperate tables.

-- Create table Parks.
CREATE TABLE Parks (
    ParkID SERIAL PRIMARY KEY, -- Create ParkID column and specify it as the primary key.
    ParkName VARCHAR(255) -- Create ParkName column and specify character as the data type.
);

-- Create table Facilities. 
CREATE TABLE Facilities (
    FacilityID SERIAL PRIMARY KEY, -- Create FacilitiyID column and specify it as the primary key.
    ParkID INT, -- Create ParkID column and specify integer as the data type.
    FacilityName VARCHAR(255), -- Create FacilityName column and specify character as the data type.
    FOREIGN KEY (ParkID) REFERENCES Parks(ParkID) -- Connect the Facilities table to the Parks table by setting the ParkID column as the Foreign Key.
);

-- Populate Parks with data from Parks_Info
INSERT INTO Parks (ParkName)
SELECT DISTINCT ParkName FROM Parks_Info;

-- View Parks Table to check the serial value connected to each park name.
SELECT * FROM Parks

-- Populate the Facilities table with the ParkID and corresponding Facility Name.
INSERT INTO Facilities (ParkID, FacilityName) VALUES 
(3, 'Playground'),
(3, 'Restroom'),
(3, 'Picnic area'),
(2, 'Restroom'),
(2, 'Picnic area'),
(1, 'Playground'),
(1, 'Bike Path')
;

-- Normalize to 2NF by removing partial dependencies

-- Create table ParkFacilities 
CREATE TABLE ParkFacilities (
    FacilityID SERIAL PRIMARY KEY, -- Create FacilityID column and specify it as the Primary Key.
    FacilityName VARCHAR(255) -- Create FacilityName column and specify character as the data type.
);

-- Populate the ParkFacilities table with the facility names.
INSERT INTO ParkFacilities (FacilityName)
VALUES ('Playground'), ('Restroom'), ('Picnic area'), ('Bike Path');

-- Add ParkFacilityID column to the Facilities table.
ALTER TABLE Facilities ADD COLUMN ParkFacilityID INT;

-- Connect the Facilities table to the ParkFacilities table by specifying the ParkFacilityID column as the Foreign Key.
ALTER TABLE Facilities
ADD CONSTRAINT fk_parkfacilityid FOREIGN KEY (ParkFacilityID) REFERENCES ParkFacilities(FacilityID);

-- Populate the ParkFacilityID column with the facility IDs corresponding to the FacilityName.
UPDATE Facilities
SET ParkFacilityID = (SELECT FacilityID FROM ParkFacilities WHERE FacilityName = Facilities.FacilityName)
;
-- Cleanup redundant columns.
ALTER TABLE Facilities DROP COLUMN FacilityName;

-- View Facilities table.
SELECT * FROM Facilities

