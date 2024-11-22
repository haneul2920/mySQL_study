use market_db2;
create table cluster
(mem_id		char(8),
mem_name	varchar(10)
);
insert into cluster values('TWC','트와이스');
insert into cluster values('BLK','블랙핑크');
insert into cluster values('WMN','여자친구');
insert into cluster values('OMY','오마이걸');
insert into cluster values('GRL','걸스데이');
insert into cluster values('ITZ','잇지');
insert into cluster values('RED','레드벨벳');
insert into cluster values('APN','에이핑크');
insert into cluster values('SPC','우주소녀');
insert into cluster values('MMU','마마무');

select * from cluster;

alter table cluster
	add constraint
    primary key(mem_id);
    
create table second
(mem_id		char(8),
mem_name	varchar(10)
);
insert into second values('TWC','트와이스');
insert into second values('BLK','블랙핑크');
insert into second values('WMN','여자친구');
insert into second values('OMY','오마이걸');
insert into second values('GRL','걸스데이');
insert into second values('ITZ','잇지');
insert into second values('RED','레드벨벳');
insert into second values('APN','에이핑크');
insert into second values('SPC','우주소녀');
insert into second values('MMU','마마무');

select * from second;

alter table second
	add constraint
    unique (mem_id);
    
select * from member;

-- 인덱스 확인
show index from member;

-- 인덱스의 크기 확인 : Data_length(클러스터형 인덱스의 크기), Index_length(보조 인덱스의 크기)
show table status like 'member';

-- 보조인덱스 생성
create index idx_member_addr on member(addr);

show index from member;

-- 보조인덱스 적용하기
analyze table member;

-- 데이터가 중복을 허용하지 않는 보조 인덱스 생성
create unique index idx_mamber_number on member(mem_number);

select * from member;
create unique index idx_member_name on member(mem_name);

show index from member;

desc member;

insert into member values ('MOO','마마무',9,"태국");

-- 인덱스를 활용 하려면 where를 사용 해야한다.
select mem_id, mem_name, addr from member
where mem_name = '소녀시대';