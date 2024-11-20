-- DROP DATABASE IF EXISTS productionmanagement_db;
CREATE DATABASE productionmanagement_db;

USE productionmanagement_db;


CREATE TABLE delivery -- 납품
(
	delivery_date 				VARCHAR(50) NULL , -- 납품일
	delivery_quantity			INT NULL , -- 납품 수량
	delivery_location			VARCHAR(1000) NULL , -- 납품 장소
	delivery_code				VARCHAR(20) NOT NULL , -- 납품 코드
	manufacture_code			int NOT NULL -- 제조 코드
);



CREATE UNIQUE INDEX XPKdelivery ON delivery
(delivery_code   ASC);



ALTER TABLE delivery
	ADD CONSTRAINT  XPKdelivery PRIMARY KEY (delivery_code);



CREATE TABLE dept -- 부서
(
	dept_code			VARCHAR(20) NOT NULL , -- 부서 코드
	dept_name 			VARCHAR(20) NULL , -- 부서 이름
	dept_point 			VARCHAR(50) NULL , -- 부서 위치
	dept_nop				INT NULL -- 부서 인원
);
insert into dept values ("HR01", "인사부","사무1팀" , 4),
						("DS02","설계부","사무2팀", 3),
						("FN05","재무부","사무3팀",3),
						("PR03","생산부","1동",5),
						("AS04","조립부","2동",5);
select * from dept;

CREATE UNIQUE INDEX XPKdept ON dept
(dept_code   ASC);



ALTER TABLE dept
	ADD CONSTRAINT  XPKdept PRIMARY KEY (dept_code);



CREATE TABLE part -- 부품
(
	part_code			VARCHAR(20) NOT NULL , -- 부품 코드
	part_name			VARCHAR(40) NULL -- 부품 이름
);



CREATE UNIQUE INDEX XPKpart ON part
(part_code   ASC);



ALTER TABLE part
	ADD CONSTRAINT  XPKpart PRIMARY KEY (part_code);


drop table if exists defect;
CREATE TABLE defect -- 불량
(
	Cause_of_defect			VARCHAR(1000) NULL , -- 불량 원인
	defect_Solution			VARCHAR(1000) NULL , -- 불량 해결책
	defect_rate				DECIMAL(5, 2) NULL , -- 불량율
	manufacture_code		int NOT NULL -- 제조 코드
);



CREATE UNIQUE INDEX XPKdefect ON defect
(manufacture_code   ASC);



ALTER TABLE defect
	ADD CONSTRAINT  XPKdefect PRIMARY KEY (manufacture_code);



CREATE TABLE equipment -- 설비
(
	equipment_code					VARCHAR(20) NOT NULL , -- 설비 코드
	equipment_name           	   VARCHAR(100) NULL , -- 설비 이름
	equipment_trait          	   VARCHAR(1000) NULL , -- 설비 특징
	equipment_installation_date		VARCHAR(50) NULL , -- 설비 설치 날짜
	dept_code         			   VARCHAR(20) NOT NULL , -- 부서 코드
	equipment_state           		  CHAR(1) NULL  -- 설비 상태
);
insert into equipment values("HUN1","K2","CNC 가공기","2015-04-19","PR03",1),
							("HUN2","K2I","CNC 가공기","2019-12-30","PR03",1),
							("HUN3","K3","몰딩기","2012-06-10","PR03",1),
							("HUN4","K3i","대패기","2010-08-08","PR03",0),
							("HUN5","K1","대패기","2020-02-20","PR03",1);
select * from equipment;


CREATE UNIQUE INDEX XPKequipment ON equipment
(equipment_code   ASC);



ALTER TABLE equipment
	ADD CONSTRAINT  XPKequipment PRIMARY KEY (equipment_code);



CREATE TABLE inspection -- 점검
(
	inspection_code				VARCHAR(20) NOT NULL , -- 점검 코드
	inspection_date             VARCHAR(50) NULL , -- 점검 날짜
	inspection_particulars		VARCHAR(1000) NULL , -- 점검 내역
	staff_code					VARCHAR(20) NOT NULL , -- 직원 코드
	equipment_code				VARCHAR(20) NOT NULL -- 설비 코드
);

insert into inspection values("FIX01","2020-01-04","대패기 날교체","abc010","HUN4");
insert into inspection values("FIX02","2020-01-09","CNC 가공기 유압유 보충","abc010","HUN2");
insert into inspection values("FIX03","2019-05-20","X축 베어링 교환","abc010","HUN1");
insert into inspection values("FIX04","2021-10-03","유압 호스 누유로 인한 교환","abc011","HUN1");
select * from inspection;

CREATE UNIQUE INDEX XPKinspection ON inspection
(inspection_code   ASC);



ALTER TABLE inspection
	ADD CONSTRAINT  XPKinspection PRIMARY KEY (inspection_code);



CREATE TABLE manufacture -- 제조
(
	manufacture_code            int NOT NULL , -- 제조 코드
	manufacture_date			date NULL , -- 제조 날짜
	product_code				VARCHAR(20) NOT NULL , -- 제품 코드
	part_code					VARCHAR(20) NOT NULL , -- 부품 코드
	manufacture_quantity		INT NULL -- 제조 수량
);



CREATE UNIQUE INDEX XPKmanufacture ON manufacture
(manufacture_code   ASC);



