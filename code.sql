-- 1. Create database WERENT
CREATE DATABASE werent;

USE werent;

-- 2. Create tables

-- (1) AGENCY
CREATE TABLE AGENCY(
	Agency_ID VARCHAR(10) PRIMARY KEY,				/* Agency ID */
	Agency_Name VARCHAR(35) NOT NULL,					/* Agency name */
	Agency_Address VARCHAR(45) NOT NULL,			/* Agency address */
	Agency_Contact CHAR(11) NOT NULL,					/* Agency Tel */
	Agency_Manager VARCHAR(25) NOT NULL,			/* Agency manager */
  Agency_Rating TINYINT(1) NOT NULL,				/* Agency rating */
	CHECK (Agency_Rating IN (0,1,2,3,4,5))
);

-- (2) COMMUNITY
CREATE TABLE COMMUNITY(
	Community_ID VARCHAR(10) PRIMARY KEY,			/* Community ID */
	Community_Name VARCHAR(35) NOT NULL,			/* Community name */
	Community_Address VARCHAR(45) NOT NULL,		/* Community address */
	Community_Age TINYINT NOT NULL,						/* Community age */
	Community_Rating TINYINT(1) NOT NULL,			/* Community rating */
	Is_Shop_Nearby TINYINT(1) NOT NULL,				/* Whether there are shops nearby */
	Is_Subway_Nearby TINYINT(1) NOT NULL,			/* Whether there is a metro station nearby */
	Is_School_Nearby TINYINT(1) NOT NULL,			/* Whether there is a school nearby */
	Is_Hospital_Nearby TINYINT(1) NOT NULL,		/* Whether there is a hospital nearby */
	Having_Parkinglot TINYINT(1) NOT NULL,		/* Having a parking lot or not */
	Having_Gym TINYINT(1) NOT NULL,						/* Having a gym or not */
	CHECK (Community_Age>=0 AND Community_Age<=99),
	CHECK (Community_Rating IN (0,1,2,3,4,5)),
	CHECK (Is_Shop_Nearby=0 OR Is_Shop_Nearby=1),
	CHECK (Is_Subway_Nearby=0 OR Is_Subway_Nearby=1),
	CHECK (Is_School_Nearby=0 OR Is_School_Nearby=1),
	CHECK (Is_Hospital_Nearby=0 OR Is_Hospital_Nearby=1),
	CHECK (Having_Parkinglot=0 OR Having_Parkinglot=1),
	CHECK (Having_Gym=0 OR Having_Gym=1)
);

-- (3) OWNERS
CREATE TABLE OWNERS(
	Owner_ID VARCHAR(10) PRIMARY KEY,					/* Owner ID */
	Owner_Name VARCHAR(35) NOT NULL,					/* Owner name */
	Owner_Gender CHAR(1) NOT NULL,						/* Owner gender */
	Owner_Contact CHAR(11) NOT NULL,					/* Owner Tel */
	CHECK (Owner_Gender='M' OR Owner_Gender='F')
);

-- (4) APARTMENT
CREATE TABLE APARTMENT(
	Apartment_ID VARCHAR(10) PRIMARY KEY,			/* Apartment ID */
	Owner_ID VARCHAR(10) NOT NULL,						/* Owner ID */
	Community_ID VARCHAR(10) NOT NULL,				/* Community ID */
	Agency_ID VARCHAR(10) NOT NULL,						/* Agency ID */
	Apartment_Area FLOAT(5,1) NOT NULL,				/* Apartment area */
	Apartment_Floor SMALLINT NOT NULL,				/* Apartment floor */
	Apartment_Type VARCHAR(35) NOT NULL,			/* Apartment type */
	Expected_Rent	INT NOT NULL,								/* Expected rent */
	Expected_Duration VARCHAR(10) NOT NULL,		/* Expected renting period(months) */	
	Having_Elevator TINYINT(1) NOT NULL,			/* Having elevators or not */
	Having_AC TINYINT(1) NOT NULL,						/* Having an AC or not */
	Having_TV TINYINT(1) NOT NULL,						/* Having a TV or not */
	Having_Washingmachine TINYINT(1) NOT NULL,/* Having a washing machine or not */
	Having_Kitchen TINYINT(1) NOT NULL,				/* Having a kitchen or not */
	Having_WiFi TINYINT(1) NOT NULL,					/* Having WiFi or not */
	Allow_Pet TINYINT(1) NOT NULL,						/* Whether pets are allowed */
	FOREIGN KEY (Owner_ID) REFERENCES OWNERS(Owner_ID),
	FOREIGN KEY (Community_ID) REFERENCES COMMUNITY(Community_ID),
	FOREIGN KEY (Agency_ID) REFERENCES Agency(Agency_ID),
	CHECK (Apartment_Area>=0.0 AND Apartment_Area<=999.0),
	CHECK (Apartment_Floor>=1 AND Apartment_Floor<=999),
	CHECK (Expected_Rent>=0 AND Expected_Rent<=99999),
	CHECK (Having_Elevator=0 OR Having_Elevator=1),
	CHECK (Having_AC=0 OR Having_AC=1),
	CHECK (Having_TV=0 OR Having_TV=1),
	CHECK (Having_Washingmachine=0 OR Having_Washingmachine=1),
	CHECK (Having_Kitchen=0 OR Having_Kitchen=1),
	CHECK (Having_WiFi=0 OR Having_WiFi=1),
	CHECK (Allow_Pet=0 OR Allow_Pet=1)
);

