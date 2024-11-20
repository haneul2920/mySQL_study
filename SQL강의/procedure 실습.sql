drop procedure if exists ifProc1;
delimiter //
create procedure ifProc1()
begin
	if 100 = 100 then
		select '100은 100과 같습니다.';
	end if;
end //
delimiter ;
call ifProc1();

drop procedure if exists ifProc2;
delimiter //
create procedure ifProc2()
begin
	declare myNum int;
    set myNum = 200;
    if myNum = 100 then
		select '100입니다.';
	else 
		select '100이 아닙니다.';
	end if;
end //
delimiter ;
call ifProc2();

drop procedure if exists ifProc3;
delimiter //
create procedure ifProc3()
begin
	declare debutDate date;
    declare curDate date;
    declare days int;
    select debut_date into debutDate
		from market_db.member
        where mem_id = 'APN';
        
	set curDate = current_date();
    set days = datediff(curDate,debutDate);
    
    if(days/365) >= 5 then 
		select concat('데뷔한 지',days,'일이나 지났습니다. 핑순이들 축하합니다!');
	else
		select '데뷔한 지'+days+'일밖에 안되었네요. 핑순이들 화이팅~';
	end if;
end //
delimiter ;
call ifProc3();

drop procedure if exists caseproc;
delimiter //
create procedure caseproc()
begin
	declare point int ;
    declare credit char(1);
    set point = 88;
    
    case
		when point >= 90 then
			set credit = 'A';
		when point >= 80 then
			set credit = 'B';
		when point >= 70 then
			set credit = 'C';
		when point >= 60 then
			set credit = 'D';
		when point >= 50 then
			set credit = 'F';
	end case;
    select concat('취득점수==>',point),concat('학점==>',credit);
end //
delimiter ;
call caseproc;

select mem_id, sum(price*amount) "총구매액"
	from buy
    group by mem_id;
    
select mem_id, sum(price*amount)"총구매액"
	from buy
    group by mem_id
    order by sum(price*amount) desc;
    
    
select B.mem_id,M.mem_id,sum(price*amount) "총구매액"
	from buy B
    join member M on M.mem_id = B.mem_id
    group by B.mem_id
    order by sum(price*amount)desc;
    
select M.mem_id,M.mem_name,sum(price*amount)"총구매액"
	from buy B
		right outer join member M
        on B.mem_id = M.mem_id
        group by M.mem_id
        order by sum(price*amount)desc;
        
select M.mem_id,M.mem_name, sum(price*amount) "총구매액",
	case
		when (sum(price*amount) >= 1500) then '최우수고객'
        when (sum(price*amount) >= 1000) then '우수고객'
        when (sum(price*amount) >= 1) then '일반고객'
        else '유령고객'
	end "회원등급"
from buy B
	right join member M on M.mem_id = B.mem_id
    group by M.mem_id
    order by sum(price*amount)desc;
    
drop procedure if exists whileproc;
delimiter //
create procedure whileproc()
begin
	declare i int;
    declare hap int;
    set i = 1;
    set hap = 0;
    
    while (i <= 100) do
		set hap = hap + i;
        set i = i + 1;
	end while;
    select '1부터 100까지의 합 ==>',hap;
end // 
delimiter ;
call whileproc();

drop procedure if exists whileproc2;
delimiter //
create procedure whileproc2()
begin
	declare i int;
    declare hap int;
    set i = 1;
    set hap = 0;
    
    myWhile:
    while (i <= 100) do
		if (i%4 = 0)then
			set i = i+1;
            iterate myWhile;
		end if;
        set hap = hap + i ;
        if (hap > 1000) then
			leave myWhile;
		end if;
        set i = i + 1;
	end while;
    
    select '1부터 100까지의 합(4의 배수 제외), 1000 넘으면 종료 ==>',hap;
end//
delimiter ;
call whilerproc2();

prepare myQuery from 'select * from member where mem_id = "BLK"';
execute myQuery;
deallocate prepare muQuery;

drop table if exists gate_table;
create table gate_table (id int auto_increment primary key, entry_time datetime);

set @surdate = current_timestamp();

prepare myQuery from 'insert into gate_table values(null,?)';
execute myQuery using @curdate;
deallocate prepare myQuery;

select * from gate_table;



    