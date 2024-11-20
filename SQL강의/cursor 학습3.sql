USE GameTournamentDB;
-- 커서 사용법
DROP TABLE IF EXISTS Player_info;
CREATE TABLE Player_info (
   player_id INT PRIMARY KEY AUTO_INCREMENT,   -- 선수 고유 ID
   team_id INT,                                -- 소속 팀 ID
   player_name VARCHAR(100),                   -- 선수 이름
   age INT,                                    -- 나이
   height int,                       -- 키 (단위: cm)
   weight int,                       -- 몸무게 (단위: kg)
   speed_100m DECIMAL(5, 2),                   -- 100미터 속도 (단위: 초)
   salary DECIMAL(10, 2),                      -- 연봉 (단위: 원)
   experience_years INT,                       -- 경기 경험 (단위: 년)
   goals INT,                                  -- 골
   assists INT,                                -- 어시스트
   defense_ability ENUM('High', 'Medium', 'Low'), -- 수비 능력 (상, 중, 하)
   nationality VARCHAR(50),                    -- 출신 국가
   FOREIGN KEY (team_id) REFERENCES Teams(team_id)  -- 팀 정보와 연관
);

-- Player_info 테이블에 선수 이름, 경기 횟수를 입력하는 작업을 커서를 활용하여 처리
DROP PROCEDURE IF EXISTS InsertPlayerInfo;
DELIMITER $$
CREATE PROCEDURE InsertPlayerInfo()
BEGIN
   DECLARE done INT DEFAULT 0;
   DECLARE v_player_id INT;
   DECLARE v_team_id INT;
   DECLARE v_player_name VARCHAR(100);
   DECLARE v_experience INT;

   -- 커서 선언: 선수 정보를 조회할 커서
   DECLARE player_cursor CURSOR FOR 
       SELECT p.player_id, p.team_id, p.player_name
       FROM Player p; -- Players 테이블에서 선수 정보를 가져옴

   -- 종료 처리 핸들러
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

   -- 커서 열기
   OPEN player_cursor;

   -- 반복문을 사용하여 커서에서 가져온 데이터 처리
   read_loop: LOOP
       FETCH player_cursor INTO v_player_id, v_team_id, v_player_name;

       -- 커서 종료 조건
       IF done THEN
           LEAVE read_loop;
       END IF;

       -- 경기 횟수 계산: Matches 테이블에서 해당 팀에 속한 선수가 출전한 경기 횟수 구하기
       SELECT COUNT(*) INTO v_experience
       FROM Matches m
       JOIN Player p ON m.team_a = p.team_id OR m.team_b = p.team_id
       WHERE p.player_id = v_player_id;

       -- Player_info 테이블에 선수 정보 삽입
       INSERT INTO Player_info (player_id, team_id, player_name, experience_years)
       VALUES (v_player_id, v_team_id, v_player_name, v_experience);
       
   END LOOP;

   -- 커서 닫기
   CLOSE player_cursor;
END $$
DELIMITER ;
CALL InsertPlayerInfo();
select * from Player_info;
select * from player_health;

-- 선수들의 건강 정보 데이터를 삽입할 수 있도록 player_health라는 새로운 테이블을 생성하고, 

--  해당 데이터(키, 몸무게, 나이)를 무작위로 생성하여 삽입하는 SQL 예제

DROP TABLE IF EXISTS player_health;

CREATE TABLE player_health (

   player_id INT PRIMARY KEY,  -- Players 테이블의 player_id와 연동

   height_cm INT NOT NULL,     -- 키 (170 ~ 190cm)

   weight_kg INT NOT NULL,     -- 몸무게 (60 ~ 80kg)

   age_years INT NOT NULL      -- 나이 (20 ~ 35)

);

desc player_health;
drop procedure if exists cursor_proc;
delimiter //
create procedure cursor_proc()
begin
	DECLARE done int default 0;
	DECLARE v_player_id INT;
	DECLARE v_height INT;
	DECLARE v_weight int;
	DECLARE v_age INT;
    
    
    DECLARE player_cursor CURSOR FOR 
       SELECT player_id
       FROM Player;

  
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  
   OPEN player_cursor;
   
   read_loop: LOOP
       FETCH player_cursor INTO v_player_id;


       IF done THEN
           LEAVE read_loop;
       END IF;

	set v_height = floor(170 + (rand() * 21)); -- 키 : 170~190
	set v_weight = floor(60 + (rand() * 21)); -- 몸무게 : 60~80
	set v_age = floor(20 + (rand() * 16)); -- 나이 : 20~35
	INSERT INTO player_health (player_id, height_cm, weight_kg, age_years) VALUES (v_player_id,v_height,v_weight,v_age);
    
    end loop;
    
    CLOSE player_cursor;
