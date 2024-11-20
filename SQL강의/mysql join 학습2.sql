use market_db;

select buy.mem_id, mem_name, prod_name, amount, price * amount "사용금액" 
	from buy
	inner join member
    on buy.mem_id = member.mem_id
where buy.mem_id = "grl";

-- 별칭으로

select B.mem_id, M.mem_name, B.prod_name, M.addr, 
	concat(M.phone1, M.phone2) "연락처"
	from buy B
	inner join member M
    on B.mem_id = M.mem_id;

-- distinct 활용 중복 제거
select distinct M.mem_id, M.mem_name, M.addr
	from buy B
	inner join member M
    on B.mem_id = M.mem_id
    order by M.mem_id;    
    

-- 외부 조인
select * from member;
select * from buy;

select M.mem_id, M.mem_name, B.prod_name, M.addr
	from member M
	left outer join buy B
    on M.mem_id = B.mem_id
    order by M.mem_id;
    
select M.mem_id, M.mem_name, B.prod_name, M.addr
	from buy B
    right outer join member M
    on M.mem_id = B.mem_id
    order by M.mem_id;