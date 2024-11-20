create database naver_db;

use naver_db;


drop table if exists member;
create table member
(mem_id			char(8) not null primary key, -- 회원 아이디
 mem_name		varchar(10)not null, -- 이름
 mem_number		tinyint not null, -- 인원수
 addr			char(2) not null, -- 주소(경기,서울,경남 식으로 2글자만입력)
 phone1			char(3) null, -- 연락처의 국번
 phone2			char(8) null, -- 연락처의 나머지 번호
 height			tinyint unsigned null, -- 평균키
 debut_date 	date null -- 데뷔일자
 );
 
 drop table if exists buy;
 
 create table buy  -- 구매 테이블
 (num 			int auto_increment not null primary key, -- 순번
  mem_id		char(8) not null, -- 아이디	
  prod_name		char(6) not null, -- 제품이름
  group_name	char(4) null, -- 분류
  price 		int unsigned not null, -- 가격
  amount		smallint unsigned not null, -- 수량
  foreign key (mem_id) references member(mem_id)
 );
 
 insert into member values("TWC", "트와이스", 9, "서울", "02", "11111111", 167, "2015-10-19"),
							("BLK", "블랙핑크", "4", "경남", "055", "22222222", 163, "2016-8-8"),
							("WMN", "여자친구", 6,"경기", "031", "33333333", 166, "2015-1-15");
                            
insert into buy values(null, "BLK", "지갑", null, 30, 2),
						(null, "BLK", "맥북프로", "디지털", 1000, 1),
						(null, "APN", "아이폰", "디지털", 200, 1);
drop table if exists buy,member;
create table member
( mem_id char(8) not null,
  mem_name varchar(10) not null,
  height	tinyint unsigned null default 160,
  phone1 	char(3) null
  
);
create table buy
( num 		int auto_increment not null primary key,
  mem_id 	char(8) not null,
  prod_name char(6) not null
);
create table goods
( goods_id		char(6) not null primary key,
  goods_name	varchar(50) not null
);

-- 외래 키 설정
alter table buy  		-- buy table 수정
add constraint	 		-- 제약 조건 추가
foreign key(mem_id)
references member(mem_id);	-- 외래키 mem_id에 설정 한다.
desc buy;
                        
alter table member 	-- member를 변경합니다.
add constraint		-- 제약 조건을 추가한다.
primary key(mem_id); -- mem id 열에 기본키 제약조건을 설정한다.

-- buy table 에 goods_id 컬럼 추가
alter table buy
add column goods_id char(6) not null;

-- mem_id, goods_id를 복합 기본키로 설정
alter table buy
-- modify column num int not null,
drop primary key,
add primary key(mem_id,goods_id,num);


insert into member values("BLK","블랙핑크",163);
insert into buy values(null,"BLK","지갑");
insert into buy values(null,"BLK","맥북");

select M.mem_id,M.mem_name,B.prod_name
	from buy B
    join member M on B.mem_id = M.mem_id;

update member set mem_id = "PINK" where mem_id = "BLK";

drop table if exists buy;
create table buy
(num		int auto_increment not null primary key,
mem_id 		char(8) not null,
prod_name 	char(6) not null
);

alter table buy
	add constraint
    foreign key(mem_id) references member(mem_id)
    on update cascade
    on delete cascade;
    
insert into member values("BLK","블랙핑크","163","pink@gmail.com");
insert into member values("TWC","트와이스","167", null);
insert into member values("APN","에이핑크","163","pink@gmail.com");

-- check 제약조건
insert into member values("BLK","블랙핑크",163,null);
insert into member values("TWC","트와이스",99, null);

select * from member;


alter table member
	add constraint
    check (phone1 IN('02','031','032','054','055','061'));
desc member;

insert into member values('TWC',"트와이스",167,"02");
insert into member values('OMY',"오마이걸",167,"010");

alter table member
	alter column phone1 set default '02';
    
insert into member values("RED","레드벨벳",161,"054");
insert into member values("SPC","우주소녀",default,default);

