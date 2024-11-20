-- view : 가상의 테이블
use market_db2;

select mem_id,mem_name,addr from member;

create view v_member as 
	select mem_id,mem_name,addr from member;
    
select * from v_member
	where addr in("서울","경기");
    
select B.mem_id, M.mem_name, B.prod_name, M.addr, concat(M.phone1,M.phone2)"연락처"
	from buy B
    join member M on M.mem_id = B.mem_id;
    
create view v_memberbuy as
	select B.mem_id, M.mem_name, B.prod_name, M.addr, concat(M.phone1,M.phone2)"연락처"
	from buy B
    join member M on M.mem_id = B.mem_id;
    
select * from v_memberbuy
	where mem_name = "블랙핑크";

create view v_viewtest1 as 
	select B.mem_id "member ID", M.mem_name as "member name",
    B.prod_name "product name", concat(M.phone1,M.phone2)as"Office phone"
    from buy B
    join member M on B.mem_id = M.mem_id;
    
select distinct `member ID`,`member name` from v_viewtest1;

alter view v_viewtest1 as
	select B.mem_id "회원 아이디", M.mem_name as "회원 이름",
    B.prod_name "제품이름", concat(M.phone1,M.phone2)as"연락처"
    from buy B
    join member M on B.mem_id = M.mem_id;
    
select distinct `회원 아이디`,`회원 이름` from v_viewtest1;

desc member;

show create view v_viewtest1;

desc member;

show index from member;

drop table if exists buy, member;
create table member(
mem_id 			char(8),
mem_name		varchar(10),
mem_number		int,
addr 			char(2)
);

insert into member values ('TWC',"트와이스",9,'서울');
insert into member values ('BLK',"블랙핑크",4,'경남');
insert into member values ('WHN',"여자친구",6,'경기');
insert into member values ('OMY',"오마이걸",7,'서울');

alter table member 
	add constraint 
    primary key(mem_id);

alter table member 
	drop primary key;
    
alter table member
	add constraint
    primary key(mem_name);
insert into member values("GRL","소녀시대",8,"서울");
drop table if exists member;
create table member(
 mem_id 	char(8),
 mem_name 	varchar(10),
 mem_number	int,
 addr		char(2)
 );
 
insert into member values('TWC', '트와이스', 9, "서울");
insert into member values('BLK', '블랙핑크', 4, "경남");
insert into member values('WMN', '여자친구', 6, "경기");
insert into member values('OMY', '오마이걸', 7, "서울");
 
select * from member;

alter table member
	add constraint
    unique(mem_id); -- 보조 인덱스 설정
desc member;

alter table member
	add constraint
	unique(mem_name);
    
insert into member values("GRL","소녀시대",8,"서울");

drop procedure if exists uesr_proc;
delimiter $$
create procedure user_proc()
begin
	select * from member;
end $$
delimiter ;

call user_proc();

drop procedure if exists user_proc1;
delimiter $$
create procedure user_proc1(in nsername varchar(10))
begin
	select * from member where mem_name = username;
end $$
delimiter ;

call user_proc1('에이핑크');

drop procedure if exists user_proc2;
delimiter //
create procedure user_proc2(
in userNumber int,
in userHeight int )
begin
	select * from member
		where mem_number > userNumber AND height > userHeight;
end //
delimiter ;

call user_proc2(6,165);

drop procedure if exists user_proc3;
delimiter //
create procedure user_proc3(
in txtValue char(10),
out outvalue INT
)
begin
	insert into notable values(null, txtvalue);
    select max(id) into outvalue from notable;
end //
delimiter ;
desc notable;

-- 가수 그룹의 데뷔 연도가 2015년 이전이면 '고장 가수', 2015년 이후(2015포함) 이면 '신인가수'출력
drop procedure if exists ifelse_proc;
delimiter //
create procedure ifelse_proc(
	in memName varchar(10)
    )
begin
	declare debutyear int; -- 변수선언
    select year(debut_date) into debutYear from member
    where mem_name = memName;
    if (debutYear >= 2015) then
		select '신인 가수네요. 화이팅 하세요.' as '메세지';
	else
		select '고참 가수네요. 그동안 수고하셨어요.' as '메세지';
	end if;
end //
delimiter ;
use market_db2;
select * from member;
call ifelse_proc ('오마이걸');

-- 1부터 100까지의 합계 계산
drop procedure if exists while_proc;
delimiter //
create procedure while_proc()
begin
	declare hap int;
    declare num int;
    set hap = 0;
    set num = 1;
    
    while ( num <= 100)do
		set hap = hap + num;
		set num = num + 1;
    end while;
    select hap as '1~100합계';
end //
delimiter ;

call while_proc();

-- 동적 SQL
drop procedure if exists dynamic_proc;
delimiter //
create procedure dynamic_proc(in tableName varchar(20))
begin
	set @sqlQuery = concat("select = from", tableName);
    prepare myQuery from @sqlQuery;		-- 준비
    execute myQuery;					-- 실행
    deallocate prepare myQuery;			-- 사용한 myQuery 해제
end //
delimiter ;

call dynamic_proc ('member');