ALTER TABLE manufacture
	ADD CONSTRAINT  XPKmanufacture PRIMARY KEY (manufacture_code);



CREATE TABLE product -- 제품
(
	product_code			VARCHAR(20) NOT NULL , -- 제품_코드
	product_name			VARCHAR(40) NULL , -- 제품 이름
	product_price			INT NULL , -- 제품 가격
	staff_code    	        VARCHAR(20) NOT NULL , -- 직원 코드
	equipment_code          VARCHAR(20) NOT NULL -- 설비 코드
);



CREATE UNIQUE INDEX XPKproduct ON product
(product_code   ASC);



ALTER TABLE product
	ADD CONSTRAINT  XPKproduct PRIMARY KEY (product_code);


CREATE TABLE staff -- 직원
(
	staff_code				VARCHAR(20) NOT NULL , -- 직원 코드
	manager           	    VARCHAR(20) NULL , -- 관리자
	staff_name				VARCHAR(50) NULL , -- 직원 이름
	staff_age				INT NULL , -- 직원 나이
	staff_sex				VARCHAR(2) NULL , -- 직원 성별
	staff_addr				VARCHAR(1000) NULL , -- 직원 주소
	staff_ponenumber		VARCHAR(13) NULL , -- 직원 전화번호
	dept_code				VARCHAR(20) NOT NULL , -- 부서 코드
	staff_rank				VARCHAR(20) NULL  -- 직원 직급
);
insert into staff values ("abc002",null,"이서연","32","여","서울특별시 강남구","01012345671","HR01","과장"),
						 ("abc001","관리자","김준혁","40","남","경기도 수원시","01023456782","HR01","대표"),
                         ("abc003",null,"박지우","28","남","서울특별시 송파구","01034567893","HR01","사원"),
                         ("abc016",null,"김응룡","28","여","서울특별시 송파구","01034517893","HR01","사원"),
                         ("abc004",null,"최현우","36","남","서울특별시 용산구","01045678904","DS02","대리"),
                         ("abc005",null,"신예은","29","여","인천광역시 연수구","01056789015","DS02","사원"),
                         ("abc006","관리자","정도현","42","남","경기도 성남시","01067890126","DS02","부장"),
                         ("abc007",null,"이수민","39","여","서울특별시 중구","01078901237","FN05","차장"),
                         ("abc008","관리자","김재훈","45","남","서울특별시 강동구","01089012348","FN05","부장"),
                         ("abc009",null,"윤서영","31","여","경기도 고양시","01090123459","FN05","대리"),
                         ("abc010",null,"박민준","34","남","경기도 화성시","01023456789","PR03","사원"),
                         ("abc011",null,"한서진","27","여","인천광역시 남동구","01034567890","PR03","사원"),
                         ("abc012",null,"송민지","30","여","경기도 안양시","01045678901","PR03","대리"),
                         ("abc013","관리자","정하윤","41","여","경기도 평택시","01045678901","PR03","부장"),
                         ("abc014",null,"이준영","38","남","서울특별시 노원구","01067890123","PR03","차장"),
                         ("abc015","관리자","정현우","44","남","서울특별시 강서구","01067890123","AS04","부장"),
                         ("abc017",null,"최유빈","29","여","경기도 남양주시","01078901234","AS04","사원"),
                         ("abc018",null,"서지훈","35","남","경기도 시흥시","010-8901-2345","AS04","사원"),
                         ("abc019",null,"윤민성","33","남","서울특별시 관악구","010-9012-3456","AS04","대리"),
                         ("abc020",null,"장서연","26","여","경기도 부천시","01012345678","AS04","사원");


CREATE UNIQUE INDEX XPKstaff ON staff
(staff_code   ASC);



ALTER TABLE staff
	ADD CONSTRAINT  XPKstaff PRIMARY KEY (staff_code);



ALTER TABLE delivery
	ADD (CONSTRAINT R_26 FOREIGN KEY (manufacture_code) REFERENCES manufacture (manufacture_code));



ALTER TABLE defect
	ADD (CONSTRAINT R_32 FOREIGN KEY (manufacture_code) REFERENCES manufacture (manufacture_code));



ALTER TABLE equipment
	ADD (CONSTRAINT R_28 FOREIGN KEY (dept_code) REFERENCES dept (dept_code));



ALTER TABLE inspection
	ADD (CONSTRAINT R_8 FOREIGN KEY (staff_code) REFERENCES staff (staff_code));



ALTER TABLE inspection
	ADD (CONSTRAINT R_9 FOREIGN KEY (equipment_code) REFERENCES equipment (equipment_code));



ALTER TABLE manufacture
	ADD (CONSTRAINT R_25 FOREIGN KEY (product_code) REFERENCES product (product_code));



ALTER TABLE manufacture
	ADD (CONSTRAINT R_27 FOREIGN KEY (part_code) REFERENCES part (part_code));



ALTER TABLE product
	ADD (CONSTRAINT R_29 FOREIGN KEY (staff_code) REFERENCES staff (staff_code));



ALTER TABLE product
	ADD (CONSTRAINT R_31 FOREIGN KEY (equipment_code) REFERENCES equipment (equipment_code));



ALTER TABLE staff
	ADD (CONSTRAINT R_5 FOREIGN KEY (manager) REFERENCES staff (staff_code));



ALTER TABLE staff
	ADD (CONSTRAINT R_6 FOREIGN KEY (dept_code) REFERENCES dept (dept_code));


