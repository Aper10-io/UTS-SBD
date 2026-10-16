CREATE TABLE Branch (
    branchNo VARCHAR(10) NOT NULL,
    mgrStaffNo VARCHAR(10),
    street VARCHAR(50),
    city VARCHAR(30),
    postcode VARCHAR(15),
    CONSTRAINT Branch_PK PRIMARY KEY (branchNo)
);

-- 2. Tabel Staff (Memiliki relasi Supervises ke dirinya sendiri & Has ke Branch)
CREATE TABLE Staff (
    staffNo VARCHAR(10) NOT NULL,
    supervisorStaffNo VARCHAR(10),
    branchNo VARCHAR(10) NOT NULL,
    fName VARCHAR(30),
    lName VARCHAR(30),
    position VARCHAR(20),
    sex CHAR(1),
    DOB DATE,
    salary NUMERIC(10, 2),
    CONSTRAINT Staff_PK PRIMARY KEY (staffNo),
    CONSTRAINT Staff_Supervisor_FK FOREIGN KEY (supervisorStaffNo) REFERENCES Staff (staffNo),
    CONSTRAINT Staff_Branch_FK FOREIGN KEY (branchNo) REFERENCES Branch (branchNo)
);

-- Menambahkan Foreign Key Manages dari Branch ke Staff
ALTER TABLE Branch
    ADD CONSTRAINT Branch_MgrStaff_FK FOREIGN KEY (mgrStaffNo) REFERENCES Staff (staffNo);

-- 3. Tabel Manager (Relasi 1:1 / Subtype dari Staff & Manages Branch)
CREATE TABLE Manager (
    staffNo VARCHAR(10) NOT NULL,
    mgrStartDate DATE,
    bonus NUMERIC(10, 2),
    CONSTRAINT Manager_PK PRIMARY KEY (staffNo),
    CONSTRAINT Manager_Staff_FK FOREIGN KEY (staffNo) REFERENCES Staff (staffNo)
);

-- 4. Tabel Telephone (Relasi Provides dari Branch)
CREATE TABLE Telephone (
    telNo VARCHAR(20) NOT NULL,
    branchNo VARCHAR(10) NOT NULL,
    CONSTRAINT Telephone_PK PRIMARY KEY (telNo),
    CONSTRAINT Telephone_Branch_FK FOREIGN KEY (branchNo) REFERENCES Branch (branchNo)
);

-- 5. Tabel Client
CREATE TABLE Client (
    clientNo VARCHAR(10) NOT NULL,
    fName VARCHAR(30),
    lName VARCHAR(30),
    telNo VARCHAR(20),
    prefType VARCHAR(20),
    maxRent NUMERIC(10, 2),
    eMail VARCHAR(50),
    CONSTRAINT Client_PK PRIMARY KEY (clientNo)
);

-- 6. Tabel Registration (Relasi Agrees Client, Registers Branch, Processes Staff)
CREATE TABLE Registration (
    clientNo VARCHAR(10) NOT NULL,
    branchNo VARCHAR(10) NOT NULL,
    staffNo VARCHAR(10) NOT NULL,
    dateJoined DATE,
    CONSTRAINT Registration_PK PRIMARY KEY (clientNo),
    CONSTRAINT Registration_Client_FK FOREIGN KEY (clientNo) REFERENCES Client (clientNo),
    CONSTRAINT Registration_Branch_FK FOREIGN KEY (branchNo) REFERENCES Branch (branchNo),
    CONSTRAINT Registration_Staff_FK FOREIGN KEY (staffNo) REFERENCES Staff (staffNo)
);

-- 7. Tabel PrivateOwner (POwns PropertyForRent)
CREATE TABLE PrivateOwner (
    ownerNo VARCHAR(10) NOT NULL,
    fName VARCHAR(30),
    lName VARCHAR(30),
    address VARCHAR(100),
    telNo VARCHAR(20),
    eMail VARCHAR(50),
    CONSTRAINT PrivateOwner_PK PRIMARY KEY (ownerNo)
);

