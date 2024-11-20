-- 여행 DB

drop DATABASE TravelDB;
CREATE DATABASE TravelDB;
USE TravelDB;

 

CREATE TABLE Cities (
   city_id INT PRIMARY KEY AUTO_INCREMENT,
   city_name VARCHAR(50) NOT NULL,
   country VARCHAR(50)
);

-- Cities 데이터
INSERT INTO Cities (city_name, country) VALUES
('서울', '한국'),
('부산', '한국'),
('제주', '한국'),
('강릉', '한국'),
('대구', '한국');
 

CREATE TABLE Locations (
   location_id INT PRIMARY KEY AUTO_INCREMENT,
   location_name VARCHAR(50) NOT NULL,
   city_id INT,
   FOREIGN KEY (city_id) REFERENCES Cities(city_id)
);

-- Locations 데이터
INSERT INTO Locations (location_name, city_id) VALUES
('남산 타워', 1),
('해운대 해수욕장', 2),
('성산 일출봉', 3),
('경포대', 4),
('수성못', 5),
('북촌 한옥마을', 1),
('광안리 해변', 2),
('용두암', 3),
('오죽헌', 4),
('팔공산', 5);
 

CREATE TABLE Restaurants (
   restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
   restaurant_name VARCHAR(50) NOT NULL,
   city_id INT,
   is_popular BOOLEAN DEFAULT FALSE,
   FOREIGN KEY (city_id) REFERENCES Cities(city_id)
);

-- Restaurants 데이터 (맛집 5곳 포함)
INSERT INTO Restaurants (restaurant_name, city_id, is_popular) VALUES
('미스터 김밥', 1, FALSE),
('부산 밀면집', 2, TRUE),
('제주 갈치조림', 3, TRUE),
('강릉 초당두부', 4, TRUE),
('대구 막창', 5, TRUE),
('서울 설렁탕집', 1, TRUE),
('광안리 회센터', 2, FALSE),
('한라산 순대국밥', 3, FALSE),
('서울 떡볶이집', 1, FALSE),
('수성못 오리백숙', 5, FALSE);
 

