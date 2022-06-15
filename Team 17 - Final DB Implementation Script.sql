/* GROUP 17
Project Name : Healthcare Management System

Submitted by
Amey Kharote                       NUID : 002101756
Deepika Balasubramanian            NUID : 002194564
Kokku Kishore                      NUID : 002105595
Ninoshka Maxy Pinto                NUID : 001564944
Swaroop Sanjeev Giri               NUID : 002928636
*/

--DROP DATABASE Team17Demo;
Create database Team17Demo;
Use Team17Demo;

--- 1. Create patient table 
CREATE TABLE Patient( 
PatientID VARCHAR(20) NOT NULL PRIMARY KEY,  
FirstName VARCHAR(20),  
LastName VARCHAR(20) NOT NULL,  
DateOfBirth Date,  
Gender VARCHAR(1) NOT NULL, 
MobileNumber VARCHAR(20),  
EmailId VARCHAR(20),  
BloodGroup VARCHAR(10),  
CreatedDate Date DEFAULT GETDATE(),  
LastUpdatedDate Date );

Select * from Patient;

--- 2. create patient insurance table 
CREATE TABLE PatientInsurance( 
InsuranceID VARCHAR(20) Not Null Primary Key,  
PatientID VARCHAR(20) Not Null REFERENCES Patient(PatientID),  
InsuranceProvider VARCHAR(50),  
InsuranceNumber VARCHAR(20),  
CoPayer VARCHAR(20),  
CreatedDate DATE DEFAULT GETDATE(),  
LastUpdatedDate Date,  
StartDate Date,  
ExpiryDate Date);

Select * from PatientInsurance;

--- 3. create department table 
Create table Department( 
DepartmentID VARCHAR(20) NOT NULL PRIMARY KEY, 
DepartmentName VARCHAR(20) NOT NULL, 
); 

Select * from Department;

--- 4. create role table 
Create TABLE Role( 
RoleID varchar(20) NOT NULL primary KEY, 
RoleName varchar(20) NOT NULL, 
RoleDesc varchar(200) NOT NULL  
);

Select * from Role;

--- 5. create staff table 
Create table Staff( 
StaffID Varchar(20) NOT NULL PRIMARY KEY, 
RoleID VARCHAR(20) NOT NULL REFERENCES Role(RoleID), 
FirstName VARCHAR(20), 
LastName VARCHAR(20) NOT NULL, 
DateOfBirth DATE NOT null, 
Gender VARCHAR(1) NOT NULL,
EmailId VARCHAR(20), 
MobileNumber VARCHAR(20),  
BloodGroup VARCHAR(10), 
CreatedDate Date DEFAULT GETDATE(), 
LastUpdatedDate Date, 
CreatedBy VARCHAR(20) 
);

Select * from Staff;
  
--- 6. create staff department relation table 
Create table StaffDepartmentRelation( 
StaffID VARCHAR(20) NOT NULL REFERENCES Staff(StaffID), 
DepartmentID VARCHAR(20) NOT NULL REFERENCES Department(DepartmentID), 
CONSTRAINT PKStaffDepartment PRIMARY KEY CLUSTERED(StaffID, DepartmentID));

Select * from StaffDepartmentRelation;
  
--- 7. create address table 
Create TABLE Address ( 
AddressID varchar(20) not null primary key, 
AddressLine1 varchar(100) not null, 
AddressLine2 varchar(100) NOT NULL, 
City varchar(20) NOT NULL, 
State varchar(20) NOT NULL, 
ZipCode int NOT NULL, 
IsPrimary Char(1) Default 'N', 
CreatedDate date DEFAULT GETDATE(), 
LastUpdatedDate date 
);

Select * from Address;

--- 8. create patient address relation table 
Create table PatientAddressRelation ( 
PatientAddrRelationID varchar(20) not null primary key, 
AddressID varchar(20)  not null references Address(AddressID), 
PatientID varchar(20)  not null references Patient(PatientID), 
CreatedDate date DEFAULT GETDATE(), 
LastUpdatedDate date 
);

Select * from PatientAddressRelation;

