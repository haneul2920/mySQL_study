drop table sales;

CREATE TABLE sales (
   id INT AUTO_INCREMENT PRIMARY KEY,
   salesperson VARCHAR(50),
   region VARCHAR(50),
   month VARCHAR(10),
   sales_amount DECIMAL(10, 2)
);

INSERT INTO sales (salesperson, region, month, sales_amount) VALUES
('Alice', 'East', 'January', 5000.00),
('Bob', 'West', 'January', 7000.00),
('Charlie', 'East', 'January', 6000.00),
('Diana', 'North', 'January', 9000.00),
('Eve', 'South', 'January', 4000.00),
('Alice', 'East', 'February', 5500.00),
('Bob', 'West', 'February', 8000.00),
('Charlie', 'East', 'February', 6500.00),
('Diana', 'North', 'February', 9200.00),
('Eve', 'South', 'February', 4500.00);

SELECT * FROM SALES;
 

-- 1. 전체 월의 총 판매 금액으로 판매원 순위
SELECT 
   salesperson,
   SUM(sales_amount) AS total_sales,
   RANK() OVER (ORDER BY SUM(sales_amount) DESC) AS sales_rank
FROM sales
GROUP BY salesperson;

-- 2. 1월에 각 지역별 판매 금액 순위
SELECT 
   salesperson,
   region,
   sales_amount,
   RANK() OVER (PARTITION BY region ORDER BY sales_amount DESC) AS rank_in_region
FROM sales
WHERE month = 'January';

-- 3. 월별 판매 금액 순위 (동일 금액 포함)
SELECT 
   salesperson,
   month,
   sales_amount,
   RANK() OVER (PARTITION BY month ORDER BY sales_amount DESC) AS monthly_rank
FROM sales;

-- 4. 모든 월의 지역별 판매원 순위
SELECT 
   salesperson,
   region,
   SUM(sales_amount) AS total_sales,
   RANK() OVER (PARTITION BY region ORDER BY SUM(sales_amount) DESC) AS regional_rank
FROM sales
GROUP BY salesperson, region;

-- 5. 판매 금액에 따른 내림차순 전체 순위
SELECT 
   id,
   salesperson,
   month,
   sales_amount,
   RANK() OVER (ORDER BY sales_amount DESC) AS sales_rank
FROM sales;

 

-- ---------예제 ----------------------------

-- 문제 1: 각 월에 판매 금액이 높은 상위 3명의 판매원
-- 설명: 각 월별로 판매 금액이 높은 상위 3명의 판매원을 순위와 함께 조회하세요.
-- 힌트: RANK()를 사용하여 월별로 순위를 매기고, WHERE 조건을 추가해 상위 3명만 선택합니다.

WITH MonthlyRank AS (
   SELECT 
       salesperson,
       month,
       sales_amount,
       RANK() OVER(PARTITION BY MONTH ORDER BY sales_amount DESC) AS monthly_rank
   FROM sales
)
SELECT *
FROM MonthlyRank
WHERE monthly_rank <= 3;

 

-- 문제 2: 전체 기간 동안 각 지역별 최상위 판매원 조회
-- 설명: 각 지역에서 가장 높은 총 판매 금액을 기록한 판매원과 해당 금액을 조회하세요.
-- 힌트: RANK()와 PARTITION BY를 사용하여 지역별 총 판매 금액을 기준으로 순위를 매기고, 1위만 선택합니다.

WITH RegionalSales AS (
   SELECT 
      salesperson,

      region,
       SUM(sales_amount) AS total_sales,
       RANK() OVER (PARTITION BY region order by SUM(sales_amount) DESC)  AS regional_rank
   FROM sales
   GROUP BY salesperson, region
)
SELECT *
FROM RegionalSales
WHERE regional_rank = 1;
select * FROM sales;
 

-- 문제 3: 특정 월의 판매 금액 순위와 총 판매 금액 순위 비교
-- 설명: 2월의 판매 금액 순위와 전체 기간 동안의 총 판매 금액 순위를 모두 조회하세요.
-- 힌트: 서브쿼리를 사용하여 월별 순위와 전체 순위를 함께 계산합니다.
WITH TotalSales AS (
   SELECT 
       salesperson,
       SUM(sales_amount) AS total_sales,
       RANK() OVER (ORDER BY SUM(sales_amount) DESC) AS total_sales_rank
   FROM sales
   GROUP BY salesperson
),
FebruarySales AS (
   SELECT 
       salesperson,
       sales_amount AS february_sales,
       RANK() OVER (ORDER BY sales_amount DESC) AS february_rank
   FROM sales
   WHERE month = 'February'
)
SELECT 
   t.salesperson,
   t.total_sales,
   t.total_sales_rank,
   f.february_sales,
   f.february_rank
FROM TotalSales t
JOIN FebruarySales F ON T.SALESPERSON = F.SALESPERSON;



-- 문제 4: 각 판매원의 전체 판매 금액에 따른 순위와 최근 월 판매 금액 순위 조회
-- 설명: 각 판매원의 전체 기간 동안 총 판매 금액 순위와 가장 최근 월(2월)의 판매 금액 순위를 조회하세요.
-- 힌트: RANK()와 조건을 사용하여 전체 기간 순위와 특정 월 순위를 결합하여 조회합니다.
SELECT * FROM sales;

WITH TotalSalesRank AS (
   SELECT 
       salesperson,
       SUM(sales_amount) AS total_sales,
       RANK() OVER (ORDER BY SUM(sales_amount) DESC) AS total_sales_rank
   FROM sales
   GROUP BY salesperson
),
FebruaryRank AS (
   SELECT 
       salesperson,
       sales_amount AS february_sales,
       RANK() OVER (ORDER BY sales_amount DESC) AS february_rank
   FROM sales
   WHERE month = 'February'
)
SELECT 
   t.salesperson,
   t.total_sales,
   t.total_sales_rank,
   f.february_sales,
   f.february_rank
FROM TotalSalesRank t
LEFT JOIN FebruaryRank f ON t.salesperson = f.salesperson;

 

-- 문제 5: 지역별 월간 최고 판매 기록자와 그 순위
-- 설명: 각 지역에서 월별 최고 판매 금액을 기록한 판매원의 이름과 그 금액을 조회하세요.
-- 힌트: PARTITION BY region, month를 사용하여 지역과 월별로 그룹화하여 최고 판매 금액을 계산합니다.

WITH RegionalMonthlyRank AS (
   SELECT 
       salesperson,
       region,
       month,
       sales_amount,
       RANK() OVER (PARTITION BY region ORDER BY sales_amount DESC) AS rank_in_region_month
   FROM sales
)
SELECT *
FROM RegionalMonthlyRank
WHERE rank_in_region_month = 1;

 