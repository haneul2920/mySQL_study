use market_db2;
drop procedure if exists cursor_proc;
delimiter //
create procedure cursor_proc()
begin
	declare memNumber int;
    declare cnt int default 0;
    declare totNumber int default 0;
    declare endOfRow boolean default false;
    
    declare memberCursor cursor for
		select mem_number from member;
        
	declare continue handler
		for not found set endOfRow = true;
        
	open memberCursor;
    
    cursor_loop : loop
		fetch memberCursor into memNumber;
        
        if endOfRow then
			leave cursor_loop;
		end if;
        
        set cnt = cnt + 1;
        set totNumber = totNumber + memNumber;
	end loop cursor_loop;
    
    select (totNumber/cnt) as '회원의 평균 인원수';
    
    close memberCursor;
end //
delimiter ;

call cursor_proc();