-- 8. Tabel BusinessOwner (BOwns PropertyForRent)
CREATE TABLE BusinessOwner (
    ownerNo VARCHAR(10) NOT NULL,
    bName VARCHAR(50),
    bType VARCHAR(30),
    address VARCHAR(100),
    telNo VARCHAR(20),
    eMail VARCHAR(50),
    contactName VARCHAR(50),
    CONSTRAINT BusinessOwner_PK PRIMARY KEY (ownerNo)
);

-- 9. Tabel PropertyForRent (Oversees Staff, Offers Branch, POwns/BOwns Owner)
CREATE TABLE PropertyForRent (
    propertyNo VARCHAR(10) NOT NULL,
    ownerNo VARCHAR(10) NOT NULL,
    staffNo VARCHAR(10),
    branchNo VARCHAR(10) NOT NULL,
    street VARCHAR(50),
    city VARCHAR(30),
    postcode VARCHAR(15),
    type VARCHAR(20),
    rooms INTEGER,
    rent NUMERIC(10, 2),
    CONSTRAINT PropertyForRent_PK PRIMARY KEY (propertyNo),
    CONSTRAINT Property_Staff_FK FOREIGN KEY (staffNo) REFERENCES Staff (staffNo),
    CONSTRAINT Property_Branch_FK FOREIGN KEY (branchNo) REFERENCES Branch (branchNo),
    CONSTRAINT Property_PrivateOwner_FK FOREIGN KEY (ownerNo) REFERENCES PrivateOwner (ownerNo),
    CONSTRAINT Property_BusinessOwner_FK FOREIGN KEY (ownerNo) REFERENCES BusinessOwner (ownerNo)
);

-- 10. Tabel Lease (Holds Client, LeasedBy PropertyForRent)
CREATE TABLE Lease (
    leaseNo VARCHAR(10) NOT NULL,
    clientNo VARCHAR(10) NOT NULL,
    propertyNo VARCHAR(10) NOT NULL,
    rent NUMERIC(10, 2),
    paymentMethod VARCHAR(20),
    deposit NUMERIC(10, 2),
    paid CHAR(1),
    rentStart DATE,
    rentFinish DATE,
    CONSTRAINT Lease_PK PRIMARY KEY (leaseNo),
    CONSTRAINT Lease_Client_FK FOREIGN KEY (clientNo) REFERENCES Client (clientNo),
    CONSTRAINT Lease_Property_FK FOREIGN KEY (propertyNo) REFERENCES PropertyForRent (propertyNo)
);

-- 11. Tabel Viewing (Requests Client, Takes PropertyForRent)
CREATE TABLE Viewing (
    clientNo VARCHAR(10) NOT NULL,
    propertyNo VARCHAR(10) NOT NULL,
    viewDate DATE NOT NULL,
    comment VARCHAR(200),
    CONSTRAINT Viewing_PK PRIMARY KEY (clientNo, propertyNo),
    CONSTRAINT Viewing_Client_FK FOREIGN KEY (clientNo) REFERENCES Client (clientNo),
    CONSTRAINT Viewing_Property_FK FOREIGN KEY (propertyNo) REFERENCES PropertyForRent (propertyNo)
);

-- 12. Tabel Newspaper
CREATE TABLE Newspaper (
    newspaperName VARCHAR(50) NOT NULL,
    address VARCHAR(100),
    telNo VARCHAR(20),
    contactName VARCHAR(50),
    CONSTRAINT Newspaper_PK PRIMARY KEY (newspaperName)
);

-- 13. Tabel Advert (PlacedIn PropertyForRent, Displays Newspaper)
CREATE TABLE Advert (
    propertyNo VARCHAR(10) NOT NULL,
    newspaperName VARCHAR(50) NOT NULL,
    dateAdvert DATE NOT NULL,
    cost NUMERIC(10, 2),
    CONSTRAINT Advert_PK PRIMARY KEY (propertyNo, newspaperName, dateAdvert),
    CONSTRAINT Advert_Property_FK FOREIGN KEY (propertyNo) REFERENCES PropertyForRent (propertyNo),
    CONSTRAINT Advert_Newspaper_FK FOREIGN KEY (newspaperName) REFERENCES Newspaper (newspaperName)
);