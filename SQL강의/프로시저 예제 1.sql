--  IF ELSE를 사용한 프로시저 예제


-- 예제 1: 특정 팀의 승리 여부에 따라 메시지를 반환하는 프로시저
-- 팀의 경기 결과에 따라 "승리", "패배", "무승부" 메시지를 반환하는 프로시저입니다.

-- ~~ 에 적당한 소스 넣기
drop procedure if exists CheckTeamMatchResult;
DELIMITER //

CREATE PROCEDURE CheckTeamMatchResult(IN matchID INT, IN teamID INT, OUT resultMessage VARCHAR(50))
BEGIN
   DECLARE teamA INT;
   DECLARE teamB INT;
   DECLARE result VARCHAR(10);

   SELECT team_a, team_b, result INTO teamA, teamB, result FROM Matches WHERE match_id = matchID;

   IF teamA = teamID AND result = 'Win' THEN
       SET resultMessage = 'Team won the match';
   ELSEIF teamB = teamID AND result = 'Lose' THEN
       SET resultMessage = 'Team won the match';
   ELSEIF teamA = teamID AND result = 'Lose' THEN
       SET resultMessage = 'Team lost the match';
   ELSEIF teamB = teamID AND result = 'Win' THEN
       SET resultMessage = 'Team lost the match';
   ELSE
       SET resultMessage = 'Match ended in a draw';
   END IF;
END //

DELIMITER ;
select * from Matches;
call CheckTeamMatchResult(6, 2, @myValue);
SELECT CONCAT(@myValue);

 

-- 예제 2: 리그의 팀 평균 점수에 따라 랭킹을 반환하는 프로시저
-- 리그의 팀 평균 점수가 특정 기준 이상인지 여부에 따라 리그가 "상위 리그", "중간 리그", "하위 리그"로 평가됩니다.
-- SET ranking = 'Top League';
-- SET ranking = 'Mid  League';
-- SET ranking = 'Low League';
drop procedure if exists LeagueRanking;
DELIMITER //
CREATE PROCEDURE LeagueRanking(IN leagueID INT, OUT ranking VARCHAR(20))
BEGIN
   DECLARE averageScore DECIMAL(5,2);

   SELECT AVG(CAST(SUBSTRING_INDEX(score, '-', 1) AS DECIMAL)) INTO averageScore
   FROM Matches
   WHERE league_id = leagueID;

   -- IF ELSE 구문을 넣어 프로시저를 완성하시오.
   if averageScore >= 3.0 then
		SET ranking = 'Top League';
	-- elseif  averageScore >= 2.0 and averageScore <= 2.9 then
    elseif averageScore between 2.9 and 2.0 then
		SET ranking = 'Mid  League';
	else
		SET ranking = 'Low League';
	end if;   
END //

DELIMITER ;
select * from leagues;
call LeagueRanking(2, @myValue);
SELECT CONCAT(@myValue);

-- 예제 1: 리그에 따라 각 팀의 평균 점수를 계산하는 프로시저

-- ~~~에 소스를 넣어 완성하시오.
drop procedure if exists GetAverageScoreByLeague;
DELIMITER //

CREATE PROCEDURE GetAverageScoreByLeague(in leagueID int , OUT averageScore DECIMAL(5,2))
BEGIN
   SELECT 
       AVG(CASE WHEN league_id = leagueID THEN CAST(SUBSTRING_INDEX(score, '-', 1) AS DECIMAL) 
                ELSE NULL END) AS averageScore
   INTO averageScore
   FROM Matches;
END //

DELIMITER ;
CALL GetAverageScoreByLeague(2, @myValue);
SELECT CONCAT(@myValue) '평균 점수';

 

-- 예제 2: 시즌에 따라 승/패 여부에 따른 전체 경기 통계를 반환하는 프로시저
-- 괄호(  ) 에 CASE WHEN 소스를 넣어 완성하시오.
drop procedure if exists GetSeasonStatistics;

DELIMITER //

CREATE PROCEDURE GetSeasonStatistics(IN seasonYear VARCHAR(10), OUT totalWins INT, OUT totalLosses INT)
BEGIN
   SELECT 
       -- SUM(result = 'win') AS totalWins,
--        SUM(result = 'lose') AS totalLosses
       SUM(case when result = 'win' then 1 else 0 end ) AS totalWins,
       SUM(case when result = 'lose' then 1 else 0 end) AS totalLosses
   INTO totalWins, totalLosses
   FROM Matches
   WHERE season = seasonYear;
END //