CREATE TABLE Accommodations (
   accommodation_id INT PRIMARY KEY AUTO_INCREMENT,
   accommodation_name VARCHAR(50) NOT NULL,
   location_id INT,
   FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

-- Accommodations 데이터
INSERT INTO Accommodations (accommodation_name, location_id) VALUES
('서울 호텔', 1),
('부산 리조트', 2),
('제주 펜션', 3),
('강릉 모텔', 4),
('대구 게스트하우스', 5),
('북촌 민박', 6),
('해운대 비치호텔', 2),
('성산 게스트하우스', 3),
('광안리 호텔', 7),
('제주 힐링 하우스', 3);
 

CREATE TABLE Travelers (
   traveler_id INT PRIMARY KEY AUTO_INCREMENT,
   traveler_name VARCHAR(50) NOT NULL
);

-- Travelers 데이터
INSERT INTO Travelers (traveler_name) VALUES
('김철수'),
('박영희'),
('이민수'),
('최수정'),
('장하나');
 

CREATE TABLE Trips (
   trip_id INT PRIMARY KEY AUTO_INCREMENT,
   traveler_id INT,
   location_id INT,
   accommodation_id INT,
   trip_date DATE,
   FOREIGN KEY (traveler_id) REFERENCES Travelers(traveler_id),
   FOREIGN KEY (location_id) REFERENCES Locations(location_id),
   FOREIGN KEY (accommodation_id) REFERENCES Accommodations(accommodation_id)
);

-- Trips 데이터 (여행 기록)
INSERT INTO Trips (traveler_id, location_id, accommodation_id, trip_date) VALUES
(1, 1, 1, '2023-01-15'),
(2, 2, 2, '2023-02-20'),
(3, 3, 3, '2023-03-12'),
(4, 4, 4, '2023-04-10'),
(5, 5, 5, '2023-05-25'),
(1, 6, 6, '2023-06-18'),
(2, 7, 2, '2023-07-05'),
(3, 8, 3, '2023-08-14'),
(4, 9, 4, '2023-09-10'),
(5, 10, 5, '2023-10-11');
 

CREATE TABLE RestaurantVisits (
   visit_id INT PRIMARY KEY AUTO_INCREMENT,
   traveler_id INT,
   restaurant_id INT,
   visit_date DATE,
   location_id INT,
   FOREIGN KEY (traveler_id) REFERENCES Travelers(traveler_id),
   FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id),
   FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

-- RestaurantVisits 데이터 (식당 방문 기록)
INSERT INTO RestaurantVisits (traveler_id, restaurant_id, visit_date, location_id) VALUES
(1, 1, '2023-01-15', 1),
(2, 2, '2023-02-20', 2),
(3, 3, '2023-03-12', 3),
(4, 4, '2023-04-10', 4),
(5, 5, '2023-05-25', 5),
(1, 6, '2023-06-18', 1),
(2, 7, '2023-07-05', 2),
(3, 8, '2023-08-14', 3),
(4, 9, '2023-09-10', 4),
(5, 10, '2023-10-11', 5);
-- 김철수의 추가 여행 기록
INSERT INTO Trips (traveler_id, location_id, accommodation_id, trip_date) VALUES 
(1, 1, 3, '2024-01-10'),  -- 제주도 추가 방문
(1, 2, 4, '2024-02-15'),  -- 부산 추가 방문
(1, 3, 5, '2024-03-20');  -- 서울 추가 방문
-- 박지현의 추가 여행 기록
INSERT INTO Trips (traveler_id, location_id, accommodation_id, trip_date) VALUES 
(2, 3, 1, '2024-01-12'),  -- 서울 추가 방문
(2, 5, 2, '2024-03-18'),  -- 광주 추가 방문
(2, 4, 5, '2024-04-25');  -- 인천 추가 방문
-- 이민수의 추가 여행 기록
INSERT INTO Trips (traveler_id, location_id, accommodation_id, trip_date) VALUES 
(3, 6, 7, '2024-02-05'),  -- 대전 추가 방문
(3, 7, 8, '2024-03-10'),  -- 울산 추가 방문
(3, 8, 10, '2024-05-22');  -- 강릉 추가 방문
-- 김철수의 추가 식당 방문 기록
INSERT INTO RestaurantVisits (traveler_id, restaurant_id, visit_date, location_id) VALUES 
(1, 1, '2024-01-11', 1),  -- 제주도의 맛집 방문
(1, 2, '2024-02-16', 2),  -- 부산의 맛집 방문
(1, 3, '2024-03-21', 3);  -- 서울의 맛집 방문
-- 박지현의 추가 식당 방문 기록
INSERT INTO RestaurantVisits (traveler_id, restaurant_id, visit_date, location_id) VALUES 
(2, 3, '2024-01-13', 3),  -- 서울의 맛집 방문
(2, 5, '2024-03-19', 5),  -- 광주의 맛집 방문
(2, 4, '2024-04-26', 4);  -- 인천의 맛집 방문
-- 이민수의 추가 식당 방문 기록
INSERT INTO RestaurantVisits (traveler_id, restaurant_id, visit_date, location_id) VALUES 
(3, 6, '2024-02-06', 6),  -- 대전의 맛집 방문
(3, 7, '2024-03-11', 7),  -- 울산의 맛집 방문
(3, 8, '2024-05-23', 8);  -- 강릉의 맛집 방문
-- 최수정의 추가 식당 방문 기록
INSERT INTO RestaurantVisits (traveler_id, restaurant_id, visit_date, location_id) VALUES 
(4, 9, '2024-02-21', 9),  -- 속초의 맛집 방문
(4, 10, '2024-03-16', 10),-- 양양의 맛집 방문
(4, 1, '2024-04-06', 1);  -- 제주도의 맛집 방문
-- 윤성호의 추가 식당 방문 기록
INSERT INTO RestaurantVisits (traveler_id, restaurant_id, visit_date, location_id) VALUES 
(5, 2, '2024-01-26', 2),  -- 부산의 맛집 방문
(5, 5, '2024-03-03', 5),  -- 광주의 맛집 방문
(5, 10, '2024-04-18', 10);-- 양양의 맛집 방문
-- with 문


-- 1.여행자가 방문한 총 장소 수와 여행 횟수 조회
-- 각 여행자가 방문한 고유 장소의 수 (total_locations)와 전체 여행 횟수(total_trips)를 표시
with TravelerTrips as (
	select traveler_id, count(distinct location_id) as total_locations,count(*) as total_trips
    from trips
    group by traveler_id
)
select T.traveler_name, total_locations, total_trips
from travelers T
join TravelerTrips TT on T.traveler_id = TT.traveler_id;

-- 2. 인기맛집을 방문한 여행자의 리스트 조회
-- 여행 기록에서 맛집으로 지정된 식당을 방문한 여행자들을 찾습니다.
-- CTE이름은 PopularRestaurants

with PopularRestaurants as (
	select restaurant_id, restaurant_name
    from restaurants
    where is_popular = 1
    group by restaurant_id,restaurant_name
)
select PR.restaurant_name, T.traveler_name
from travelers T
join restaurantvisits R on R.traveler_id = T.traveler_id
join PopularRestaurants PR on PR.restaurant_id = R.restaurant_id;

-- 3. 각 여행자의 총 여행 횟수 조회
-- 여행자의 traveler_id별로 여행 횟수를 계산하는 예제
-- CTE 이름 : tripcount 안에는 traveler_id, total_trips를 만들어 준다.


with tripcount as (
	select traveler_id, count(trip_id) as total_trips
    from trips
    group by traveler_id
)
select T.traveler_id,T.traveler_name,total_trips
from travelers T
join tripcount TP on TP.traveler_id = T.traveler_id;

-- 4. 가장 많이 방문한 맛집 조회
-- 맛집을 가장 많이 방문한 여행자 리스트를 보여주는 쿼리
-- 맛집 방문 횟수를 기준으로 내림차순 정렬합니다
-- CTE 이름 : PopularRestaurantVisist
-- 쿼리 특징 : traveler_id, restaurant_id 동시에 group by 함
-- 맛집은 restaurants 테이블의 is_popular = 1 인것

with PopularRestaurantVisist as (
	select traveler_id,restaurant_id,count(*) as visit_count
    from restaurantvisits
    group by traveler_id,restaurant_id 
)
select T.traveler_id, T.traveler_name, R.restaurant_name, visit_count
from travelers T
inner join PopularRestaurantVisist PRV on PRV.traveler_id = T.traveler_id
inner join restaurants R on R.restaurant_id = PRV.restaurant_id
where is_popular = 1 
order by visit_count desc;

-- 1. 최근 여행 날짜로 각 여행자의 마지막 여행지 조회

-- 각 여행자의 가장 최근 여행지를 조회하는 예제입니다.

-- cte : RecentTrips



with RecentTrips as (
	select traveler_id, max(trip_date) as last_trip_date
    from trips
    group by traveler_id
)
select T.traveler_id, T.traveler_name, L.location_name, L.location_id, last_trip_date
from travelers T
join RecentTrips RT on RT.traveler_id = T.traveler_id
join trips A on A.trip_date = last_trip_date
join locations L on L.location_id = A.location_id
order by last_trip_date desc;


-- (쿼리결과)

-- traveler_id traveler_name location_id location_name last_trip_date
-- 3    이민수    8    용두암    2024-05-22
-- 2    박영희    4    경포대    2024-04-25
-- 1    김철수    3    성산 일출봉    2024-03-20
-- 5    장하나    10    팔공산    2023-10-11
-- 4    최수정    9    오죽헌    2023-09-10

--  

-- – 2. 여행지별 방문 횟수 상위 3개 여행지 조회

-- -- 여행지별로 방문 횟수를 계산하고, 방문 횟수가 가장 많은 상위 3개 여행지를 조회하는 예제입니다.

-- cte : LocationVisitCounts

--       Top3Locations ← RANK() OVER(    ) AS ranked  
-- Top3Locations AS (
--    SELECT location_id, visit_count,
--           RANK() OVER (ORDER BY visit_count DESC) AS ranked
--    FROM LocationVisitCounts
-- )


with LocationVisitCounts as (
	select location_id, count(*) as visit_count
    from trips
    group by location_id
),Top3Locations AS (
   SELECT location_id, visit_count,
   RANK() OVER (ORDER BY visit_count DESC) AS ranked
   FROM LocationVisitCounts
)
select L.location_id, L.location_name, T3.visit_count, ranked
from locations L
join LocationVisitCounts LVC on LVC.location_id = L.location_id
cross join Top3Locations T3 on T3.location_id = L.location_id
where ranked <= 3
order by ranked ;

-- (쿼리결과)

-- location_id location_name visit_count ranked
-- 3    성산 일출봉    3    1
-- 1    남산 타워          2    2
-- 2    해운대 해수욕장    2    2
-- 4    경포대        2    2
-- 5    수성못        2    2
-- 6    북촌 한옥마을    2    2
-- 7    광안리 해변    2    2
-- 8    용두암        2    2

-- 각 여행자가 방문한 총 여행지 수 조회
-- 각 여행자가 방문한 고유한 여행지 수를 조회하는 예제입니다. 
-- location_id를 기준으로 중복되지 않는 여행지를 세어 여행자별 방문지 수를 계산합니다.
select * from accommodations;
select * from locations;
select * from restaurants;
select * from travelers;
select * from trips;
select * from cities;
select * from restaurantvisits;

with qwer as (
	select traveler_id ,count(distinct location_id) as unique_locations
    from trips
    group by traveler_id
    )
select T.traveler_id, T.traveler_name, Q.unique_locations 
from travelers T
join qwer Q on Q.traveler_id = T.traveler_id
order by Q.unique_locations desc;
 

-- (결과)

-- traveler_id  traveler_name  unique_locations
-- 2             박영희           5
-- 1             김철수           4
-- 3             이민수           4
-- 4            최수정            2
-- 5            장하나            2