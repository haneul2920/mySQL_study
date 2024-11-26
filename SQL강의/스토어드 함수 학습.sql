-- 스토어드 함수

delimiter //
create function 함수명
		returns 반환형식
begin
		프로그램 코딩
		return 반환값;
        
end //
delimiter ;
select 함수명();

use market_db2;
select * from member;

-- mysql 함수 권한 열기
set global log_bin_trust_function_creators = 1;

-- 숫자 2개의 합을 리턴하는 스토어드 함수
drop function if exists sumFunc;
delimiter //
create function sumFunc(number1 int, number2 int )
	returns int 
begin
	return number1 + number2;
end //
delimiter ;

select sumFunc(100, 200) as '합계';

-- 데뷔연도를 입력 하면 활동기간이 얼마나 되었는지 출력해주는 함수
drop function if exists calcYaerFunc;
delimiter //
create function calcYearFunc(dYear int)
	returns int
begin
	declare runYear int; -- 활동기간(연도)
    set runYear = year(curdate()) - dyear;
    return runYear;
end //
delimiter ;

select calcYearFunc(2010) as '활동 햇수';

-- 2013 ~ 2007 까지의 차이는
select calcYearFunc(2007) into @debut2007;
select calcYearFunc(2013) into @debut2013;
select @debut2007 - @debut2013 as '2007년과 2013년의 차이';

select mem_id, mem_name, calcYearFunc(year(debut_date)) as '활동 햇수' from member;


-- 함수 내용 확인(소스)
show create function calcYearFunc;