-- CUSTOMER
DROP TABLE gabes_customer CASCADE CONSTRAINTS;
CREATE TABLE gabes_customer (
	UserID 			INTEGER 		NOT NULL,
	Username 		VARCHAR(15) 	NOT NULL,
	Pass 		    	VARCHAR(15) 	NOT NULL,
	Fname 			VARCHAR(15),
	Lname 			VARCHAR(15),
	Phone 			VARCHAR(10),
	Email			VARCHAR(30),
	UNIQUE (Username),
	PRIMARY KEY (UserID)
);


-- ADMIN
DROP TABLE gabes_admin CASCADE CONSTRAINTS;
CREATE TABLE gabes_admin (
	Username 		VARCHAR(15) 	NOT NULL,
	Pass 		    	VARCHAR(15) 	NOT NULL,
	PRIMARY KEY (Username)
) ;

-- ITEM
DROP TABLE gabes_item CASCADE CONSTRAINTS;
CREATE TABLE gabes_item (
	ItemID 			INTEGER 				NOT NULL,
	StartDate 		DATE            	NOT NULL,
	EndDate 			DATE            	NOT NULL,
	ItemName 		VARCHAR(30) 		NOT NULL,
	Descript 		VARCHAR(255),
	Categories     VARCHAR(15),
	StartPrice 		DECIMAL(10,2) 		NOT NULL,
	Status			VARCHAR(11),
	CurrentBid		DECIMAL(10,2),
    buyNow          DECIMAL(10,2),
	PRIMARY KEY (ItemID),
    CONSTRAINT valDate CHECK (EndDate > StartDate),
    CONSTRAINT notNegStart CHECK (StartPrice >0)
);


-- BID
DROP TABLE gabes_bid CASCADE CONSTRAINTS;
CREATE TABLE gabes_bid (
	UserID 			INTEGER 		NOT NULL,
	ItemID 			INTEGER			NOT NULL,
	MaxBidLimit		DECIMAL(10,2),
	BidTime			DATE			NOT NULL,
	FOREIGN KEY (UserID) REFERENCES gabes_customer(UserID),
--        ON DELETE SET NULL	ON UPDATE CASCADE,
	FOREIGN KEY (ItemID) REFERENCES gabes_item(ItemID),
--        ON DELETE SET NULL	ON UPDATE CASCADE
	PRIMARY KEY (UserID, ItemID, BidTime)
);

-- SELL
DROP TABLE gabes_sell CASCADE CONSTRAINTS;
CREATE TABLE gabes_sell (
	UserID 			INTEGER			NOT NULL,
	ItemID 			INTEGER			NOT NULL,
	Overall 		INTEGER			CHECK (Overall >=0 AND Overall <= 5),
	Comments 		VARCHAR(140),
	Quality 		INTEGER			CHECK (Quality >=1 AND Quality <= 5),
	Delivery 		INTEGER			CHECK (Delivery >=1 AND Delivery <= 5), 
	FOREIGN KEY (UserID) REFERENCES gabes_customer(UserID),
--        ON DELETE SET NULL	ON UPDATE CASCADE,
	FOREIGN KEY (ItemID) REFERENCES gabes_item(ItemID),
--        ON DELETE SET NULL	ON UPDATE CASCADE,
	PRIMARY KEY (UserID, ItemID)
);

--MANAGE
DROP TABLE gabes_manage CASCADE CONSTRAINTS;
CREATE TABLE gabes_manage (
	Username 		VARCHAR(15)			NOT NULL,
	UserID 			INTEGER				NOT NULL,
 	FOREIGN KEY (UserID) REFERENCES gabes_customer(UserID),
--        ON DELETE SET NULL	ON UPDATE CASCADE,
	FOREIGN KEY (Username) REFERENCES gabes_admin(Username),
--        ON DELETE SET NULL	ON UPDATE CASCADE,
	PRIMARY KEY (UserID, Username)
);