DELIMITER ;

CALL GetSeasonStatistics('2024', @totalWins, @totalLosses);
SELECT @totalWins '승전 합계', @totalLosses '패전 합계';


	
-- 예제 1: 각 팀별 승/패/무 데이터를 출력하는 프로시저
-- GetTeamResults : 팀의 경기 결과에 따라 승/무/패 카운트를 반환하는 프로시저

-- 결과는 아래와 같이 출력되게 하시오
-- Team ID: 5 Wins: 6, Draws: 0, Losses: 5

-- ~~~ 에 적당한 소스를 넣으시오.


DELIMITER //
CREATE PROCEDURE GetTeamResults(IN teamID INT, OUT wins INT, OUT draws INT, OUT losses INT)
BEGIN
   SELECT 
       SUM(CASE WHEN result = 'Win' AND team_a = teamID THEN 1 
                WHEN result = 'Lose' AND team_b = teamID THEN 1 
                ELSE 0 END) AS wins,
       SUM(CASE WHEN result = 'Win' AND team_b = teamID THEN 1 
                WHEN result = 'Lose' AND team_a = teamID THEN 1 
                ELSE 0 END) AS losses,
       SUM(CASE WHEN team_a = teamID OR team_b = teamID THEN 1 ELSE 0 END) - 
       (SUM(CASE WHEN result = 'Win' AND team_a = teamID THEN 1 
                 WHEN result = 'Lose' AND team_b = teamID THEN 1 
                 ELSE 0 END) +
        SUM(CASE WHEN result = 'Win' AND team_b = teamID THEN 1 
                 WHEN result = 'Lose' AND team_a = teamID THEN 1 
                 ELSE 0 END)) AS draws
   INTO wins, losses, draws
   FROM Matches;
END //
DELIMITER ;

DELIMITER //
drop procedure if exists TeamResultsSummary;
CREATE PROCEDURE TeamResultsSummary()
BEGIN
   DECLARE i INT DEFAULT 1;
   DECLARE maxID INT;
   DECLARE teamWins INT;
   DECLARE teamLosses INT;
   DECLARE teamDraws INT;
   
   SELECT max(team_id) into maxID  FROM Teams;

   WHILE i <= maxID DO
       CALL GetTeamResults(i, teamWins, teamDraws, teamLosses);
       
       SELECT CONCAT('Team ID: ',i, ' Wins: ',teamWins, ' Draws: ',teamDraws, ' Losses: ',teamLosses);
       
       SET i = i + 1;
   END WHILE;
END //
DELIMITER ;
CALL TeamResultsSummary();

 

 

-- 예제 2: 리그별로 각 팀의 총 득점을 계산하는 프로시저

-- ~~~ 에 적당한 소스를 넣으시오.
drop procedure if exists CalculateTotalScoresByLeague;
DELIMITER //
CREATE PROCEDURE CalculateTotalScoresByLeague(in leagueID int)
BEGIN
   SELECT team_a AS TeamID,
          -- 이 문자열에서 첫 번째 숫자만을 추출하고 이를 정수형으로 변환한 뒤, 각 팀의 총 득점을 계산하기 위해 합산 
          SUM(CAST(SUBSTRING_INDEX(score, '-', 1) AS UNSIGNED)) AS TotalScore
   FROM Matches
   WHERE league_id = leagueID
   GROUP BY team_a;
END //
DELIMITER ;
CALL CalculateTotalScoresByLeague(1);



-- 동적 SQL을 사용한 프로시저 예제
-- 예제 1: 동적 테이블 이름을 받아 경기 수를 반환하는 프로시저

select * from matches;

DELIMITER //
CREATE PROCEDURE GetMatchCount(IN tableName VARCHAR(50), OUT matchCount INT)
BEGIN
   SET @query = CONCAT( 'select count(*) from ', tableName );
   PREPARE stmt FROM @query;
   EXECUTE stmt;
   DEALLOCATE PREPARE stmt;
END //
DELIMITER ;
CALL GetMatchCount('matches', @matchCount);

 

-- 예제 2: 특정 팀의 경기 데이터 조건별로 필터링하여 반환하는 동적 프로시저
DROP PROCEDURE IF EXISTS FilterTeamMatches;
DELIMITER //
CREATE PROCEDURE FilterTeamMatches(IN teamID INT, OUT resultCount INT)
BEGIN
   SET @query = CONCAT(' select count(*) as resultCount from matches WHERE (team_a = ', teamID, ' OR team_b = ', teamID, ') AND result = "Win"');
   prepare stmt from @query;
   execute stmt;
   deallocate prepare stmt;
