use market_db;
create table if not exists trigger_table (id int , txt varchar(10));
insert into trigger_table values(1, '레드벨벳');
insert into trigger_table values(2, '잇지');
insert into trigger_table values(3, '블랙핑크');
select * from trigger_table;

drop trigger if exists myTrigger;

-- 트리거를 테이블(trigger_table)에 부착
delimiter //
create trigger myTrigger -- 트리거 이름
	after delete		 -- 작업발생(삭제)
    on trigger_table	 -- 트리거를 부착할 테이블
    for each row		 -- 각행(row) 마다 적용
begin
	set @msg = '가수 그룹이 삭제됨';	-- 트리거 발생 시 작동되는 코드
end //
delimiter ;

set @msg = ' ';
insert into trigger_table values(4,'마마무');
select @msg;
update trigger_table set txt = '블핑' where id = 3;
select @msg;

delete from trigger_table where id = 4;
select @msg;

select * from trigger_table;
select * from member;
use market_db2;
create table singer (select mem_id, mem_name, mem_number, addr from member);

create table backup_singer(
	mem_id 			char(8) not null,
    mem_name 		varchar(10) not null,
    mem_number 		int not null,
    addr 			char(2) not null,
    modtype 		char(2), -- 변경됨 타입 '수정' 또는 '삭제'
    moddate			date, -- 변경된 날짜
    moduser 		varchar(30) -- 변경한 사용자
    );
    
drop trigger if exists singer_updateTrg;
delimiter //
create trigger singer_updateTrg 
	after update
    on singer
    for each row
begin
	insert into backup_singer values(old.mem_id, old.mem_name, old.mem_number, old.addr, '수정',curdate(), current_user());
end //
delimiter ;

drop trigger if exists singer_deleteTrg;
delimiter //
create trigger singer_deleteTrg
	after delete
    on singer
    for each row
begin
	insert into backup_singer values(old.mem_id, old.mem_name, old.mem_number, old.addr, '삭제', curdate(), current_user());
end //
delimiter ;


update singer set addr = '영국' where mem_id = 'BLK';
delete from singer where mem_number >=7;

select * from backup_singer;

select * from member;

use gametournamentdb;
select * from player_health;
select * from player_info;


-- 트리거 활용 문제1.
-- player_id 가 3인 선수가 몸무게가 75로 수정 했다
-- 이때 player_info도 수정이 되도록 트리거를 만드시오.
create table backUp_player_health(
	player_id INT PRIMARY KEY, 

    height_cm INT NOT NULL, 

    weight_kg INT NOT NULL,

    age_years INT NOT NULL  
    );
    
drop trigger if exists player_update;
delimiter //
create trigger player_update
	after update
    on player_health
    for each row
begin
	update player_info 
    set weight = new.weight_kg where new.player_id = 3;    
end //
delimiter ;

update player_health 
set weight_kg = 75 where player_id = 3;