--- 9. create staff address relation table 
Create table StaffAddressRelation( 
StaffAddrRelationID int not null primary KEY, 
AddressID varchar(20) NOT NULL REFERENCES Address(AddressID), 
StaffID varchar(20) NOT NULL REFERENCES Staff(StaffID), 
CreatedDate date DEFAULT GETDATE(), 
LastUpdatedDate date 
); 

Select * from StaffAddressRelation;

-- 10. Create PatientEncounter
Create TABLE PatientEncounter(
EncounterID varchar(20) NOT NULL primary KEY,
PatientID varchar(20) NOT NULL REFERENCES Patient(PatientID),
StaffID varchar(20) NOT NULL REFERENCES Staff(StaffID),
EncounterDate date DEFAULT GETDATE(),
IsAdmitted char(1) default 'N',
LastModifiedDate date
);

Select * from PatientEncounter;

--11. Create InfrastructureType
Create TABLE InfrastructureType(
InfraTypeID varchar(20) NOT NULL primary Key,
InfraUnitName varchar(20) NOT NULL,
InfraUnitDesc varchar(20)
);

Select * from InfrastructureType;

--12. Create Infrastructure
CREATE TABLE Infrastructure(
InfraUnitID VARCHAR(20) NOT NULL primary KEY,
InfraTypeID VARCHAR(20) NOT NULL REFERENCES InfrastructureType (InfraTypeID),
UnitNumber VARCHAR(20),
IsOccupied CHAR(1) DEFAULT 'N',
ChargePerDay INT
);

Select * from Infrastructure;

--13. Create Patient Admission History
Create TABLE PatientAdmissionHistory(
AdmissionID varchar(20) NOT NULL primary KEY,
EncounterID varchar(20) NOT NULL REFERENCES PatientEncounter(EncounterID),
AdmissionDate date default GETDATE(),
DischargeDate date,
InfraUnitID varchar(20) NOT NULL REFERENCES Infrastructure(InfraUnitID),
EncounterDate date DEFAULT GETDATE(),
LastModifiedDate date
);

Select * from PatientAdmissionHistory;

--14. Create Vital Signs
CREATE TABLE VitalSigns(
VitalSignID VARCHAR(20) NOT NULL primary KEY,
PatientID VARCHAR(20) NOT NULL REFERENCES Patient(PatientID),
EncounterID VARCHAR(20) NOT NULL REFERENCES PatientEncounter (EncounterID),
DateCollected DATE,
Temperature FLOAT,
HeartRate INT,
RespiratoryRate INT,
BloodPressure INT
);

Select * from VitalSigns;

-- 15. Create PatientInsurance before executing PatientAccounts
Create TABLE PatientAccounts(
AccountID int NOT NULL primary KEY,
PatientID varchar(20) NOT NULL REFERENCES Patient(PatientID),
EncounterID varchar(20) NOT NULL REFERENCES PatientEncounter(EncounterID),
InsuranceID varchar(20) NOT NULL REFERENCES PatientInsurance(InsuranceID),
CreatedDate date DEFAULT GETDATE(),
TotalBill float NOT NULL,
ModeOfPayment VARCHAR(20) NOT NULL
);

Select * from PatientAccounts;

--16. Create Laboratory Tests
CREATE TABLE LaboratoryTests (
LabTestID VARCHAR(20) NOT NULL  primary KEY,
EncounterId VARCHAR(20) NOT NULL REFERENCES  PatientEncounter (EncounterID),
LabTestName VARCHAR(20),
Status VARCHAR(20),
CreatedDate DATE DEFAULT GETDATE(),
LastUpdatedDate DATE
);

Select * from LaboratoryTests;

--17. Create Laboratory Reports
CREATE TABLE LaboratoryReports (
LabReportID VARCHAR(20) NOT NULL primary KEY,
LabTestID VARCHAR(20) NOT NULL REFERENCES LaboratoryTests (LabTestID),
Report VARCHAR(20),
ResultDate DATE
);

Select * from LaboratoryReports;