-- (5) TENANT
CREATE TABLE TENANT(
	Tenant_ID VARCHAR(10) PRIMARY KEY,				/* Tenant ID */
	Tenant_Name VARCHAR(50) NOT NULL,					/* Tenant name */
	Tenant_Gender CHAR(1),										/* Tenant gender */
	Tenant_Age TINYINT(8),										/* Tenant age */
	Tenant_Occupation VARCHAR(50),						/* Tenant occupation */
	Tenant_Institution VARCHAR(255),					/* Tenant institution */
	Tenant_Contact CHAR(11),									/* Tenant Tel */
	CHECK (Tenant_Age>=0 AND Tenant_Age<=255),
	CHECK (Tenant_Gender="M" OR Tenant_Gender="F")
);

-- (6) CONTRACT
CREATE TABLE CONTRACT(
	Contract_ID VARCHAR(10) PRIMARY KEY,			/* Contract ID */
	Apartment_ID VARCHAR(10) NOT NULL,				/* Apartment ID */
	Tenant_ID VARCHAR(10) NOT NULL,						/* Tenant ID */
	Rent INT NOT NULL,												/* Expected rent */
	Guarantee_Deposit INT NOT NULL,						/* Deposit */
	Agency_Fee INT NOT NULL,									/* Agency fee */
	Start_Date DATE NOT NULL,									/* Start date */
	End_Date DATE NOT NULL,										/* End date */
	Notes VARCHAR(200),												/* Other descriptions */	
	FOREIGN KEY (Apartment_ID) REFERENCES APARTMENT(Apartment_ID),
	FOREIGN KEY (Tenant_ID) REFERENCES TENANT(Tenant_ID),
	CHECK (Rent>=0 AND Rent<=99999),
	CHECK (Guarantee_Deposit>=0 AND Guarantee_Deposit<=99999),
	CHECK (Agency_Fee>=0 AND Agency_Fee<=99999)
);

-- (7) GROUPSS
CREATE TABLE GROUPSS(
	Group_ID VARCHAR(10) PRIMARY KEY,					/* Group ID */
	Apartment_ID VARCHAR(10) NOT NULL,				/* Apartment ID */
	Expire_Time DATE NOT NULL,								/* Expire time of the group */
	Group_Status CHAR(1) NOT NULL,						/* Group status (open, close or expire) */
	Current_Number TINYINT(4) NOT NULL,				/* Current number of tenants in the group */
	Tenant_Timetable VARCHAR(255),						/* Timetable of each tenant */
	Gender_Require CHAR(1) NOT NULL,					/* Gender requirement (male, female or either) */
	Accept_Pet TINYINT(1) NOT NULL,						/* Accept pet or not */
	Accept_Smoking TINYINT(1) NOT NULL,				/* Accept smoking or not */
	Accept_Alcohol TINYINT(1) NOT NULL,				/* Accept alcohol or not */
	Notes VARCHAR(255),												/* Other requirements */	
	FOREIGN KEY (Apartment_ID) REFERENCES APARTMENT(Apartment_ID),
	CHECK (Group_Status='O' OR Group_Status='C' OR Group_Status='E'),
	CHECK (Current_Number>=0 AND Current_Number<=15),
	CHECK (Gender_Require='M' OR Gender_Require='F' OR Gender_Require='E'),
	CHECK (Accept_Pet=0 OR Accept_Pet=1),
	CHECK (Accept_Smoking=0 OR Accept_Smoking=1),
	CHECK (Accept_Alcohol=0 OR Accept_Alcohol=1)
);

-- (8) ENROLLMENT
CREATE TABLE ENROLLMENT(
	Group_ID VARCHAR(10) NOT NULL,						/* Group ID */
	Tenant_ID VARCHAR(10) NOT NULL,						/* Tenant ID */
	Enrollment_Time DATETIME NOT NULL,				/* Time of enrollment in the group */
	Is_GroupLeader TINYINT(1) NOT NULL,				/* Whether the tenant is group leader */
	PRIMARY KEY (Group_ID, Tenant_ID),
	FOREIGN KEY (Group_ID) REFERENCES GROUPSS(Group_ID),
	FOREIGN KEY (Tenant_ID) REFERENCES TENANT(Tenant_ID),
	CHECK (Is_GroupLeader=0 OR Is_GroupLeader=1)
);

-- (9) COMMENTS
CREATE TABLE COMMENTS(
	Tenant_ID VARCHAR(10) NOT NULL,						/* Tenant ID */
	Apartment_ID VARCHAR(10) NOT NULL,				/* Apartment ID */
	Description VARCHAR(255) NOT NULL,				/* Content of comment */
	Rating TINYINT(3) NOT NULL,								/* Rating (1-5) */
	Comment_Time DATETIME NOT NULL,						/* Time of comment */
	PRIMARY KEY (Tenant_ID, Apartment_ID),
	FOREIGN KEY (Tenant_ID) REFERENCES TENANT(Tenant_ID),
	FOREIGN KEY (Apartment_ID) REFERENCES APARTMENT(Apartment_ID),
	CHECK (Rating IN (0,1,2,3,4,5))
);

-- (10) COLLECTION
CREATE TABLE COLLECTION(
	Tenant_ID VARCHAR(10) NOT NULL,						/* Tenant ID */
	Apartment_ID VARCHAR(10) NOT NULL,				/* Apartment ID */
	Notes VARCHAR(255),												/* Remark about the apartment */
	Collection_Time DATETIME NOT NULL,				/* Time of collection */
	PRIMARY KEY (Tenant_ID, Apartment_ID),
	FOREIGN KEY (Tenant_ID) REFERENCES TENANT(Tenant_ID),
	FOREIGN KEY (Apartment_ID) REFERENCES APARTMENT(Apartment_ID)
);

