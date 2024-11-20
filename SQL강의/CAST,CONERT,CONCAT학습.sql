use market_db;

-- SELECT CONVERT(AVG(price),SIGNED)"평균가격" FROM buy;
-- 또는
SELECT CAST(AVG(price) AS SIGNED)"평균가격" FROM buy;

SELECT * FROM MEMBER;
SELECT CONVERT(debut_date, DATE)"날짜" FROM MEMBER;
SELECT CAST("2022/04/10" AS DATE)"날짜";


SELECT num,price "가격", amount "수량", CONCAT(CAST(price AS CHAR), ' X ', CAST(amount AS CHAR), " =")"가격 X 수량",price * amount "구매액" FROM buy;

SELECT '100'+'200';
SELECT CONCAT('100','200');
SELECT 100 + '200';
SELECT CONCAT(100,'200');