-- Insertion Scripts
----1. insert into patient 
insert into Patient values('1','Saif','Khan','2000-05-06','M','8082522581','saifkhan@gmail.com','O+ve',GETDATE(),GETDATE()); 
insert into Patient values('2','Kareena','Khan','1995-05-06','F','9082522582','kareena@gmail.com','B+ve',GETDATE(),GETDATE());
insert into Patient values('3','Aryan','Khan','1960-05-06','M','8982522583','aryankhan@gmail.com','A+ve',GETDATE(),GETDATE());
insert into Patient values('4','Alia','Khan','2020-05-06','F','8662522584','aliakhan@gmail.com','B-ve',GETDATE(),GETDATE()); 
insert into Patient values('5','Taimur','Khan','2000-05-06','M','8082522585','saifkhan@gmail.com','O-ve',GETDATE(),GETDATE());
insert into Patient values('6','Sara','Khan','1995-05-06','F','9082522586','kareena@gmail.com','B-ve',GETDATE(),GETDATE()); 
insert into Patient values('7','Juniad','Khan','1960-05-06','M','8982522587','aryankhan@gmail.com','O+ve',GETDATE(),GETDATE());
insert into Patient values('8','Soha','Khan','2020-05-06','F','8662522588','aliakhan@gmail.com','B+ve',GETDATE(),GETDATE()); 
insert into Patient values('9','Tiger','Khan','2000-05-06','M','8082522589','saifkhan@gmail.com','A+ve',GETDATE(),GETDATE()); 
insert into Patient values('10','Faroukh','Engineer','1995-05-06','M','9082522510','kareena@gmail.com','B+ve',GETDATE(),GETDATE());
Select * from Patient;

----2. insert into patient insurance
insert into PatientInsurance values('I1','10','BCBSMA','1234567890','Amey',DEFAULT,GETDATE(),'2000-05-06','2002-05-06'); 
insert into PatientInsurance values('I2','9','BCBSNJ','2345678901','Kishore',DEFAULT,GETDATE(),'2002-05-06','2004-05-06');
insert into PatientInsurance values('I3','8','BCBSNJ','3456789012','Ninoshka',DEFAULT,GETDATE(),'2004-05-06','2006-05-06');
insert into PatientInsurance values('I4','7','BCBSMA','4567890123','Deepika',DEFAULT,GETDATE(),'2006-05-06','2008-05-06');
insert into PatientInsurance values('I5','6','BCBSNJ','5678901234','Swaroop',DEFAULT,GETDATE(),'2008-05-06','2010-05-06');
insert into PatientInsurance values('I6','5','BCBSNC','6789012345','Joy',DEFAULT,GETDATE(), '2010-05-06','2012-05-06'); 
insert into PatientInsurance values('I7','4','BCBSMA','7890123456','Shreyas',DEFAULT, GETDATE(), '2012-05-06','2014-05-06');
insert into PatientInsurance values('I8','3','BCBSMA','8901234567','Rugved',DEFAULT, GETDATE(), '2014-05-06', '2016-05-06'); 
insert into PatientInsurance values('I9','2','BCBSNY','9012345678','Nikhil',DEFAULT, GETDATE(), '2016-05-06','2018-05-06'); 
insert into PatientInsurance values('I10','1','BCBSNY','0123456789','Shiva',DEFAULT, GETDATE(), '2018-05-06','2020-05-06');
Select * from PatientInsurance;

--3 Insert into Department
insert Department values
('D1','Radiology'),
('D2','Neurology'),
('D3','Physiotherapy'),
('D4','Pediatrics'),
('D5','Gynaecology'),
('D6','Ophthalmology'),
('D7','Dentistry'),
('D8','Oncology'),
('D9','Dermatology'),
('D10','Cardiology');
Select * from Department;

--4 Insert into Role
insert into Role values
(1000,'Doctor','Often counsel patients on diet, hygiene, and preventive healthcare.'),
(1001,'Nurse','Assessing, observing, and speaking to patients'),
(1002,'Wardboy','Ward boys are primarily responsible for providing care to a patient, an elderly person, chronically sick person or to a mentally and physically disabled person usually in a hospital or clinic.'),
(1003,'Receptionist','Receptionists are responsible for greeting visitors and delivering exceptional customer service assistance.'),
(1004,'Technician','Inspecting, analyzing, and troubleshooting systems and equipment.'),
(1005,'Intern','Fulfill tasks set out by supervisors from several departments. Attend meetings and take minutes.'),
(1006,'Therapist','licensed mental health professionals who specialize in helping clients develop better cognitive and emotional skills, reduce symptoms of mental illness, and cope with various life challenges to improve their lives.'),
(1007,'Dietician','Dietitians are experts in the use of food and nutrition to promote health and manage disease.'),
(1008,'Pharmacists','Pharmacists dispense prescription medications to patients and offer expertise in the safe use of prescriptions.'),
(1009,'Admin','An Administrator provides office support to either an individual or team and is vital for the smooth-running of a business.');
Select * from Role;