-- (11) BROWSING_RECORD
CREATE TABLE BROWSING_RECORD(
	Tenant_ID VARCHAR(10) NOT NULL,						/* Tenant ID */
	Apartment_ID VARCHAR(10) NOT NULL,				/* Apartment ID */
	Browsing_Time DATETIME NOT NULL,					/* Time of browsing */
	PRIMARY KEY (Tenant_ID, Apartment_ID),
	FOREIGN KEY (Tenant_ID) REFERENCES TENANT(Tenant_ID),
	FOREIGN KEY (Apartment_ID) REFERENCES APARTMENT(Apartment_ID)
);

-- 3. Insert Data

-- (1) COMMUNITY
INSERT INTO COMMUNITY VALUES
('2210000001', 'Cobble', '406 Sip Ave, Jersey City, NJ 07306, US', 8, 1, 1, 0, 1, 0, 0, 0),
('2210000002', 'Brooklyn', '823 West Side Ave, Jersey City, NJ 07306, US', 1, 4, 1, 0, 1, 0, 0, 1),
('2210000003', 'Boerum', '393 Danforth Ave, Jersey City, NJ 07305, US', 10, 4, 1, 1, 1, 0, 0, 1),
('2210000004', 'Williamsburg', '6 A Rose Ave, Jersey City, NJ 07305, US', 17, 5, 1, 1, 1, 1, 1, 1),
('2210000005', 'Greenpoint', '701 NJ-440, Jersey City, NJ 07304, US', 32, 2, 0, 1, 1, 1, 0, 1),
('2210000006', 'McCarren', '215 Centre St, New York, NY 10013, US', 21, 5, 1, 1, 1, 1, 1, 0),
('2210000007', 'Domino', '285 Fulton St, New York, NY 10007, US', 12, 3, 1, 1, 1, 0, 0, 1),
('2210000008', 'Bridge', '54 Watts St, New York, NY 10013, US', 39, 2, 1, 0, 0, 0, 0, 1),
('2210000009', 'Color Factory', '35 Downing St, New York, NY 10014, US', 5, 0, 1, 0, 1, 0, 0, 0),
('2210000010', 'Jersey', '53 Christopher St, New York, NY 10014, US', 26, 3, 0, 1, 1, 0, 0, 1),
('2210000011', 'Le Bain', '114 Christopher St, New York, NY 10014, US', 18, 4, 0, 1, 1, 1, 0, 1);

-- (2) AGENCY
INSERT INTO AGENCY VALUES
('3450000001', 'Airbnb', '20 W 34th St, New York, NY 10001', '12226507000', 'June', 3),
('3450000002', 'Tent', '99 Gansevoort St, New York, NY 10014', '12136507000','Karen',3),
('3450000003','Star', '558 Broadway, New York, NY 10012','12127507000','Karida',3),
('3450000004','Sunbelt','Lincoln Center Plaza, New York, NY 10023','12126607000','Kathy',2),
('3450000005','Herc','1220 5th Ave, New York, NY 10029','12126517000','Laura',4),
('3450000006','United','234 E 149th St, Bronx, NY 10451','12126508000','Mayme',4),
('3450000007','Ahern','55 E 122nd St, New York, NY 10035','12126507100','Vincent',2),
('3450000008','Sunstate','1047 Amsterdam Ave, New York, NY 10025','12126507010','Warren',4),
('3450000009','HE','W 122nd St &, Riverside Dr, New York, 10027','12126507001','Wesley',5),
('3450000010','Briggs','160 Convent Ave, New York, NY 10031', '12126507000','Timothy',4);

-- (3) OWNERS
INSERT INTO OWNERS VALUES
('1110000001', 'Kris', 'M', '11112345678'),
('1110000002', 'Crystal', 'M', '11102938475'),
('1110000003', 'Cook', 'F', '11184930293'),
('1110000004', 'Anna', 'M', '11148390847'),
('1110000005', 'Scott', 'F', '11129304938'), 
('1110000006', 'Mengchu', 'M', '11102930495'), 
('1110000007', 'Mare', 'M', '11109248738'), 
('1110000008', 'Longman', 'F', '11109304893'), 
('1110000009', 'Zoe', 'M', '11102930493'), 
('1110000010', 'Rose', 'M', '11102930493');

