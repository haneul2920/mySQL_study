use gametournamentdb;
select * from matches;

-- 특정 리그의 경기 일정 이동 프로시저
-- 사정이 있어(실수, 우편 등) 특정 리그의 모든 경기 날짜를 일괄 이동시키는 프로시저
-- 커서를 통해 matches 테이블의 경리를 순회 하며 날짜를 업데이트 합니다.
 -- 리그 ID 2의 모든 경기를 3일 앞으로 이동
drop procedure if exists adjust_match_dates_by_league;
delimiter //
create procedure adjust_match_dates_by_league(in leagueID int,in Date2 int)
begin
	declare v_match_id int;
    declare v_start_date date;
    declare v_end_date date;
    DECLARE end_of_cursor BOOLEAN DEFAULT FALSE;
    declare leagueDate date;
    
    declare open_of_cursor cursor for
    select match_id,start_date,end_date,league_id
    from matches;
    
    declare continue handler for not found set end_of_cursor = true;
    
    open open_of_cursor;
    
    update_loop: loop    
    FETCH open_of_cursor into v_match_id, v_start_date, v_end_date;
    set leagueDate = (select date_add(v_start_date, interval Date2 day));
    IF end_of_cursor THEN
           LEAVE update_loop;
	END IF;
    
    update matches set start_date = leagueDate, end_date = leagueDate
    where match_id = v_match_id;
    
	end loop update_loop;
    close open_of_cursor;
end //
delimiter ;


call adjust_match_dates_by_league(1,5); -- 리그 ID 1의 모든 경기를 7일 뒤로 이동
call adjust_match_dates_by_league(2,5);
select * from matches
where league_id = 1; 

-- 프로시저 (커서 포함) 예제
-- USE GameTournamentDB;
-- select * from matches;

-- 특정 리그의 경기 일정 이동 프로시저
-- 사정이 있어(실수, 우천 등) 특정 리그의 모든 경기 날짜를 일괄 이동시키는 프로시저
-- 커서를 통해 Matches 테이블의 경기를 순회하며 날짜를 업데이트 합니다.
-- CALL adjust_match_dates_by_league(1, 7); -- 리그 ID 1의 모든 경기를 7일 뒤로 이동
-- CALL adjust_match_dates_by_league(2, -3); -- 리그 ID 2의 모든 경기를 3일 앞으로 이동


-- SELECT DATE_ADD('2024-03-01', INTERVAL -3 DAY);
-- DROP PROCEDURE adjust_match_dates_by_league;
-- DELIMITER //
-- CREATE PROCEDURE adjust_match_dates_by_league(
--        IN league_id_input INT,
--        IN day_to_adjust INT
-- )
-- BEGIN
--        -- 변수선언
--        DECLARE v_match_id INT;
--        DECLARE v_start_date DATE;
--        DECLARE v_end_date DATE;
--        DECLARE end_of_cursor BOOLEAN DEFAULT FALSE;
--        
--        -- 커서 선언
--        DECLARE match_cursor CURSOR FOR
--        SELECT match_id, start_date, end_date
--        FROM Matches
--        WHERE league_id = league_id_input;
--        
--        -- NOT FOUND 핸들러 설정
--        DECLARE CONTINUE HANDLER
--        FOR NOT FOUND SET end_of_cursor = TRUE;
--        
--        -- 커서 열기
--        OPEN match_cursor;
--        
--        -- 커서 루프
--        adjust_loop: LOOP
--                FETCH match_cursor INTO v_match_id, v_start_date, v_end_date;
--                -- 커서 종료시 루프 종료
--                IF end_of_cursor THEN
--                        LEAVE adjust_loop;
--                END IF;
--        
--                -- Matchs 테이블의 날짜 업데이트
--                UPDATE Matches
--                SET start_date = DATE_ADD(v_start_date, INTERVAL day_to_adjust DAY),
--                    end_date = DATE_ADD(v_end_date, INTERVAL day_to_adjust DAY)
--                WHERE match_id = v_match_id;
--        
--        END LOOP adjust_loop; 
--        
--        -- 커서 닫기
--        CLOSE match_cursor;
--        
-- END //
-- DELIMITER ;




-- GameTournamentDB 에 경기 일정 테이블을 만들어 데이터를 10개를 넣었다. 

-- 경기가 끝나 홈팀의 결과와 스코어를 업데이트 할 경우 matches 테이블에 데이터가 추가 되도록 트리거를 만드는 예제

 

USE GameTournamentDB;
DROP TABLE Schedule1;
CREATE TABLE Schedule1 (
   schedule_id INT AUTO_INCREMENT PRIMARY KEY,  -- 스케줄 ID
   league_id INT NOT NULL,                      -- 리그 ID
   home_team INT NOT NULL,              -- 홈팀
   away_team INT NOT NULL,              -- 어웨이팀
   season YEAR NOT NULL,                        -- 시즌
   match_date DATE NOT NULL,                    -- 경기 날짜
   home_team_result VARCHAR(4) , -- 홈팀 경기 결과 'Win', 'Lose', 'Draw'
   score VARCHAR(7)                    -- 스코어 (예: '2-1')
);

INSERT INTO Schedule1 (league_id, home_team, away_team, season, match_date)
VALUES
(1, 1, 2, 2024, '2024-11-25'),
(1, 1, 3, 2024, '2024-11-26'),
(1, 2, 4, 2024, '2024-11-27'),
(1, 4, 1, 2024, '2024-11-28'),
(1, 5, 3, 2024, '2024-11-29'),
(2, 1, 4, 2024, '2024-12-01'),
(2, 2, 4, 2024, '2024-12-02'),
(2, 3, 2, 2024, '2024-12-03'),
(2, 2, 1, 2024, '2024-12-04'),
(2, 4, 5, 2024, '2024-12-05');
select * from matches;

drop trigger if exists matchesUpdateTrg;
delimiter //
create trigger matchesUpdateTrg
	after update
    on schedule1
    for each row
begin
	insert into matches(league_id, team_a, team_b, season, start_date, end_date, result, score) 
				values (new.league_id, new.home_team, new.away_team, new.season , new.match_date, new.match_date, new.home_team_result, new.score);
end //
delimiter ;


UPDATE Schedule1
SET home_team_result = 'Win', score = '3-2'
WHERE schedule_id = 1;

select * from Schedule1;
select * from matches
order by match_id desc;