--- 5. Insert staff table
insert into Staff values
('S1','1000','Jane','Dcosta','01-01-1996','F','janedcosta@gmail.com','8365489479','O+ve',DEFAULT,GETDATE(),'SysAdmin'),
('S2','1001','Paine','Tim','01-06-1997','M','timepaine@gmail.com','8365489499','A+ve',DEFAULT,GETDATE(),'SysAdmin'),
('S3','1002','Mark','Brown','07-06-1991','M','markbrown@gmail.com','9365479499','B-ve',DEFAULT,GETDATE(),'SysAdmin'),
('S4','1000','Tony','Startk','01-01-1996','M','tonystark@gmail.com','9892012231','O+ve',DEFAULT,GETDATE(),'SysAdmin'),
('S5','1007','Jonny','Evans','01-01-1998','M','jonnyevans@gmail.com','98920124123','B-ve',DEFAULT,GETDATE(),'SysAdmin'),
('S6','1004','Nikhil','Pinto','05-06-1993','M','kukhil@gmail.com','8082423879','B+ve',DEFAULT,GETDATE(),'SysAdmin'),
('S7','1008','Rughved','Dcosta','08-05-1980','F','janedcosta@gmail.com','8365489479','O+ve',DEFAULT,GETDATE(),'SysAdmin'),
('S8','1000','Kevin','Kharote','08-05-1991','M','kevinp@gmail.com','8365489479','B-ve',DEFAULT,GETDATE(),'SysAdmin'),
('S9','1000','Gayatri','Devi','01-01-1976','F','gayatri@gmail.com','8787876565','AB+ve',DEFAULT,GETDATE(),'SysAdmin'),
('S10','1009','Nicholas','Brown','10-03-1992','F','nicholas@gmail.com','9965489479','A+ve',DEFAULT,GETDATE(),'SysAdmin');
Select * from Staff;


--- 6. Insert staff department relation table 
insert into dbo.StaffDepartmentRelation values
('S1','D2'),
('S2','D3'),
('S3','D4'),
('S4','D2'),
('S5','D1'),
('S6','D3'),
('S7','D5'),
('S8','D8'),
('S9','D4'),
('S10','D10');
Select * from StaffDepartmentRelation;

--- 7. Insert address table 
INSERT INTO dbo.Address 
VALUES (1, 'Apt 100', '29 Queesnberry St','Boston','Massachusetts', 02215, 'Y', DEFAULT, CURRENT_TIMESTAMP), 
(2, 'Apt 905', 'Parker Street','Boston','Massachusetts', 02215, 'Y', DEFAULT, CURRENT_TIMESTAMP), 
(3, 'Apt 507', 'Broadway','Cambridge','Massachusetts', 02142, 'Y', DEFAULT, CURRENT_TIMESTAMP), 
(4, 'Apt 1209', '207 South Washington','Naperville','Illinois', 60540, 'Y', DEFAULT, CURRENT_TIMESTAMP), 
(5, 'Apt 1108', 'North Michigan Avenue','Chicago','Illinois', 60601, 'Y', DEFAULT, CURRENT_TIMESTAMP), 
(6, 'Apt 2011', '1040 WAVERLY AVE','HoltsVille','New York', 00544, 'Y', DEFAULT, CURRENT_TIMESTAMP), 
(7, 'Apt 202', 'PO BOX 121','Haleiwa','Hawaii', 96712, 'Y', DEFAULT, CURRENT_TIMESTAMP), 
(8, 'Apt 308', 'PO BOX 200','Ambridge','Pennsylvania', 15003, 'Y', DEFAULT, CURRENT_TIMESTAMP), 
(9, 'Apt 404', 'GIUFFRIAS Street','Addis','Louisiana', 70710, 'Y', DEFAULT, CURRENT_TIMESTAMP), 
(10, 'Apt 908', '3340 Severn','Metairie','Louisiana', 02115, 'Y', DEFAULT, CURRENT_TIMESTAMP);
Select * from Address;

