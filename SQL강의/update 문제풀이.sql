-- 1. 특정 회원의 이름을 변경하기
-- mem_id가 'TWC'인 회원의 이름을 '트와이스 (TWICE)'로 변경합니다.
update member 
	set mem_name = "트와이스"
	where mem_id = "TWC";
select mem_name,mem_id from member;
 

-- 2. '서울' 지역에 거주하는 모든 회원의 평균 키를 170으로 변경하기
-- addr이 '서울'인 모든 회원의 height를 170으로 수정합니다.
update member
	set height = 170
    where addr = "서울";
select * from member
where addr = "서울";
 

-- 3. '블랙핑크'의 연락처가 NULL인 경우, 연락처 정보를 업데이트하기
-- mem_id가 'BLK'이고 phone1이 NULL인 경우, 연락처 정보를 '02', '33333333'으로 업데이트합니다.
update member
	set phone1 = '02' , phone2 = 33333333
    where mem_id = "BLK" and phone1 is null;
select * from member where mem_id = "BLK";

 

-- 4. '아이폰' 제품의 가격을 10% 인상하기
-- prod_name이 '아이폰'인 제품의 가격을 10% 인상합니다.
update buy
	set price = 200 * 1.1
	where prod_name = "아이폰";

 select * from buy;

-- 5. '디지털' 그룹의 모든 제품 수량을 2배로 증가시키기
-- group_name이 '디지털'인 모든 제품의 수량을 2배로 증가시킵니다.
update buy
	set amount = amount * 2
    where group_name = "디지털";
select * from buy where group_name = "디지털";
 

-- 6. '지갑' 제품의 가격을 40으로 설정하기
-- prod_name이 '지갑'인 모든 제품의 가격을 40으로 설정합니다.
update buy
	set amount = 40
    where prod_name = "지갑";
select * from buy where prod_name = "지갑";
 

-- 7. '소녀시대'의 '혼공SQL' 서적을 10권 더 구매한 것으로 업데이트하기
-- mem_id가 'GRL'이고 prod_name이 '혼공SQL'인 제품의 수량을 10권 더 추가합니다.
update buy
	set amount = amount + 10
    where mem_id = "GRL";
 select * from buy;

-- 8. 특정 회원의 구매 제품이 '패션'인 경우, 가격을 10% 인상하기
-- mem_id가 'MMU'이고 group_name이 '패션'인 모든 제품의 가격을 10% 인상합니다.
update buy
	set price = price * 1.1
    where mem_id = "MMU" and group_name = "패션";
 select * from buy;

-- 9. '트와이스'의 모든 구매 제품의 수량을 1로 설정하기
-- mem_id가 'TWC'인 모든 구매 제품의 수량을 1로 설정합니다.
update buy
	set amount = 1
    where mem_id = "TWC";
 

-- 10. '경남' 지역 회원의 'phone1'과 'phone2' 정보를 NULL로 설정하기
-- addr이 '경남'인 모든 회원의 phone1과 phone2를 NULL로 설정합니다.
update member
	set phone1 = "", phone2 = ""
    where addr = "경남"; 
select * from member;
 

-- 11. '서울'에 거주하는 회원이 구매한 모든 '디지털' 제품의 가격을 10% 인상하기
-- buy 테이블과 member 테이블을 mem_id를 기준으로 JOIN합니다.
-- addr가 '서울'인 회원들이 구매한 '디지털' 제품의 가격을 10% 인상합니다.
update member M
	join buy B on B.mem_id = M.mem_id 
    set B.price = B.price * 1.1
    where M.addr = "경기" and B.group_name = "디지털";
 
 select * from member
 join buy
 where addr = "경기" and group_name = "디지털";
 select * from buy;

-- 12. '블랙핑크'가 구매한 모든 제품의 수량을 2배로 증가시키기
update buy
	set amount = amount*2
    where mem_id = "BLK";
select * from buy;

select * from member;