-- (4) APARTMENT
INSERT INTO APARTMENT(Apartment_ID, Owner_ID, Community_ID, Agency_ID, 
Apartment_Area, Apartment_Floor, Apartment_Type, Expected_Rent, Expected_Duration,
Having_Elevator, Having_AC, Having_TV, Having_Washingmachine, Having_Kitchen, Having_WiFi, Allow_Pet) VALUES
('9960000001', '1110000001', '2210000001', '3450000001', 23, 2, '1B1B', 2500, '12~24', 0, 1, 0, 1, 0, 0, 0),
('9960000002', '1110000001', '2210000001', '3450000002', 28, 3, '1B1B', 3500, '01~06', 0, 1, 0, 1, 0, 0, 0),
('9960000003', '1110000001', '2210000001', '3450000002', 25, 4, '1B1B', 2800, '12~24', 0, 1, 0, 1, 0, 0, 0),
('9960000004', '1110000002', '2210000001', '3450000002', 26, 5, '1B1B', 2750, '12~24', 0, 1, 0, 1, 0, 0, 0),
('9960000005', '1110000002', '2210000001', '3450000002', 30, 6, '1B1B', 3000, '12~24', 1, 1, 0, 1, 0, 0, 0),
('9960000006', '1110000002', '2210000001', '3450000003', 25, 7, '1B1B', 2800, '12~24', 1, 1, 0, 1, 0, 0, 0),
('9960000007', '1110000002', '2210000002', '3450000003', 25, 8, '1B1B', 2500, '12~24', 1, 1, 0, 1, 0, 0, 0),
('9960000008', '1110000002', '2210000003', '3450000004', 30, 2, '1B1B', 2200, '12~24', 0, 1, 0, 1, 0, 0, 0),
('9960000009', '1110000003', '2210000004', '3450000004', 30, 2, '1B1B', 2500, '01~12', 0, 1, 0, 1, 0, 0, 1),
('9960000010', '1110000003', '2210000005', '3450000005', 48, 2, '1B1B', 3800, '01~24', 0, 1, 0, 1, 0, 1, 0),
('9960000011', '1110000004', '2210000002', '3450000006', 26, 2, '2B1B', 2500, '12~24', 0, 1, 0, 1, 0, 0, 0),
('9960000012', '1110000005', '2210000003', '3450000006', 56, 2, '2B1B', 2500, '12~24', 0, 1, 0, 1, 0, 0, 0),
('9960000013', '1110000005', '2210000003', '3450000006', 56, 2, '2B1B', 2500, '12~24', 0, 1, 0, 1, 0, 1, 0),
('9960000014', '1110000006', '2210000005', '3450000006', 56, 3, '2B1B', 2500, '12~24', 1, 1, 0, 1, 0, 1, 0),
('9960000015', '1110000007', '2210000006', '3450000006', 56, 3, '2B1B', 5800, '12~24', 1, 1, 0, 1, 1, 1, 0),
('9960000016', '1110000008', '2210000007', '3450000007', 60, 4, '2B1B', 5200, '12~24', 1, 1, 1, 1, 1, 1, 0),
('9960000017', '1110000009', '2210000008', '3450000008', 60, 5, '2B1B', 4800, '12~24', 1, 1, 1, 1, 1, 1, 0),
('9960000018', '1110000009', '2210000009', '3450000009', 60, 6, '2B1B', 6000, '01~06', 1, 1, 1, 1, 1, 1, 1),
('9960000019', '1110000010', '2210000010', '3450000010', 84, 2, '3B1B', 7500, '12~24', 0, 1, 1, 1, 1, 1, 0),
('9960000020', '1110000010', '2210000011', '3450000010', 90, 2, '3B1B', 8000, '01~06', 0, 1, 1, 1, 1, 1, 1);

-- (5) GROUPSS
INSERT INTO GROUPSS(Group_ID, Apartment_ID, Expire_time, Group_status,
Current_Number, Tenant_Timetable, Gender_Require, Accept_Pet,
Accept_Smoking, Accept_Alcohol, Notes) VALUES
( "5550000001", "9960000011", 20241205, "O", 3, "GET UP: 07:00 SLEEP: 23:00", "E", 1, 0, 0, "hello"),
( "5550000002", "9960000011", 20240305, "O", 1, "GET UP: 07:00 SLEEP: 23:00", "E", 0, 1, 1, "welcome juanwang"),
( "5550000003", "9960000012", 20240106, "O", 3, "GET UP: 07:00 SLEEP: 23:00", "E", 1, 0, 1, "996"),
( "5550000004", "9960000001", 20240922, "C", 2, "GET UP: 06:30 SLEEP: 23:30", "E", 0, 1, 0, "High school students"),
( "5550000005", "9960000002", 20240614, "C", 2, "GET UP: 13:00 SLEEP: 22:00", "E", 1, 1, 0, "undergraduate students"),
( "5550000006", "9960000003", 20240823, "C", 2, "GET UP: 12:00 SLEEP: 04:00", "E", 1, 1, 1, ""),
( "5550000007", "9960000004", 20240102, "C", 2, "GET UP: 07:00 SLEEP: 00:00", "E", 0, 0, 0, ""),
( "5550000008", "9960000005", 20240228, "C", 2, "GET UP: 09:00 SLEEP: 01:00", "E", 1, 1, 0, ""),
( "5550000009", "9960000006", 20240131, "C", 3, "", "E", 1, 1, 1, "graduate students"),
( "5550000010", "9960000007", 20240718, "C", 3, "GET UP: 05:00 SLEEP: 21:00", "E", 1, 0, 1, ""),
( "5550000011", "9960000008", 20240906, "C", 3, "GET UP: 07:00 SLEEP: 03:00", "E", 0, 1, 1, ""),
( "5550000012", "9960000009", 20241103, "C", 3, "GET UP: 11:00 SLEEP: 03:00", "E", 1, 1, 0, ""),
( "5550000013", "9960000010", 20241213, "C", 3, "GET UP: 12:00 SLEEP: 05:00", "E", 1, 0, 1, "graduate students"),
( "5550000014", "9960000013", 20241002, "E", 0, "GET UP: 19:00 SLEEP: 11:00", "E", 0, 0, 1, "Night shift");