--- 8. Insert patient address relation table
INSERT INTO dbo.PatientAddressRelation
VALUES(1,1,1,DEFAULT, CURRENT_TIMESTAMP),
(2,2,2,DEFAULT, CURRENT_TIMESTAMP),
(3,3,3,DEFAULT, CURRENT_TIMESTAMP),
(4,4,4,DEFAULT, CURRENT_TIMESTAMP),
(5,5,5,DEFAULT, CURRENT_TIMESTAMP),
(6,6,6,DEFAULT, CURRENT_TIMESTAMP),
(7,7,7,DEFAULT, CURRENT_TIMESTAMP),
(8,8,8,DEFAULT, CURRENT_TIMESTAMP),
(9,9,9,DEFAULT, CURRENT_TIMESTAMP),
(10,10,10,DEFAULT, CURRENT_TIMESTAMP);
Select * from PatientAddressRelation;


--- 9. Insert staff address relation table 
INSERT INTO dbo.StaffAddressRelation
VALUES(10,1,'S1',DEFAULT, CURRENT_TIMESTAMP),
(11,2,'S2',DEFAULT, CURRENT_TIMESTAMP),
(12,3,'S3',DEFAULT, CURRENT_TIMESTAMP),
(13,4,'S4',DEFAULT, CURRENT_TIMESTAMP),
(14,5,'S5',DEFAULT, CURRENT_TIMESTAMP),
(15,6,'S6',DEFAULT, CURRENT_TIMESTAMP),
(16,7,'S7',DEFAULT, CURRENT_TIMESTAMP),
(17,8,'S8',DEFAULT, CURRENT_TIMESTAMP),
(18,9,'S9',DEFAULT, CURRENT_TIMESTAMP),
(19,10,'S10',DEFAULT, CURRENT_TIMESTAMP);
Select * from StaffAddressRelation;

--10. Insert PatientEncounter
INSERT dbo.PatientEncounter VALUES
('EID1','10', 'S1', DEFAULT, 'N', GETDATE()),
('EID2', '9', 'S2', DEFAULT, 'Y', GETDATE()),
('EID3', '8', 'S3', DEFAULT, 'N', GETDATE()),
('EID4', '7', 'S4', DEFAULT, 'Y', GETDATE()),
('EID5', '6', 'S5', DEFAULT, 'Y', GETDATE()),
('EID6', '5', 'S6', DEFAULT, 'N', GETDATE()),
('EID7', '4', 'S7', DEFAULT, 'Y', GETDATE()),
('EID8', '3', 'S8', DEFAULT, 'N', GETDATE()),
('EID9', '2', 'S9', DEFAULT, 'Y', GETDATE()),
('EID10','1','S10', DEFAULT, 'Y', GETDATE());
Select * from PatientEncounter;

--11. Insert InfrastructureType
Insert dbo.InfrastructureType VALUES
('IN1', 'IU1', 'Emergency Care'),
('IN2', 'IU2', 'Patient Care'),
('IN3', 'IU3', 'Physiotherapy'),
('IN4', 'IU4', 'Emergency Care'),
('IN5', 'IU5', 'Operation Unit'),
('IN6', 'IU6', 'ICU'),
('IN7', 'IU7', 'NICU'),
('IN8', 'IU8', 'Normal Care'),
('IN9', 'IU9', 'Children Care'),
('IN10', 'IU10','Neurology Unit');
Select * from InfrastructureType;

--12. Insert Infrastructure
INSERT INTO Infrastructure VALUES
('IU1','IN1',111,'N',25),
('IU2','IN2',222,'N', 35),
('IU3','IN3',333,'Y',45),
('IU4','IN4',444,'Y',25),
('IU5','IN7',555,'Y',35),
('IU6','IN8',666,'N',55),
('IU7','IN9',777,'Y',45),
('IU8','IN10',888,'Y',35),
('IU9','IN5',999,'N',25),
('IU10','IN8',101,'Y',15);
Select * from Infrastructure;

--13. Insert Patient Admission History

