
DELETE FROM REPLY;
DELETE FROM BOARD;

SELECT * FROM BOARD;

DROP TABLE BOARD;

CREATE TABLE BOARD(
	IDX INT NOT NULL AUTO_INCREMENT,
	TITLE VARCHAR(100) NOT NULL,
	CONTENT VARCHAR(2000) NOT NULL,
	WRITER VARCHAR(30) NOT NULL,
	INDATE DATETIME DEFAULT NOW(),
	COUNT INT DEFAULT 0,
	IMGPATH VARCHAR(200),
	PRIMARY KEY(IDX)
);

INSERT INTO BOARD(TITLE, CONTENT, WRITER)
VALUES('봄이 왔나봐요 날이 따듯해집니다.','하지만 외롭죠....','장범준');

INSERT INTO BOARD(TITLE, CONTENT, WRITER)
VALUES('오늘 기획서도 내야하는데 어쩌지','일단 기획서를 써야지','장범준');

INSERT INTO BOARD(TITLE, CONTENT, WRITER)
VALUES('스프링은 내일 복습해야겠다...','과연할까?','장범준');

INSERT INTO BOARD(TITLE, CONTENT, WRITER)
VALUES('취업가능?','응 돼도 또 짤림','장범준');


SELECT * FROM BOARD;

SELECT * FROM MEMBER;


CREATE TABLE REPLY(
	IDX INT NOT NULL AUTO_INCREMENT,
	BOARDNUM INT NOT NULL,
	WRITER VARCHAR(30) NOT NULL,
	CONTENT VARCHAR(2000) NOT NULL,
	INDATE DATETIME DEFAULT NOW(),
	PRIMARY KEY(IDX)
);

DROP TABLE REPLY;


CREATE TABLE MEMBER(
	ID VARCHAR(100) NOT NULL,
	PW VARCHAR(100) NOT NULL,
	NICK VARCHAR(100) NOT NULL,
	PRIMARY KEY(ID)
)

DELETE FROM MEMBER;