-- (6) TENANT
INSERT INTO tenant(Tenant_ID, Tenant_Name, Tenant_Gender, Tenant_Age, Tenant_Occupation, Tenant_Institution, Tenant_Contact)
VALUES
('1010000001', 'Alex', 'M', 32, 'Programmer', 'Apple Inc.', '23126451209'),
('1010000002', 'Arthur', 'M', 23, 'Student', 'Columbia University', '13113454417'),
('1010000003', 'Bill', 'M', 24, 'Student', 'New York University', '14459013412'),
('1010000004', 'Brian', 'M', 19, 'Student', 'Fordham University', '18124567224'),
('1010000005', 'Gino', 'M', 20, 'Student', 'New York University', '23901315206'),
('1010000006', 'Henry', 'M', 21, 'Student', 'Fordham University', '19803260659'),
('1010000007', 'Simon', 'M', 22, 'Student', 'New York University', '27509981124'),
('1010000008', 'Kevin', 'M', 26, 'Doctor', 'Presbyterian Hospital', '22788295994'),
('1010000009', 'Peter', 'M', 25, 'Student', 'Fordham University', '25864490260'),
('1010000010', 'Alice', 'F', 28, 'Server', 'Hilton Hotel', '28879584636'),
('1010000011', 'Max', 'F', 21, 'Student', 'Pace University', '11982330375'),
('1010000012', 'Amy', 'F', 23, 'Student', 'Columbia University', '12995486767'),
('1010000013', 'Esther', 'F', 22, 'Student', 'New York University', '13926886997'),
('1010000014', 'Carrie', 'F', 24, 'Student', 'New York University', '17169999571'),
('1010000015', 'Jill', 'F', 19, 'Student', 'Columbia University', '25258547193'),
('1010000016', 'Jessie', 'F', 24, 'Student', 'Fordham University', '19243349561'),
('1010000017', 'Eva', 'F', 26, 'Driver', 'Uber Inc.', '25773236146'),
('1010000018', 'Susan', 'F', 25, 'Student', 'Columbia University', '11092233304'),
('1010000019', 'Paula', 'F', 24, 'Student', 'New York University', '13855128703'),
('1010000020', 'Maggie', 'F', 25, 'Bank Clerk', 'Bank of New York', '19770311328'),
('1010000021', 'Tom', 'M', 25, 'Bank Clerk', 'Bank of New York', '18734311328'),
('1010000022', 'Jerry', 'M', 31, 'Bank Clerk', 'Bank of New York', '11170311328'),
('1010000023', 'Mickey', 'M', 26, 'Bank Clerk', 'Bank of New York', '19450361328'),
('1010000024', 'Bob', 'M', 35, 'Bank Clerk', 'Bank of New York', '25640311328'),
('1010000025', 'Jack', 'M', 52, 'Manager', 'Alibaba Inc.', '19720315328'),
('1010000026', 'Sally', 'F', 21, 'Student', 'University of Washionton', '17384657283'),
('1010000027', 'Kitty', 'F', 19, 'Student', 'University of Washionton', '17728374859'),
('1010000028', 'Bonny', 'F', 18, 'Student', 'University of Washionton', '28394857222'),
('1010000029', 'April', 'F', 25, 'Programmer', 'Facebook Inc.', '18217418321'),
('1010000030', 'Carol', 'F', 41, 'Manager', 'Huawei Inc.', '11234850321');

-- (7) ENROLLMENT
INSERT INTO ENROLLMENT(Group_ID, Tenant_ID, Enrollment_time, Is_GroupLeader) VALUES
('5550000001', '1010000026', '2021-06-01', 1),
('5550000001', '1010000030', '2021-06-22', 0),
('5550000001', '1010000029', '2021-06-28', 0),
('5550000002', '1010000028', '2021-06-02', 1),
('5550000003', '1010000027', '2021-06-02', 1),
('5550000003', '1010000026', '2021-06-14', 0),
('5550000003', '1010000029', '2021-06-28', 0),
('5550000004', '1010000001', '2021-06-04', 1),
('5550000004', '1010000002', '2021-06-24', 0),
('5550000005', '1010000003', '2021-06-01', 1),
('5550000005', '1010000004', '2021-06-02', 0),
('5550000006', '1010000005', '2021-06-07', 1),
('5550000006', '1010000006', '2021-06-09', 0),
('5550000007', '1010000007', '2021-06-03', 1),
('5550000007', '1010000008', '2021-06-11', 0),
('5550000008', '1010000009', '2021-06-06', 1),
('5550000008', '1010000010', '2021-06-08', 0),
('5550000009', '1010000011', '2021-06-11', 1),
('5550000009', '1010000012', '2021-06-13', 0),
('5550000009', '1010000013', '2021-06-30', 0),
('5550000010', '1010000014', '2021-06-01', 1),
('5550000010', '1010000015', '2021-06-21', 0),
('5550000010', '1010000016', '2021-06-22', 0),
('5550000011', '1010000017', '2021-06-01', 1),
('5550000011', '1010000018', '2021-06-11', 0),
('5550000011', '1010000019', '2021-06-21', 0),
('5550000012', '1010000020', '2021-06-02', 1),
('5550000012', '1010000021', '2021-06-22', 0),
('5550000012', '1010000022', '2021-06-27', 0),
('5550000013', '1010000023', '2021-06-24', 1),
('5550000013', '1010000024', '2021-06-25', 0),
('5550000013', '1010000025', '2021-06-29', 0),
('5550000014', '1010000030', '2021-06-01', 1);

-- (8) CONTRACT
INSERT INTO contract(Contract_ID, Apartment_ID, Tenant_ID, Rent,
Guarantee_Deposit, Agency_Fee, Start_Date, End_Date, Notes) VALUES
('4860000001', '9960000001', '1010000001',2500,5000,1250,20210701,20220701,'No house renovation allowed'),
('4860000002','9960000002','1010000003',3500,7000,1750,20210704,20220704,'No pets allowed'),
('4860000003','9960000003','1010000005',2800,5600,1400,20210824,20220824,''),
('4860000004','9960000004','1010000007',2700,5400,1350,20210702,20220102,'No smoking'),
('4860000005','9960000005','1010000009',3000,6000,1500,20210805,20220205,''),
('4860000006','9960000006','1010000011',2800,5600,1400,20210728,20220728,'No pets allowed'),
('4860000007','9960000007','1010000014',2500,5000,1250,20210801,20220801,''),
('4860000008','9960000008','1010000017',2000,4000,1000,20210812,20220812,''),
('4860000009','9960000009','1010000020',2500,5000,1250,20210731,20220131,'No house renovation allowed'),
('4860000010','9960000010','1010000023',3800,7600,1900,20210831,20220831,'No smoking');