end //
delimiter ;
call cursor_proc();
select * from player_health;
select * from player_info;

update player_info PL
	join player_health PH on PL.player_id = PH.player_id
    set PL.age = PH.age_years, PL.height = PH.height_cm, PL.weight = PH.weight_kg;

-- layer_health 테이블의 정보를 가져와 Player_info 테이블의 데이터를 UPDATE하는 커서
DROP PROCEDURE IF EXISTS update_player_info;

DELIMITER //
CREATE PROCEDURE update_player_info()
BEGIN
   -- 변수 선언
   DECLARE v_player_id INT;
   DECLARE v_height_cm INT;
   DECLARE v_weight_kg INT;
   DECLARE v_age_years INT;
   DECLARE end_of_cursor BOOLEAN DEFAULT FALSE;

   -- 커서 선언
   DECLARE player_health_cursor CURSOR FOR
   SELECT player_id, height_cm , weight_kg , age_years 
   FROM player_health;

   -- NOT FOUND 핸들러: 커서 끝을 알리기 위한 처리
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET end_of_cursor = TRUE;

   -- 커서 열기
   OPEN player_health_cursor;

   -- 커서 루프
   update_loop: LOOP
       -- 커서에서 데이터 가져오기
       FETCH player_health_cursor INTO v_player_id, v_height_cm, v_weight_kg, v_age_years;

       -- 커서 끝이면 루프 종료
       IF end_of_cursor THEN
           LEAVE update_loop;
       END IF;

       -- Player_info 테이블 업데이트
       UPDATE Player_info
       SET height = v_height_cm, weight = v_weight_kg, age = v_age_years
       WHERE player_id = v_player_id;
       
   END LOOP update_loop;

   -- 커서 닫기
   CLOSE player_health_cursor;
END //
DELIMITER ;

CALL update_player_info();

-- Player_info 테이블에 커서를 만들어 아래 데이터를 규칙에 따라 업데이트하시오.
-- speed_100m 컬럼에는 10.00 ~ 15.00 까지의 랜덤한 수를 넣어 주고, 
-- salary는 age * experience_years 로 해주고 goals 는 0~20 사이의 정수로 넣어 주고, 
-- assists 는 goals * 2 로 하고
-- defense_ability는 goals가 0~5 까지는 High, 6~15 Medium, 16~20 Low 로 넣어 줌.

 

--  ** 참고

--        -- 랜덤 값 계산
--        goals : FLOOR(RAND() * 21); -- 0 ~ 20 사이의 랜덤 정수

--        speed_100m : ROUND(10.00 + (RAND() * 5.00), 2), -- 10.00 ~ 15.00
drop procedure if EXISTS update_player_info_with_additional_data;
delimiter //
create procedure update_player_info_with_additional_data()
begin
	DECLARE done int default 0;
    DECLARE v_player_id INT;
	DECLARE v_goals int;
    DECLARE v_age INT;
    DECLARE v_experience_years INT;

	declare player_info_with_additional CURSOR FOR
		select player_id, age, experience_years
        from player_info;
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
        
	open player_info_with_additional;
        
		update_loop: loop
			FETCH player_info_with_additional into v_player_id, v_age, v_experience_years;
            
         IF done THEN
           LEAVE update_loop;
       END IF;
       
      SET v_goals = FLOOR(RAND() * 21); -- 0 ~ 20 사이의 랜덤 정수

       -- Player_info 테이블 업데이트
       UPDATE Player_info
       SET 
           speed_100m = ROUND(10.00 + (RAND() * 5.00), 2), -- 10.00 ~ 15.00
           salary = v_age * v_experience_years, -- 나이 * 경험 년수
           goals = v_goals, -- 랜덤 골 수
           assists = v_goals * 2, -- 어시스트는 골의 두 배
           defense_ability = CASE   
                               WHEN v_goals BETWEEN 0 AND 5 THEN 'High'
                               WHEN v_goals BETWEEN 6 AND 15 THEN 'Medium'
                               WHEN v_goals BETWEEN 16 AND 20 THEN 'Low'
                               ELSE NULL
                             END
       WHERE player_id = v_player_id;

   END LOOP update_loop;
	close player_info_with_additional;

end //
delimiter ;

CALL update_player_info_with_additional_data();
select * from Player_info;
