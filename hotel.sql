CREATE TABLE Hotel (
    hotelNo VARCHAR(10) NOT NULL,
    hotelName VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    CONSTRAINT Hotel_PK PRIMARY KEY (hotelNo)
);

CREATE TABLE Room (
    roomNo INTEGER NOT NULL,
    hotelNo VARCHAR(10) NOT NULL,
    type VARCHAR(10) DEFAULT 'Single' NOT NULL,
    price DECIMAL(5, 2) NOT NULL,
    CONSTRAINT Room_PK PRIMARY KEY (roomNo, hotelNo),
    CONSTRAINT Room_Hotel_FK FOREIGN KEY (hotelNo) REFERENCES Hotel (hotelNo),
    CONSTRAINT chk_room_type CHECK (type IN ('Single', 'Double', 'Family')),
    CONSTRAINT chk_room_price CHECK (price BETWEEN 10 AND 100),
    CONSTRAINT chk_room_no CHECK (roomNo BETWEEN 1 AND 100)
);

CREATE TABLE Guest (
    guestNo VARCHAR(10) NOT NULL,
    guestName VARCHAR(50) NOT NULL,
    guestAddress VARCHAR(100) NOT NULL,
    CONSTRAINT Guest_PK PRIMARY KEY (guestNo)
);

CREATE TABLE Booking (
    hotelNo VARCHAR(10) NOT NULL,
    guestNo VARCHAR(10) NOT NULL,
    dateFrom DATE NOT NULL,
    dateTo DATE NOT NULL,
    roomNo INTEGER NOT NULL,
    CONSTRAINT Booking_PK PRIMARY KEY (hotelNo, guestNo, dateFrom),
    CONSTRAINT Booking_Hotel_FK FOREIGN KEY (hotelNo) REFERENCES Hotel (hotelNo),
    CONSTRAINT Booking_Guest_FK FOREIGN KEY (guestNo) REFERENCES Guest (guestNo),
    CONSTRAINT Booking_Room_FK FOREIGN KEY (roomNo, hotelNo) REFERENCES Room (roomNo, hotelNo)
);