-- (9) COMMENTS
INSERT INTO comments (Tenant_ID, Apartment_ID, Description, Rating, Comment_Time) VALUES
('1010000001','9960000001','Overall satisfaction',4,20211205160000),
('1010000002','9960000001','',4,20210903110000),
('1010000003','9960000002','Poor attitude of house owner',2,20210930080000),
('1010000004','9960000002','',2,20210916100000),
('1010000005','9960000003','',3,20210907180000),
('1010000006','9960000003','',3,20211001160000),
('1010000007','9960000004','Over,all satisfaction',4,20211209080000),
('1010000008','9960000004','',4,20211111100000),
('1010000009','9960000005','Too much noise',1,20211101110000),
('1010000010','9960000005','Too much noise',1,20211130140000),
('1010000011','9960000006','Clean and neat',5,20211009160000),
('1010000013','9960000006','',4,20211021160000),
('1010000014','9960000007','Water leakage in the bathroom',2,20210927130000),
('1010000015','9960000007','Water leakage in the bathroom',2,20211204070000),
('1010000017','9960000008','The house owner is nice',5,20211120050000),
('1010000018','9960000008','',4,20211207170000),
('1010000020','9960000009','',3,20210905120000),
('1010000021','9960000009','Old furniture',3,20211117210000),
('1010000023','9960000010','Overall satisfaction',4,20211025150000),
('1010000025','9960000010','Overall satisfaction',5,20211116220000);

-- (10) COLLECTION
INSERT INTO COLLECTION(Tenant_ID, Apartment_ID, Notes, Collection_Time) VALUES
('1010000001', '9960000001', 'Love','2021-04-17'),
('1010000002', '9960000001', 'Love', '2021-04-24'),
('1010000003', '9960000002', 'Love', '2021-04-24'),
('1010000004', '9960000002', 'To be considered','2021-04-25'),
('1010000005', '9960000003', NULL, '2021-04-25'),
('1010000006', '9960000003', NULL, '2021-05-22'),
('1010000007', '9960000004', NULL, '2021-05-22'),
('1010000008', '9960000004', NULL, '2021-05-23'),
('1010000009', '9960000005', 'Love', '2021-04-17'),
('1010000010', '9960000005', NULL, '2021-05-15'),
('1010000011', '9960000006', 'Love', '2021-05-22'),
('1010000012', '9960000006', 'To be considered', '2021-05-29'),
('1010000013', '9960000006', NULL, '2021-05-23'),
('1010000014', '9960000007', NULL, '2021-05-16'),
('1010000015', '9960000007', NULL, '2021-05-29'),
('1010000016', '9960000007', NULL, '2021-05-29'),
('1010000017', '9960000008', 'Love', '2021-05-23'),
('1010000018', '9960000008', NULL, '2021-05-29'),
('1010000019', '9960000008', NULL, '2021-05-30'),
('1010000020', '9960000009', 'Love', '2021-05-22'),
('1010000021', '9960000009', 'To be considered', '2021-05-29'),
('1010000022', '9960000009', 'Love', '2021-05-30'),
('1010000023', '9960000010', NULL, '2021-05-23'),
('1010000024', '9960000001', 'Love', '2021-05-29'),
('1010000024', '9960000002', 'To be considered', '2021-05-29'),
('1010000025', '9960000003', NULL, '2021-05-30'),
('1010000026', '9960000004', NULL, '2021-05-30'),
('1010000027', '9960000005', NULL, '2021-05-29'),
('1010000028', '9960000006', NULL, '2021-05-30'),
('1010000028', '9960000007', NULL, '2021-05-30');

-- (11) BROWSING_RECORD
INSERT INTO BROWSING_RECORD(Tenant_ID, Apartment_ID, Browsing_Time) VALUES
('1010000001', '9960000001', '2021-04-17'),
('1010000001', '9960000002', '2021-04-17'),
('1010000001', '9960000003', '2021-04-17'),
('1010000001', '9960000004', '2021-04-17'),
('1010000001', '9960000005', '2021-04-17'),
('1010000002', '9960000001', '2021-04-24'),
('1010000002', '9960000002', '2021-04-24'),
('1010000002', '9960000003', '2021-04-24'),
('1010000002', '9960000004', '2021-04-24'),
('1010000002', '9960000005', '2021-04-24'),
('1010000002', '9960000006', '2021-04-24'),
('1010000002', '9960000007', '2021-04-24'),
('1010000003', '9960000001', '2021-04-24'),
('1010000003', '9960000002', '2021-04-24'),
('1010000004', '9960000001', '2021-04-25'),
('1010000004', '9960000002', '2021-04-25'),
('1010000004', '9960000003', '2021-04-25'),
('1010000005', '9960000003', '2021-04-25'),
('1010000005', '9960000005', '2021-04-25'),
('1010000005', '9960000007', '2021-04-25'),
('1010000006', '9960000003', '2021-05-22'),
('1010000006', '9960000007', '2021-05-22'),
('1010000006', '9960000009', '2021-05-22'),
('1010000007', '9960000004', '2021-05-22'),
('1010000007', '9960000005', '2021-05-22'),
('1010000008', '9960000004', '2021-05-23'),
('1010000009', '9960000005', '2021-04-17'),
('1010000010', '9960000005', '2021-05-15'),
('1010000011', '9960000006', '2021-05-22'),
('1010000011', '9960000008', '2021-05-23'),
('1010000012', '9960000006', '2021-05-29'),
('1010000013', '9960000006', '2021-05-23'),
('1010000014', '9960000005', '2021-05-15'),
('1010000014', '9960000006', '2021-05-16'),
('1010000014', '9960000007', '2021-05-16'),
('1010000015', '9960000007', '2021-05-29'),
('1010000016', '9960000007', '2021-05-29'),
('1010000017', '9960000008', '2021-05-23'),
('1010000018', '9960000008', '2021-05-29'),
('1010000019', '9960000008', '2021-05-30'),
('1010000011', '9960000010', '2021-05-30'),
('1010000020', '9960000007', '2021-05-15'),
('1010000020', '9960000008', '2021-05-15'),
('1010000020', '9960000009', '2021-05-22'),
('1010000021', '9960000009', '2021-05-29'),
('1010000022', '9960000009', '2021-05-30'),
('1010000023', '9960000001', '2021-04-25'),
('1010000023', '9960000002', '2021-04-25'),
('1010000023', '9960000010', '2021-05-23'),
('1010000024', '9960000001', '2021-05-29'),
('1010000024', '9960000002', '2021-05-29'),
('1010000025', '9960000003', '2021-05-30'),
('1010000026', '9960000004', '2021-05-30'),
('1010000027', '9960000005', '2021-05-29'),
('1010000027', '9960000015', '2021-05-30'),
('1010000028', '9960000006', '2021-05-30'),
('1010000028', '9960000007', '2021-05-30'),
('1010000029', '9960000016', '2021-05-30'),
('1010000029', '9960000017', '2021-05-30'),
('1010000030', '9960000018', '2021-05-22');