END //
DELIMITER ;
CALL FilterTeamMatches(2, @resultCount);

-- 1: 특정 팀의 모든 경기 정보 조회
DROP PROCEDURE IF EXISTS GetTeamMatches;
DELIMITER //
CREATE PROCEDURE GetTeamMatches(IN team INT, OUT match_count INT)
BEGIN
   -- 특정 팀이 포함된 경기 수를 계산합니다.
   SELECT COUNT(*) INTO match_count
   FROM Matches
   WHERE team_a = team OR team_b = team;

   -- 해당 팀이 포함된 경기 정보 출력
   SELECT *
   FROM Matches
   WHERE team_a = team OR team_b = team;
END //
DELIMITER ;
-- 5번 팀 경지 정보를 조회 하시오

CALL GetTeamMatches(5,@match_count);
SELECT @match_count;

 select * from matches;

-- 2. 특정 팀의 최근 5경기 기록 조회
DROP PROCEDURE IF EXISTS GetRecentMatches;
DELIMITER //
CREATE PROCEDURE GetRecentMatches(IN team INT)
BEGIN
   -- 특정 팀이 포함된 최근 5경기 정보를 날짜 기준으로 정렬하여 조회합니다.
   select *
   from matches
   where team_a = team or team_b = team
   order by start_date desc 
   LIMIT 5;
END //
DELIMITER ;
CALL GetRecentMatches(5);

select * from Matches;


-- 3 특정 팀이 승리한 경기 수
drop procedure if exists GetTeamWinCount;
delimiter //
create procedure GetTeamWinCount(in team int ,out win_count int)
begin
	select count(*) into win_count
		from matches
        where (team_a = team and result = 'win') or (team_b = team and result = 'Lose');
end //
delimiter ;
CALL GetTeamWinCount(5, @win_count);
SELECT @win_count;

 

-- 4. 특정 팀이 참여한 경기에서 득점한 총 점수 계산
DELIMITER //
CREATE PROCEDURE GetTeamTotalScore(in team int, out total_score int)
BEGIN
   -- 특정 팀의 총 득점 계산
   SELECT SUM(
       CASE
           WHEN team_a = team THEN CAST(SUBSTRING_INDEX(score, '-', 1) AS UNSIGNED)
           WHEN team_b = team THEN CAST(SUBSTRING_INDEX(score, '-', -1) AS UNSIGNED)
           ELSE 0
       END
   ) INTO total_score
   FROM Matches
   WHERE team_a = team OR team_b = team;
END //
DELIMITER ;
CALL GetTeamTotalScore(5, @total_score);
SELECT @total_score;

 
select * from matches;
-- 5. 특정 팀이 참가한 경기에서 무승부 수 계산
DELIMITER //
CREATE PROCEDURE GetDrawMatchCount(IN team INT, OUT draw_count INT)
BEGIN
   -- 특정 팀이 포함된 경기 중 무승부인 경기 수를 계산
   select count(*) into draw_count
   from matches
   where team_a = team and result = 'draw';
   
END //
DELIMITER ;
CALL GetDrawMatchCount(5, @draw_count);
SELECT @draw_count;


-- 특정 팀의 승률 계산
drop procedure if exists GetTeamWinStats;
delimiter //
create procedure GetTeamWinStats(in team float, out win_rate decimal(5,2))
begin
	declare totalGameCount int;
    declare win_count int;    
    set totalGameCount = (select count(*) from matches where team_a = team or team_b = team);
	set win_count = (select count(*) from matches where (team_a = team and result = 'win') or (team_b = team and result = 'Lose'));
    set win_rate = (win_count / totalGameCount) * 100;
end //
delimiter ;
call GetTeamWinStats (5, @win_rate);
select @win_rate;

select * from matches;
-- 특정 팁이 승리한 경기 수와 특정 팀의 승률 계산
drop procedure if exists GetTeamWinCountWinRate;
delimiter //
create procedure GetTeamWinCountWinRate(in team float, out win_count int , out win_rate decimal(5,2))
begin
	declare totalGameCount int;
    set totalGameCount = (select count(*) from matches where team_a = team or team_b = team);
	set win_count = (select count(*) from matches where (team_a = team and result = 'win') or (team_b = team and result = 'Lose'));
    set win_rate = (win_count / totalGameCount) * 100;    
end //
delimiter ;
call GetTeamWinCountWinRate (5, @win_count, @win_rate);
select @win_count, @win_rate;
