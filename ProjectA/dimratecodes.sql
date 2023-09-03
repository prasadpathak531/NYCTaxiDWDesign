CREATE TABLE dimRateCodes
(
	RateCodeId INT,
	RateCode VARCHAR(100),
	IsApproved BIT
);

INSERT INTO dimRateCodes (RateCodeId, RateCode, IsApproved)
VALUES(1, 'Standard Rate', 1),
INSERT INTO dimRateCodes (RateCodeId, RateCode, IsApproved)
VALUES(2, 'JFK', 1),
INSERT INTO dimRateCodes (RateCodeId, RateCode, IsApproved)
VALUES(3, 'Newark', 1),
INSERT INTO dimRateCodes (RateCodeId, RateCode, IsApproved)
VALUES(4, 'Westchester', 0),
INSERT INTO dimRateCodes (RateCodeId, RateCode, IsApproved)
VALUES(5, 'Negotiated fare', 1),
INSERT INTO dimRateCodes (RateCodeId, RateCode, IsApproved)
VALUES(6, 'GroupRide', 1);


SELECT * FROM dimRateCodes;