-- 4. Query

-- (1) homepage

-- (1.1) big name
SELECT * FROM APARTMENT
WHERE Agency_ID IN (SELECT Agency_ID FROM AGENCY WHERE Agency_Rating>=4);

-- (1.2) city
SELECT * FROM APARTMENT 
WHERE Community_ID IN
(SELECT Community_ID FROM
(SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(Community_Address, ',', 2), ', ', -1) AS City, Community_ID 
FROM COMMUNITY HAVING City = 'New York') AS city_community);

-- (1.3) district 
SELECT * FROM APARTMENT 
WHERE Community_ID IN
(SELECT Community_ID FROM 
(SELECT LEFT(SUBSTRING_INDEX(Community_Address, ', ', -2), 8) AS dist, Community_ID
FROM COMMUNITY HAVING dist = 'NJ 07306') AS dist_community);

-- (1.4) community name
SELECT * FROM APARTMENT
WHERE Community_ID IN
(SELECT Community_ID FROM community WHERE Community_Name LIKE 'Co%');

-- (1.5) rent 
SELECT * FROM APARTMENT WHERE Expected_Rent >= 2800 AND Expected_Rent <= 3000;

-- (1.6) type
SELECT * FROM APARTMENT WHERE Apartment_Type = '1B1B';

-- (1.7) order by
SELECT * FROM APARTMENT ORDER BY Expected_Rent;

-- (2) apartment details

-- (2.1) browsing record
INSERT INTO BROWSING_RECORD(Tenant_ID, Apartment_ID, Browsing_Time) 
VALUES ('1010000001', '9960000015', NOW());

# DELETE FROM BROWSING_RECORD WHERE Tenant_ID='1010000001' AND Apartment_ID='9960000015';

-- (2.2) collection
INSERT INTO COLLECTION(Tenant_ID, Apartment_ID, Notes, Collection_Time) 
VALUES ('1010000001', '9960000015', '', NOW());

# DELETE FROM COLLECTION WHERE Tenant_ID='1010000001' AND Apartment_ID='9960000015';

-- (2.3) comments
INSERT INTO COMMENTS(Tenant_ID, Apartment_ID, Description, Rating, Comment_Time)
VALUES ('1010000001', '9960000015', 'Good!', 5, NOW());

# DELETE FROM COMMENTS WHERE Tenant_ID='1010000001' AND Apartment_ID='9960000015';

-- (2.4) owner
DELIMITER $
DROP PROCEDURE IF EXISTS OWNER_QUERY$
CREATE PROCEDURE OWNER_QUERY(IN a_id VARCHAR(10))
	BEGIN
		SELECT Owner_ID FROM APARTMENT WHERE Apartment_ID=a_id;
	END $
DELIMITER ;
CALL OWNER_QUERY('9960000015');

# SELECT Owner_ID FROM APARTMENT WHERE Apartment_ID='9960000015';

-- (2.5) group
DELIMITER $
DROP PROCEDURE IF EXISTS GROUP_QUERY$
CREATE PROCEDURE GROUP_QUERY(IN a_id VARCHAR(10))
	BEGIN
		SELECT Group_ID FROM GROUPSS WHERE Apartment_ID=a_id AND Group_Status='O';
	END $
DELIMITER ;
CALL GROUP_QUERY('9960000011');

# SELECT Group_ID FROM GROUPSS WHERE Apartment_ID='9960000011' AND Group_Status='O';

-- (2.6) apartment in the same community 
DELIMITER $
DROP PROCEDURE IF EXISTS APARTMENT_NEARBY_QUERY$
CREATE PROCEDURE APARTMENT_NEARBY_QUERY(IN a_id VARCHAR(10))
	BEGIN
		SELECT * FROM APARTMENT WHERE Community_ID=
		(SELECT Community_ID FROM APARTMENT WHERE Apartment_ID=a_id) AND
		Apartment_ID!=a_id;
	END $
DELIMITER ;
CALL APARTMENT_NEARBY_QUERY('9960000012');

# SELECT * FROM APARTMENT WHERE Community_ID=(SELECT Community_ID FROM APARTMENT WHERE Apartment_ID='9960000012') AND Apartment_ID!='9960000012';

-- (3) group

-- (3.1) select group (status, number of people, gender)
SELECT * FROM GROUPSS WHERE Apartment_ID='9960000011' AND Group_Status='O' AND Gender_Require="E";
-- SELECT * FROM GROUPSS WHERE Group_Status='O';

-- (3.2) order by

-- 	(3.2.1) order by expire time descendingly
SELECT * FROM GROUPSS WHERE Apartment_ID='9960000011' AND Group_Status='O' ORDER BY Expire_Time DESC; 
-- SELECT * FROM GROUPSS WHERE Group_Status='O' ORDER BY Expire_Time DESC;

