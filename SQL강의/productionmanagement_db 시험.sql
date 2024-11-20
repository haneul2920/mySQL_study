USE productionmanagement_db;

delimiter //
create procedure partData(in num_records int)
begin
	DECLARE i INT DEFAULT 1;
    declare part_id int;
    declare v_part_code varchar(20);
    declare v_part_name varchar(40);
   
   part_loop: loop
   
	set part_id = i ;
    set v_part_code = concat('part',i);
    set v_part_name = concat('partname',i);
    
    insert into part (part_code,part_name) values (v_part_code,v_part_name);
    
    set i = i + 1;
    
    IF i > num_records THEN
		LEAVE part_loop;
	END IF;  
   
   end loop;    
    
end //
delimiter ;
call partData(20);
select * from part;

drop procedure if exists prodoctData;
delimiter //
create procedure prodoctData(in num_records int)
begin
	DECLARE i INT DEFAULT 1;
    declare product_id int;
    declare v_staff_code VARCHAR(20); 
	declare v_product_code varchar(20);
    declare v_product_name varchar(40);
    declare v_product_price int;
    declare v_equipment_code VARCHAR(20);
    
    product_loop: loop
    select staff_code into v_staff_code from staff order by rand() limit 1;
    select equipment_code into v_equipment_code from equipment order by rand() limit 1;
    
    set product_id = i;
    set v_product_code = concat(i);
    set v_product_name = concat('APDHN',i);
    set v_product_price = floor(4000000 + (rand() * 8000000));
    
    
    insert into product (equipment_code, staff_code,product_code, product_name, product_price) values (v_equipment_code,v_staff_code,v_product_code, v_product_name, v_product_price);
    
    
    set i = i + 1;
    
    
    IF i > num_records THEN
			LEAVE product_loop;
	END IF;
    
    end loop;
	
end //
delimiter ;
call prodoctData(30);
select * from product;

drop procedure if exists manufacturedatas;
delimiter //
create procedure manufacturedatas(in num_records int)
begin
	DECLARE i INT DEFAULT 1;
    declare manufacture_id int;
    declare v_manufacture_code int;
    declare v_manufacture_date date;
    declare v_product_code VARCHAR(20);
    declare v_part_code VARCHAR(20);
    declare v_manufacture_quantity INT;
    
    manufacturedata_loop: loop
    select product_code into v_product_code from product order by rand() limit 1;
    select part_code into v_part_code from part order by rand() limit 1;
    
    set manufacture_id = i;
    set v_manufacture_code = concat(i);
    set v_manufacture_date = DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * DATEDIFF('2023-12-31', '2020-01-01')) DAY);
    set v_manufacture_quantity = floor(1 +(rand() * 30));
    
    insert into manufacture (manufacture_code, manufacture_date, product_code, part_code, manufacture_quantity) values (v_manufacture_code, v_manufacture_date, v_product_code, v_part_code, v_manufacture_quantity);
	set i = i + 1;
    
    if i > num_records then
		LEAVE manufacturedata_loop;
	END IF;
		
	end loop;

end //
delimiter ;

call manufacturedatas(80000);
select * from manufacture;