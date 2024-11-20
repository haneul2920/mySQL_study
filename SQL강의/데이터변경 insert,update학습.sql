use market_db;
create table hongong1 (toy_id int , toy_name char(4),age int);
insert into hongong1 values (1, '우디', 25);
insert into hongong1 (toy_id,toy_name) values (2,'버즈');
insert into hongong1 (toy_name, age , toy_id ) values ('제시', 20, 3);
select * from hongong1;
create table hongong2 ( toy_id int auto_increment primary key,
						toy_name char(4),
                        age int);
insert into hongong2 values (null,'보핍',25);
insert into hongong2 (toy_name,age) values ('슬링키',22);
insert into hongong2 (toy_name,age)values ('렉스',21);
insert into hongong2 (toy_name,age)values ('렉스2',22),('렉스3',23),('렉스4',24),('렉스5',25);
select last_insert_id();

alter table hongong2 auto_increment=100;
insert into hongong2 values (null,"재남",35);

create table hongong3 (toy_id int auto_increment primary key,
						toy_name char (4),
                        age int );
alter table hongong3 auto_increment = 1000;
set @@auto_increment_increment=3;
insert into hongong3 value (null, "토마스", 20);
insert into hongong3 value (null, "제임스", 23);
insert into hongong3 value (null, "고든", 25);
select * from hongong3;
select count(*) from world.city;
desc world.city;
select * from world.city limit 5;
desc world.city;



use market_db;
create table city_popul(city_name char(35),population int);
select * from city_popul;
insert into city_popul
	select name,population from world.city;
select * from city_popul;
update city_popul
	set city_name = "서울"
    where city_name = "seoul";
select * from city_popul where city_name = "서울";

update city_popul
	set city_name = "뉴욕", population = 0
    where city_name = "new york";
    
select * from city_popul
where city_name = "뉴욕";
select * from city_popul;