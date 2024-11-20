
CREATE TABLE 상영관
(
	상영관명             VARCHAR(4) NOT NULL ,
	위치                 VARCHAR(50) NULL ,
	수용인원             NUMBER(3) NULL ,
	상영방식             VARCHAR(10) NULL ,
	지점명               VARCHAR(50) NOT NULL ,
	영화코드             VARCHAR(20) NOT NULL 
);



CREATE UNIQUE INDEX XPK상영관 ON 상영관
(상영관명   ASC);



ALTER TABLE 상영관
	ADD CONSTRAINT  XPK상영관 PRIMARY KEY (상영관명);



CREATE TABLE 상영시간
(
	상영시작일           VARCHAR(14) NULL ,
	상영종료일           VARCHAR(14) NULL ,
	영화코드             VARCHAR(20) NOT NULL 
);



CREATE UNIQUE INDEX XPK상영시간 ON 상영시간
(영화코드   ASC);



ALTER TABLE 상영시간
	ADD CONSTRAINT  XPK상영시간 PRIMARY KEY (영화코드);



CREATE TABLE 영화
(
	영화코드             VARCHAR(20) NOT NULL ,
	영화명               VARCHAR(50) NULL ,
	장르                 VARCHAR(30) NULL ,
	등급                 VARCHAR(2) NULL ,
	영화시간             VARCHAR(5) NULL 
);



CREATE UNIQUE INDEX XPK영화 ON 영화
(영화코드   ASC);



ALTER TABLE 영화
	ADD CONSTRAINT  XPK영화 PRIMARY KEY (영화코드);



CREATE TABLE 지점
(
	지점명               VARCHAR(50) NOT NULL ,
	주소                 VARCHAR(1000) NULL ,
	지점전화번호         VARCHAR(13) NULL 
);



CREATE UNIQUE INDEX XPK지점 ON 지점
(지점명   ASC);



ALTER TABLE 지점
	ADD CONSTRAINT  XPK지점 PRIMARY KEY (지점명);



CREATE TABLE 직원
(
	직원ID               VARCHAR(10) NOT NULL ,
	이름                 VARCHAR(50) NULL ,
	직급                 VARCHAR(10) NULL ,
	전화번호             VARCHAR(13) NULL ,
	지점명               VARCHAR(50) NOT NULL 
);



CREATE UNIQUE INDEX XPK직원 ON 직원
(직원ID   ASC);



ALTER TABLE 직원
	ADD CONSTRAINT  XPK직원 PRIMARY KEY (직원ID);



ALTER TABLE 상영관
	ADD (CONSTRAINT R_11 FOREIGN KEY (지점명) REFERENCES 지점 (지점명));



ALTER TABLE 상영관
	ADD (CONSTRAINT R_16 FOREIGN KEY (영화코드) REFERENCES 영화 (영화코드));



ALTER TABLE 상영시간
	ADD (CONSTRAINT R_15 FOREIGN KEY (영화코드) REFERENCES 영화 (영화코드));



ALTER TABLE 직원
	ADD (CONSTRAINT R_8 FOREIGN KEY (지점명) REFERENCES 지점 (지점명));