Insert dbo.PatientAdmissionHistory VALUES
('AID1', 'EID1', DEFAULT, '10-18-2010', 'IU1', DEFAULT, CURRENT_TIMESTAMP),
('AID2', 'EID2', DEFAULT, '08-20-2010', 'IU2', DEFAULT, CURRENT_TIMESTAMP),
('AID3', 'EID3', DEFAULT, '03-26-2012', 'IU3', DEFAULT, CURRENT_TIMESTAMP),
('AID4', 'EID4', DEFAULT, '09-23-2014', 'IU4', DEFAULT, CURRENT_TIMESTAMP),
('AID5', 'EID5', DEFAULT, '12-18-2012', 'IU5', DEFAULT, CURRENT_TIMESTAMP),
('AID6', 'EID6', DEFAULT, '08-14-2011', 'IU6', DEFAULT, CURRENT_TIMESTAMP),
('AID7', 'EID7', DEFAULT, '09-21-2011', 'IU7', DEFAULT, CURRENT_TIMESTAMP),
('AID8', 'EID8', DEFAULT, '06-15-2012', 'IU8', DEFAULT, CURRENT_TIMESTAMP),
('AID9', 'EID9', DEFAULT, '07-23-2011', 'IU9', DEFAULT, CURRENT_TIMESTAMP),
('AID10','EID10',DEFAULT, '06-16-2012', 'IU10',DEFAULT, CURRENT_TIMESTAMP);
Select * from PatientAdmissionHistory;

--14. Insert Vital Signs
INSERT INTO VitalSigns
VALUES('VS1',1,'EID1', '03-01-2022', 98.4, 88, 12,120),
('VS2',2,'EID2', '03-02-2022', 97.3, 120, 13,110),
('VS3',3,'EID3', '03-10-2022', 99.3 , 112, 14,88),
('VS4',1,'EID6', '03-05-2022', 100.4, 87, 17,145),
('VS5',2,'EID5', '03-06-2022', 101.5, 78, 20,56),
('VS6',4,'EID9', '03-07-2022', 102.3, 102, 13,79),
('VS7',7,'EID10', '03-13-2022', 101.1, 145, 17,115),
('VS8',6,'EID7', '03-15-2022', 97.5, 123, 18,98),
('VS9',1,'EID8', '03-16-2022', 99.0, 112, 10,49),
('VS10',8,'EID3', '03-21-2022', 100.6, 156, 19,88);
Select * from VitalSigns;

--15. Insert PatientAccounts
INSERT dbo.PatientAccounts VALUES
(101, '10', 'EID1','I10', DEFAULT, 50000.00, 'Credit Card'),
(102, '9', 'EID2','I1', DEFAULT, 25000.00, 'Credit Card'),
(103, '8', 'EID3','I9', DEFAULT, 45000.00, 'Cash'),
(104, '7', 'EID4','I2', DEFAULT, 14000.00, 'Credit Card'),
(105, '6', 'EID5','I8', DEFAULT, 56000.00, 'Credit Card'),
(106, '5', 'EID6','I3', DEFAULT, 87000.00, 'Credit Card'),
(107, '4', 'EID7','I7', DEFAULT, 57000.00, 'Cash'),
(108, '3', 'EID8','I4', DEFAULT, 98000.00, 'Credit Card'),
(109, '2', 'EID9','I6', DEFAULT, 34000.00, 'Credit Card'),
(110, '1','EID10','I5', DEFAULT, 45000.00, 'Credit Card');
Select * from PatientAccounts;

--16. Insert Laboratory Tests
INSERT INTO dbo.LaboratoryTests
VALUES('LT1', 'EID1','Ultrasound','completed', DEFAULT , CURRENT_TIMESTAMP),
('LT2','EID2','Kidney Function','ongoing', DEFAULT, CURRENT_TIMESTAMP),
('LT3','EID3','X-Ray','ongoing', DEFAULT, CURRENT_TIMESTAMP),
('LT4','EID5','Blood Test','completed', DEFAULT, CURRENT_TIMESTAMP),
('LT5','EID6','Cervical Biopsy','completed', DEFAULT, CURRENT_TIMESTAMP),
('LT6','EID4','Corneal Topogrphy','ongoing', DEFAULT, CURRENT_TIMESTAMP),
('LT7','EID7','Oral Health','completed', DEFAULT, CURRENT_TIMESTAMP),
('LT8','EID10','CBC','ongoing', DEFAULT, CURRENT_TIMESTAMP),
('LT9','EID9','Skin Allergy','completed', DEFAULT, CURRENT_TIMESTAMP),
('LT10','EID1','Heart Scan','ongoing', DEFAULT, CURRENT_TIMESTAMP);
Select * from LaboratoryTests;

