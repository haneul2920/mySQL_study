
CREATE TABLE 과목
(
	과목번호             NUMBER(2) NOT NULL ,
	과목명               VARCHAR(500) NULL ,
	과목개요             VARCHAR(1000) NULL ,
	교수번호             CHAR(10) NOT NULL 
);



CREATE UNIQUE INDEX XPK과목 ON 과목
(과목번호   ASC);



ALTER TABLE 과목
	ADD CONSTRAINT  XPK과목 PRIMARY KEY (과목번호);



CREATE TABLE 교수
(
	교수번호             CHAR(10) NOT NULL ,
	이름                 VARCHAR(20) NULL ,
	전공분야             VARCHAR(50) NULL 
);



CREATE UNIQUE INDEX XPK교수 ON 교수
(교수번호   ASC);



ALTER TABLE 교수
	ADD CONSTRAINT  XPK교수 PRIMARY KEY (교수번호);



CREATE TABLE 보유기술
(
	교수번호             CHAR(10) NOT NULL ,
	기술번호             NUMBER(2) NOT NULL 
);



CREATE UNIQUE INDEX XPK보유기술 ON 보유기술
(교수번호   ASC,기술번호   ASC);



ALTER TABLE 보유기술
	ADD CONSTRAINT  XPK보유기술 PRIMARY KEY (교수번호,기술번호);



CREATE TABLE 섹션
(
	섹션번호             NUMBER(3) NOT NULL ,
	섹션                 VARCHAR(500) NULL ,
	과목번호             NUMBER(2) NOT NULL 
);



CREATE UNIQUE INDEX XPK섹션 ON 섹션
(섹션번호   ASC,과목번호   ASC);



ALTER TABLE 섹션
	ADD CONSTRAINT  XPK섹션 PRIMARY KEY (섹션번호,과목번호);



CREATE TABLE 수강
(
	학번                 CHAR(18) NOT NULL ,
	과목번호             NUMBER(2) NOT NULL ,
	교실명               VARCHAR(10) NULL 
);



CREATE UNIQUE INDEX XPK수강 ON 수강
(학번   ASC,과목번호   ASC);



ALTER TABLE 수강
	ADD CONSTRAINT  XPK수강 PRIMARY KEY (학번,과목번호);



CREATE TABLE 학과
(
	학과명               VARCHAR(50) NOT NULL ,
	사무실위치           CHAR(18) NULL ,
	사무실전화번호       CHAR(13) NULL ,
	학과장               VARCHAR(8) NULL ,
	교수번호             CHAR(10) NOT NULL 
);



CREATE UNIQUE INDEX XPK학과 ON 학과
(학과명   ASC);



ALTER TABLE 학과
	ADD CONSTRAINT  XPK학과 PRIMARY KEY (학과명);



CREATE TABLE 학생
(
	학번                 CHAR(18) NOT NULL ,
	이름                 VARCHAR(20) NULL ,
	주소                 VARCHAR(150) NULL ,
	생년월일             CHAR(8) NULL ,
	학과명               VARCHAR(50) NOT NULL ,
	교수번호             CHAR(10) NOT NULL 
);



CREATE UNIQUE INDEX XPK학생 ON 학생
(학번   ASC);



ALTER TABLE 학생
	ADD CONSTRAINT  XPK학생 PRIMARY KEY (학번);



ALTER TABLE 과목
	ADD (CONSTRAINT R_16 FOREIGN KEY (교수번호) REFERENCES 교수 (교수번호));



ALTER TABLE 보유기술
	ADD (CONSTRAINT R_14 FOREIGN KEY (교수번호) REFERENCES 교수 (교수번호));



ALTER TABLE 섹션
	ADD (CONSTRAINT R_12 FOREIGN KEY (과목번호) REFERENCES 과목 (과목번호));



ALTER TABLE 수강
	ADD (CONSTRAINT R_10 FOREIGN KEY (학번) REFERENCES 학생 (학번));



ALTER TABLE 수강
	ADD (CONSTRAINT R_11 FOREIGN KEY (과목번호) REFERENCES 과목 (과목번호));



ALTER TABLE 학과
	ADD (CONSTRAINT R_18 FOREIGN KEY (교수번호) REFERENCES 교수 (교수번호));



ALTER TABLE 학생
	ADD (CONSTRAINT R_6 FOREIGN KEY (학과명) REFERENCES 학과 (학과명));



ALTER TABLE 학생
	ADD (CONSTRAINT R_17 FOREIGN KEY (교수번호) REFERENCES 교수 (교수번호));


