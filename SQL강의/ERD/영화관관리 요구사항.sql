
CREATE TABLE �󿵰�
(
	�󿵰���             VARCHAR(4) NOT NULL ,
	��ġ                 VARCHAR(50) NULL ,
	�����ο�             NUMBER(3) NULL ,
	�󿵹��             VARCHAR(10) NULL ,
	������               VARCHAR(50) NOT NULL ,
	��ȭ�ڵ�             VARCHAR(20) NOT NULL 
);



CREATE UNIQUE INDEX XPK�󿵰� ON �󿵰�
(�󿵰���   ASC);



ALTER TABLE �󿵰�
	ADD CONSTRAINT  XPK�󿵰� PRIMARY KEY (�󿵰���);



CREATE TABLE �󿵽ð�
(
	�󿵽�����           VARCHAR(14) NULL ,
	��������           VARCHAR(14) NULL ,
	��ȭ�ڵ�             VARCHAR(20) NOT NULL 
);



CREATE UNIQUE INDEX XPK�󿵽ð� ON �󿵽ð�
(��ȭ�ڵ�   ASC);



ALTER TABLE �󿵽ð�
	ADD CONSTRAINT  XPK�󿵽ð� PRIMARY KEY (��ȭ�ڵ�);



CREATE TABLE ��ȭ
(
	��ȭ�ڵ�             VARCHAR(20) NOT NULL ,
	��ȭ��               VARCHAR(50) NULL ,
	�帣                 VARCHAR(30) NULL ,
	���                 VARCHAR(2) NULL ,
	��ȭ�ð�             VARCHAR(5) NULL 
);



CREATE UNIQUE INDEX XPK��ȭ ON ��ȭ
(��ȭ�ڵ�   ASC);



ALTER TABLE ��ȭ
	ADD CONSTRAINT  XPK��ȭ PRIMARY KEY (��ȭ�ڵ�);



CREATE TABLE ����
(
	������               VARCHAR(50) NOT NULL ,
	�ּ�                 VARCHAR(1000) NULL ,
	������ȭ��ȣ         VARCHAR(13) NULL 
);



CREATE UNIQUE INDEX XPK���� ON ����
(������   ASC);



ALTER TABLE ����
	ADD CONSTRAINT  XPK���� PRIMARY KEY (������);



CREATE TABLE ����
(
	����ID               VARCHAR(10) NOT NULL ,
	�̸�                 VARCHAR(50) NULL ,
	����                 VARCHAR(10) NULL ,
	��ȭ��ȣ             VARCHAR(13) NULL ,
	������               VARCHAR(50) NOT NULL 
);



CREATE UNIQUE INDEX XPK���� ON ����
(����ID   ASC);



ALTER TABLE ����
	ADD CONSTRAINT  XPK���� PRIMARY KEY (����ID);



ALTER TABLE �󿵰�
	ADD (CONSTRAINT R_11 FOREIGN KEY (������) REFERENCES ���� (������));



ALTER TABLE �󿵰�
	ADD (CONSTRAINT R_16 FOREIGN KEY (��ȭ�ڵ�) REFERENCES ��ȭ (��ȭ�ڵ�));



ALTER TABLE �󿵽ð�
	ADD (CONSTRAINT R_15 FOREIGN KEY (��ȭ�ڵ�) REFERENCES ��ȭ (��ȭ�ڵ�));



ALTER TABLE ����
	ADD (CONSTRAINT R_8 FOREIGN KEY (������) REFERENCES ���� (������));


