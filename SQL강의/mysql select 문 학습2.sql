USE market_db;

-- ORDER BY
SELECT mem_id, mem_name, debut_date
	FROM member
	ORDER BY debut_date;
    
SELECT mem_id, mem_name, debut_date, height
	FROM member
	WHERE height >= 164
    ORDER BY height desc,debut_date asc;
    
-- LIMIT 활용 : 키가 큰순으로 정렬하되, 3번째 부터 2건만 조회
SELECT mem_name,height
	FROM member
    ORDER BY height desc
    LIMIT 3,2;
    
-- DISTINCT : 중복제거
SELECT * FROM member;
SELECT addr FROM member ORDER BY addr;
SELECT DISTINCT addr FROM member;

-- GROUP BY
SELECT * FROM BUY;
SELECT mem_id, amount "구매수량"
	FROM buy 
    ORDER BY mem_id;

-- SUM
SELECT mem_id, SUM(amount) 
	FROM buy
    GROUP BY mem_id;

-- AVG
SELECT AVG(amount) FROM buy; -- 전체 평군
SELECT SUM(amount) FROM buy; -- 전체 합

-- COUNT
SELECT * FROM member;
SELECT COUNT(*) FROM member;
SELECT COUNT(phone1) FROM member; -- null 값은 카운트에 미포함

-- HAVING
SELECT * FROM buy;
SELECT mem_id "회원 아이디", SUM(price*amount) "구매 금액"
	FROM buy
    GROUP BY mem_id
    HAVING SUM(price*amount) > 1000
    ORDER BY SUM(price*amount) DESC;