--17. Insert Laboratory Reports
INSERT INTO dbo.LaboratoryReports
VALUES('LR1', 'LT1' ,'positive', '03-01-2022'),
('LR2','LT2','negative', '03-01-2022' ),
('LR3','LT3','positive', '03-03-2022'),
('LR4','LT4','negative', '03-31-2022'),
('LR5','LT5','positive', '03-06-2022'),
('LR6','LT6','positive', '03-21-2022'),
('LR7','LT7','negative', '03-11-2022'),
('LR8','LT8','negative', '03-09-2022'),
('LR9','LT9','positive', '03-10-2022'),
('LR10','LT10','negative', '03-22-2022');
Select * from LaboratoryReports;


--Views
--- CREATE A VIEW FOR DISPLAYING ROLE AND DEPARTMENT A STAFF BELONGS TO
CREATE OR ALTER VIEW StaffDepartmentDetails AS
SELECT S.StaffID, S.FirstName, S.LastName, S.Gender, R.RoleName,R.RoleDesc, D.DepartmentName
FROM DBO.STAFF S JOIN DBO.StaffDepartmentRelation SD ON (S.StaffID = SD.StaffID)
JOIN DBO.Department D ON (SD.DepartmentID = D.DepartmentID)
JOIN DBO.ROLE R ON (S.RoleID = R.RoleID);

SELECT * FROM StaffDepartmentDetails;


---CREATE A VIEW FOR DISPLAYING THE VARIOUS INFRASTRUCTURE UNITS USED DURING PATIENT ENCOUNTER
CREATE OR ALTER VIEW PatientInfraUsage AS
SELECT P.PatientID, P.FirstName, P.LastName, PE.EncounterDate, IT.InfraUnitDesc
FROM DBO.Patient P JOIN DBO.PatientEncounter PE ON (P.PatientID = PE.PatientID)
JOIN DBO.PatientAdmissionHistory PA ON (PA.EncounterID = PE.EncounterID)
JOIN DBO.Infrastructure I ON (I.InfraUnitID = PA.InfraUnitID)
JOIN DBO.InfrastructureType IT ON (IT.InfraTypeID = I.InfraTypeID);

SELECT * FROM PatientInfraUsage;


CREATE FUNCTION DBF_CalculateTotalWithTax(@AccountID int)
RETURNS MONEY
AS 
BEGIN
--In PatientAccounts table we have are creating a new column which will show the total amount with tax
	DECLARE @totalAmount MONEY = (
			SELECT (1.05 * CAST(TotalBill AS Money)) FROM PatientAccounts
			WHERE AccountID  = @AccountID 
	);
	SET @totalAmount = isnull(@totalAmount,0);
	RETURN @totalAmount;
End;

alter table PatientAccounts add	BillWithTax as (dbo.DBF_CalculateTax(AccountID));
Select * from PatientAccounts;


--TABLE LEVEL CHECK CONSTRAINT BASED ON FUNCTION

--Add a Constraint to not allow a patient with the same Name and phone Number to register
CREATE OR ALTER FUNCTION isPatientRegistered(@firstName VARCHAR(30), @lastName VARCHAR(30), @phoneNumber CHAR(10))
RETURNS INT
AS 
BEGIN
	DECLARE @COUNT AS INT

	SELECT @COUNT = COUNT(PatientID) FROM Patient
	WHERE FirstName = @firstName AND LastName = @lastName AND MobileNumber = @phoneNumber
	
	RETURN @COUNT
END

SELECT * FROM Patient

ALTER TABLE Patient WITH NOCHECK ADD CONSTRAINT checkPatientRegistered 
CHECK (dbo.isPatientRegistered(FirstName, LastName, MobileNumber) = 1)