--  (3.2.2) order by current number descendingly
SELECT * FROM GROUPSS WHERE Apartment_ID='9960000011' AND Group_Status='O' ORDER BY Current_Number DESC; 
-- SELECT * FROM GROUPSS WHERE Group_Status='O' ORDER BY Current_Number DESC;

--  (3.2.3) order by Group_ID
SELECT * FROM GROUPSS WHERE Apartment_ID='9960000011' AND Group_Status='O' ORDER BY Group_ID;  
-- SELECT * FROM GROUPSS WHERE Group_Status='O' ORDER BY Group_ID;

-- (3.3) select group (Group_ID)
SELECT * FROM GROUPSS WHERE Apartment_ID='9960000012' and Group_ID="5550000003";

/* trigger: increase current number of group */
DELIMITER $
DROP TRIGGER IF EXISTS INCREASE_CURRENT_NUMBER$
CREATE TRIGGER INCREASE_CURRENT_NUMBER
	AFTER INSERT ON ENROLLMENT
	FOR EACH ROW
	BEGIN
		UPDATE GROUPSS SET Current_Number=Current_Number+1 WHERE Group_ID=new.Group_ID;
	END	$
DELIMITER ;

-- (3.4) join group
SELECT * FROM ENROLLMENT;
SELECT * FROM GROUPSS;
INSERT INTO ENROLLMENT(Group_ID, Tenant_ID, Enrollment_time, Is_GroupLeader)
VALUES
('5550000003', '1010000028', '2021-06-30', 0);
SELECT * FROM ENROLLMENT;
SELECT * FROM GROUPSS;
DELETE FROM ENROLLMENT WHERE Group_ID = '5550000003' AND Tenant_ID = '1010000028';
-- (3.5) create group
SELECT * FROM GROUPSS;
SELECT * FROM ENROLLMENT;
INSERT INTO GROUPSS(Group_ID, Apartment_ID, Expire_time, Group_status,
 					   Current_Number, Tenant_Timetable, Gender_Require, Accept_Pet,
                     Accept_Smoking, Accept_Alcohol, Notes)
VALUES
('5550000023', '9960000011', '2025-12-05', 'O', 0, 'GET UP: 07:00 SLEEP: 23:00', 'E', 1, 0, 0, 'hello, welcome to join me');
INSERT INTO ENROLLMENT(Group_ID, Tenant_ID, Enrollment_time, Is_GroupLeader)
VALUES
('5550000023', '1010000026', '2021-06-01', 1);
SELECT * FROM GROUPSS;
SELECT * FROM ENROLLMENT;
-- DELETE FROM enrollment WHERE Group_ID='5550000023' AND Tenant_ID='1010000026'; 
-- DELETE FROM GROUPSS WHERE Group_ID='5550000023';

-- (4) group details

-- (4.1) sign contract
INSERT INTO CONTRACT VALUES
('4860000001', '9960000001', '1010000001',2500,5000,1250,20210701,20220701,'No house renovation allowed');

-- (4.2) quit group

/* trigger: decrease current number of group */
DELIMITER $
DROP TRIGGER IF EXISTS DECREASE_CURRENT_NUMBER$
CREATE TRIGGER DECREASE_CURRENT_NUMBER
	BEFORE DELETE ON ENROLLMENT
	FOR EACH ROW
	BEGIN
		UPDATE GROUPSS SET Current_Number=Current_Number-1 WHERE Group_ID=old.Group_ID;
	END $
DELIMITER ;

/* trigger: change group status */
DELIMITER $
DROP TRIGGER IF EXISTS CHANGE_GROUP_STATUS$
CREATE TRIGGER CHANGE_GROUP_STATUS
	AFTER DELETE ON ENROLLMENT
	FOR EACH ROW
	BEGIN
		IF ((SELECT Current_Number FROM GROUPSS WHERE Group_ID=old.Group_ID)=0) THEN
			UPDATE GROUPSS SET Group_Status="E" WHERE Group_ID = old.Group_ID;
		END IF;
	END $
DELIMITER ;
-- SHOW TRIGGERS;

-- SELECT * FROM GROUPSS;
-- SELECT * FROM ENROLLMENT;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM ENROLLMENT
WHERE Group_ID='5550000023' and Tenant_ID='1010000026';

-- SELECT * FROM GROUPSS;
-- SELECT * FROM ENROLLMENT;

-- (5) my account

-- (5.1) create user (register)
INSERT INTO TENANT VALUES
('1010000031', 'John', 'M', '22', 'Student', 'CUHK(SZ)', '18834850321');

-- (5.2) view collections
SELECT Apartment_ID, Notes, Collection_Time FROM COLLECTION WHERE Tenant_ID='1010000024';

-- (5.3) view browsing records
SELECT Apartment_ID, Browsing_Time FROM BROWSING_RECORD WHERE Tenant_ID='1010000024';

-- (5.4) view comments
SELECT * FROM COMMENTS WHERE Tenant_ID='1010000002';

-- (5.5) view my groups
SELECT * FROM GROUPSS WHERE Group_ID IN
(SELECT Group_ID FROM ENROLLMENT WHERE Tenant_ID = '1010000030');

-- (5.6) view my contract
SELECT * FROM CONTRACT WHERE Tenant_ID IN
(SELECT Tenant_ID FROM ENROLLMENT WHERE Group_ID IN
(SELECT Group_ID FROM ENROLLMENT WHERE Tenant_ID='1010000010') AND Is_GroupLeader=1);

-- (5.7) update personal information
UPDATE Tenant SET Tenant_Institution = 'MIT' WHERE Tenant_ID = '1010000031';