INSERT INTO GABES_ADMIN (Username, Pass) VALUES ('Admin1', 'Password1');
INSERT INTO GABES_ADMIN (Username, Pass) VALUES ('Admin2', 'Password2');
INSERT INTO GABES_ADMIN (Username, Pass) VALUES ('Admin3', 'Password3');
INSERT INTO GABES_ADMIN (Username, Pass) VALUES ('Admin4', 'Password4');
INSERT INTO GABES_ADMIN (Username, Pass) VALUES ('Admin5', 'Password5');
INSERT INTO GABES_CUSTOMER (USERID, USERNAME, PASS, FNAME, LNAME, PHONE, EMAIL) VALUES (10000, 'Username1', 'Password1', 'Jon', 'Snow', '1234567890', 'jsnow@csbsju.edu');
INSERT INTO GABES_CUSTOMER (USERID, USERNAME, PASS, FNAME, LNAME, PHONE, EMAIL) VALUES (10001, 'Username2', 'Password2', 'Soulja', 'Boy', '6789998212', 'sboy@csbsju.edu');
INSERT INTO GABES_CUSTOMER (USERID, USERNAME, PASS, FNAME, LNAME, PHONE, EMAIL) VALUES (10002, 'Username3', 'Password3', 'Stanley', 'Steamer', '8007832637', 'ssteamer@csbsju.edu');
INSERT INTO GABES_CUSTOMER (USERID, USERNAME, PASS, FNAME, LNAME, PHONE, EMAIL) VALUES (10003, 'Username4', 'Password3', 'Tommy', 'Tutone', '9528675309', 'ttutone@csbsju.edu');
INSERT INTO GABES_CUSTOMER (USERID, USERNAME, PASS, FNAME, LNAME, PHONE, EMAIL) VALUES (10004, 'Username5', 'Password5', 'Pizza', 'Hut', '5888888888', 'phutt@csbsju.edu');
INSERT INTO GABES_ITEM (ItemID, StartDate, EndDate, ItemName, Descript, Categories, StartPrice, Status, CurrentBid, buyNow) VALUES (10000, to_date('2017-10-22', 'YYYY-MM-DD'), to_date('2017-11-12', 'YYYY-MM-DD'), 'Iron', 'An iron for clothing', 'Household', 15.00, 'SOLD', 21.00, 50.00);
INSERT INTO GABES_ITEM (ItemID, StartDate, EndDate, ItemName, Descript, Categories, StartPrice, Status, CurrentBid, buyNow) VALUES (10001, to_date('2017-10-22', 'YYYY-MM-DD'), to_date('2017-11-12', 'YYYY-MM-DD'), 'Pacemaker', 'Keep pace with your health', 'Health', 100.00, 'SOLD', 101.00, 300.00);
INSERT INTO GABES_ITEM (ItemID, StartDate, EndDate, ItemName, Descript, Categories, StartPrice, Status, CurrentBid, buyNow) VALUES (10002, to_date('2017-10-22', 'YYYY-MM-DD'), to_date('2017-11-12', 'YYYY-MM-DD'), 'Man purse', 'ITS A SATCHEL!', 'Style', 50.00, 'SOLD', 76.00, 150.00);
INSERT INTO GABES_ITEM (ItemID, StartDate, EndDate, ItemName, Descript, Categories, StartPrice, Status, CurrentBid, buyNow) VALUES (10003, to_date('2017-10-22', 'YYYY-MM-DD'), to_date('2017-11-12', 'YYYY-MM-DD'), 'Kidney', 'No need to deal with black-markets any longer -- ships right to you', 'Health', 10000.00, 'ON AUCTION', 10001.00, 20000.00);
INSERT INTO GABES_ITEM (ItemID, StartDate, EndDate, ItemName, Descript, Categories, StartPrice, Status, CurrentBid, buyNow) VALUES (10004, to_date('2017-10-22', 'YYYY-MM-DD'), to_date('2017-11-12', 'YYYY-MM-DD'), 'Shoe', 'One single shoe, for left foot only', 'Style', 15.00, 'ON AUCTION', 15.00, null);
INSERT INTO GABES_ITEM (ItemID, StartDate, EndDate, ItemName, Descript, Categories, StartPrice, Status, CurrentBid, buyNow) VALUES (10005, to_date('2017-10-22', 'YYYY-MM-DD'), to_date('2017-11-12', 'YYYY-MM-DD'), 'Eraser', 'For blackboard purposes', 'Classroom', 5.00, 'ON AUCTION', 5.00, null);
INSERT INTO GABES_ITEM (ItemID, StartDate, EndDate, ItemName, Descript, Categories, StartPrice, Status, CurrentBid, buyNow) VALUES (10006, to_date('2017-10-22', 'YYYY-MM-DD'), to_date('2017-11-12', 'YYYY-MM-DD'), 'Toaster', 'A toaster for toasting', 'Household', 15.00, 'OFF AUCTION', 15.00, 35.00);
INSERT INTO GABES_ITEM (ItemID, StartDate, EndDate, ItemName, Descript, Categories, StartPrice, Status, CurrentBid, buyNow) VALUES (10007, to_date('2017-10-22', 'YYYY-MM-DD'), to_date('2017-11-12', 'YYYY-MM-DD'), 'Tool Kit', 'For household use', 'Household', 15.00, 'SOLD', 16.00, null);
INSERT INTO GABES_SELL (UserID, ItemID, Overall, Comments, Quality, Delivery) VALUES (10001, 10000, 5, 'Great work', 5, 5);
INSERT INTO GABES_SELL (UserID, ItemID, Overall, Comments, Quality, Delivery) VALUES (10001, 10001, 5, 'Great work', 5, 5);
INSERT INTO GABES_SELL (UserID, ItemID, Overall, Comments, Quality, Delivery) VALUES (10001, 10002, 5, 'Great work', 5, 5);
INSERT INTO GABES_SELL (UserID, ItemID, Overall, Comments, Quality, Delivery) VALUES (10001, 10003, 5, null, null, null);
INSERT INTO GABES_SELL (UserID, ItemID, Overall, Comments, Quality, Delivery) VALUES (10000, 10004, 5, null, null, null);
INSERT INTO GABES_SELL (UserID, ItemID, Overall, Comments, Quality, Delivery) VALUES (10000, 10005, 5, null, null, null);
INSERT INTO GABES_SELL (UserID, ItemID, Overall, Comments, Quality, Delivery) VALUES (10000, 10006, 5, null, null, null);
INSERT INTO GABES_SELL (UserID, ItemID, Overall, Comments, Quality, Delivery) VALUES (10000, 10007, 5, 'Great work', 5, 5);
INSERT INTO GABES_BID (UserID, ItemID, MaxBidLimit, BidTime) VALUES (10002, 10000, 20.00, to_date('2017-10-23', 'YYYY-MM-DD'));
INSERT INTO GABES_BID (UserID, ItemID, MaxBidLimit, BidTime) VALUES (10000, 10000, 25.00, to_date('2017-10-23', 'YYYY-MM-DD'));
INSERT INTO GABES_BID (UserID, ItemID, MaxBidLimit, BidTime) VALUES (10000, 10001, 150.00, to_date('2017-10-23', 'YYYY-MM-DD'));
INSERT INTO GABES_BID (UserID, ItemID, MaxBidLimit, BidTime) VALUES (10000, 10002, 75.00, to_date('2017-10-23', 'YYYY-MM-DD'));
INSERT INTO GABES_BID (UserID, ItemID, MaxBidLimit, BidTime) VALUES (10003, 10002, 100.00, to_date('2017-10-23', 'YYYY-MM-DD'));
INSERT INTO GABES_BID (UserID, ItemID, MaxBidLimit, BidTime) VALUES (10000, 10003, 12000.00, to_date('2017-10-23', 'YYYY-MM-DD'));
INSERT INTO GABES_BID (UserID, ItemID, MaxBidLimit, BidTime) VALUES (10003, 10004, 20.00, to_date('2017-10-23', 'YYYY-MM-DD'));
INSERT INTO GABES_BID (UserID, ItemID, MaxBidLimit, BidTime) VALUES (10004, 10007, 25.00, to_date('2017-10-23', 'YYYY-MM-DD'));
INSERT INTO GABES_MANAGE(Username, UserID) VALUES ('Admin1', '10000');
INSERT INTO GABES_MANAGE(Username, UserID) VALUES ('Admin2', '10001');

create or replace TRIGGER GABES_UPDATE_CURRENT_PRICE
	BEFORE INSERT ON GABES_BID
	FOR EACH ROW
		Declare
    		OldMax decimal(10,2);
	BEGIN
    	SELECT MAX(MaxBidLimit)
    	INTO OldMax
    	FROM GABES_BID b
    	WHERE b.ItemID = :NEW.ItemID;

    	IF (OldMax IS NULL) THEN
            UPDATE GABES_Item i
            SET i.CurrentBid = i.StartPrice + 1
            WHERE :NEW.ItemID = i.itemID;
        ELSE
            IF (OldMax > :New.MaxBidLimit) THEN
                UPDATE GABES_Item i
                SET i.CurrentBid = :NEW.MaxBidLimit + 1
                WHERE :NEW.ItemID = i.itemID;
            ELSE
                UPDATE GABES_Item i
                SET i.CurrentBid = OldMax + 1
                WHERE :NEW.ItemID = i.itemID;
            END IF;
        END IF;
End;

