
CREATE TABLE ����
(
	�����ȣ             NUMBER(2) NOT NULL ,
	�����               VARCHAR(500) NULL ,
	���񰳿�             VARCHAR(1000) NULL ,
	������ȣ             CHAR(10) NOT NULL 
);



CREATE UNIQUE INDEX XPK���� ON ����
(�����ȣ   ASC);



ALTER TABLE ����
	ADD CONSTRAINT  XPK���� PRIMARY KEY (�����ȣ);



CREATE TABLE ����
(
	������ȣ             CHAR(10) NOT NULL ,
	�̸�                 VARCHAR(20) NULL ,
	�����о�             VARCHAR(50) NULL 
);



CREATE UNIQUE INDEX XPK���� ON ����
(������ȣ   ASC);



ALTER TABLE ����
	ADD CONSTRAINT  XPK���� PRIMARY KEY (������ȣ);



CREATE TABLE �������
(
	������ȣ             CHAR(10) NOT NULL ,
	�����ȣ             NUMBER(2) NOT NULL 
);



CREATE UNIQUE INDEX XPK������� ON �������
(������ȣ   ASC,�����ȣ   ASC);



ALTER TABLE �������
	ADD CONSTRAINT  XPK������� PRIMARY KEY (������ȣ,�����ȣ);



CREATE TABLE ����
(
	���ǹ�ȣ             NUMBER(3) NOT NULL ,
	����                 VARCHAR(500) NULL ,
	�����ȣ             NUMBER(2) NOT NULL 
);



CREATE UNIQUE INDEX XPK���� ON ����
(���ǹ�ȣ   ASC,�����ȣ   ASC);



ALTER TABLE ����
	ADD CONSTRAINT  XPK���� PRIMARY KEY (���ǹ�ȣ,�����ȣ);



CREATE TABLE ����
(
	�й�                 CHAR(18) NOT NULL ,
	�����ȣ             NUMBER(2) NOT NULL ,
	���Ǹ�               VARCHAR(10) NULL 
);



CREATE UNIQUE INDEX XPK���� ON ����
(�й�   ASC,�����ȣ   ASC);



ALTER TABLE ����
	ADD CONSTRAINT  XPK���� PRIMARY KEY (�й�,�����ȣ);



CREATE TABLE �а�
(
	�а���               VARCHAR(50) NOT NULL ,
	�繫����ġ           CHAR(18) NULL ,
	�繫����ȭ��ȣ       CHAR(13) NULL ,
	�а���               VARCHAR(8) NULL ,
	������ȣ             CHAR(10) NOT NULL 
);



CREATE UNIQUE INDEX XPK�а� ON �а�
(�а���   ASC);



ALTER TABLE �а�
	ADD CONSTRAINT  XPK�а� PRIMARY KEY (�а���);



CREATE TABLE �л�
(
	�й�                 CHAR(18) NOT NULL ,
	�̸�                 VARCHAR(20) NULL ,
	�ּ�                 VARCHAR(150) NULL ,
	�������             CHAR(8) NULL ,
	�а���               VARCHAR(50) NOT NULL ,
	������ȣ             CHAR(10) NOT NULL 
);



CREATE UNIQUE INDEX XPK�л� ON �л�
(�й�   ASC);



ALTER TABLE �л�
	ADD CONSTRAINT  XPK�л� PRIMARY KEY (�й�);



ALTER TABLE ����
	ADD (CONSTRAINT R_16 FOREIGN KEY (������ȣ) REFERENCES ���� (������ȣ));



ALTER TABLE �������
	ADD (CONSTRAINT R_14 FOREIGN KEY (������ȣ) REFERENCES ���� (������ȣ));



ALTER TABLE ����
	ADD (CONSTRAINT R_12 FOREIGN KEY (�����ȣ) REFERENCES ���� (�����ȣ));



ALTER TABLE ����
	ADD (CONSTRAINT R_10 FOREIGN KEY (�й�) REFERENCES �л� (�й�));



ALTER TABLE ����
	ADD (CONSTRAINT R_11 FOREIGN KEY (�����ȣ) REFERENCES ���� (�����ȣ));



ALTER TABLE �а�
	ADD (CONSTRAINT R_18 FOREIGN KEY (������ȣ) REFERENCES ���� (������ȣ));



ALTER TABLE �л�
	ADD (CONSTRAINT R_6 FOREIGN KEY (�а���) REFERENCES �а� (�а���));



ALTER TABLE �л�
	ADD (CONSTRAINT R_17 FOREIGN KEY (������ȣ) REFERENCES ���� (������ȣ));


