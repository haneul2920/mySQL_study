use productionmanagement_db;
select * from staff;

-- 백업 테이블을 하나 만들어 특정 테이블이 변경시 백업 테이블에 저장되게 하시오.
drop table if exists staffBackupTable;
create table staffBackupTable(
	staff_code				VARCHAR(20) NOT NULL , 
	manager           	    VARCHAR(20) NULL , 
	staff_name				VARCHAR(50) NULL , 
	staff_age				INT NULL ,
	staff_sex				VARCHAR(2) NULL ,
	staff_addr				VARCHAR(1000) NULL ,
	staff_ponenumber		VARCHAR(13) NULL , 
	dept_code				VARCHAR(20) NOT NULL ,
	staff_rank				VARCHAR(20) NULL ,
    modtype					char(2),
    moddate					date,
    moduser					varchar(30)
);

drop trigger if exists staff_updateTrg;
delimiter //
create trigger staff_updateTrg
	after update
    on staff
    for each row
begin
	insert into staffBackUpTable values (old.staff_code, old.manager, old.staff_name, old.staff_age, old.staff_sex, old.staff_addr, old.staff_ponenumber, old.dept_code, old.staff_rank
											, '수정', curdate(), current_user());    
end //
delimiter ;
select * from staffBackupTable;
update staff set staff_addr = "충청북도 청주시" where staff_name = "김준혁";
