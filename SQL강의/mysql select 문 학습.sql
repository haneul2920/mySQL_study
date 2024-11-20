-- member 테이블의 전체 내용을 본다.
use market_db;

select * from member;

select count(*) '회원 데이터 수' from member;

select mem_number, count(*) "걸그룹 수" from member
group by mem_number;

--  정렬 : 오름차순 asc. 내림차순 desc
-- 걸그룹의 이름을 가나다 순으로 정렬
select * from member order by mem_name asc;

--  5개 까지만 보고 싶은 경우. limit
select * from member limit 5;
select * from member order by mem_name asc limit 3,5; -- 4번째 부터 5개까지 보여줌

select mem_name from member;

-- 걸그룹명, 걸그룹 지역, 데뷔일자를 컬럼명으로 변경해서 출력하시요.
select mem_name '걸그룹명', addr "지역", debut_date '데뷔일자' from member;

-- 블랙핑크라는 이름을 가진 걸그룹의 데이터 전부를 보고싶다.
select * from member
where mem_name = '블랙핑크';

-- 경남지역의 걸그룹 데티어를 보고싶다.
select * from member
where  addr = '경남';

-- 걸그룹 키가 165 이상인 맴버를 보고 싶다.
select * from member
where height >= 165;

--  맴버수가 6명 이상인 걸그룹을 보고 싶다.
select * from member
where mem_number > 6;

-- 키가 165 이상이고 맴버수가 6명 이상인 걸릅을 보고싶다.
select * from member
where height >= 165 and mem_number > 6;

-- 키가 165 이상이거나 맴버수가 6명 이상인 걸그룹
select * from member
where height >= 165 or mem_number > 6;

-- 키가 163에서 165 까지의 걸그룹
select * from member
where height between 163 and 165; 

-- 걸그룹의 맴버수가 5명 이상 걸그룹
select mem_number "맴버수", count(*) from member
group by mem_number
having mem_number >= 5;

-- 경기, 전남, 경남 지역의 걸그룹 이름과 주소
select mem_name,addr from member where addr = "경기";
select mem_name,addr from member where addr = "전남";
select mem_name,addr from member where addr = "경남";
-- or 활용
select mem_name,addr from member 
where addr = "경기"
	or addr = "전남" 
    or addr = "경남";
-- in 활용
select mem_name,addr from member 
where addr in('경기','전남','경남');

-- like
select * from member
where mem_name like "우%";

select * from member
where mem_name like "%크";

select * from member
where mem_name like "%이%";


