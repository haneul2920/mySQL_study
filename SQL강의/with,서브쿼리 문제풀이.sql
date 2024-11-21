-- drop database if exists gametournamentdb;
use gametournamentdb;

-- whit 문으로 
-- 1. 경험 많은 선수(10년 이상) 중 최다 골을 기록한 선수
-- 	  10냔 이상의 경기 경험이 있는 선수 중 가장 많은 골을 기록한 선수를 찾습니다.

select * from player_info;

with maxGoalPlayer as(
	select player_id , max(goals) as max_goals
    from player_info    
    group by player_id
    )    
select MGP.player_id,PI.player_name,MGP.max_goals
from player_info PI
join maxGoalPlayer MGP on MGP.player_id = PI.player_id
order by max_goals desc limit 1 ; 

-- 2. 팀별 수비 능력 수준 요약
-- 설명: 팀별로 수비 능력 수준(상, 중, 하)에 대한 선수를 집계하고, 팀 내에서 수비 능력별 선수 수 순위를 표시합니다.
select * from player_info;

with teamDefenseRank as(
	select team_id, defense_ability, count(defense_ability) as count, rank() over(PARTITION BY team_id order by count(defense_ability) desc) as rank_within_team
    from player_info
    group by team_id , defense_ability
    )
select * from teamDefenseRank;
    


-- 서브쿼리 예제
 -- 1. '2024' 시즌에서 최다 득점을 기록한 팀과 해당 득점 조회
select * from matches;
select * from player_info;
select * from teams;

select team_name, maxTeamScore.max_score
	from teams T
    join (
			select team_a as team_id, sum(cast(substring_index(score, '-', 1)as unsigned)) as max_Score
            from matches
            where season = '2024'
            group by team_a
            union
            select team_b as team_id, sum(cast(substring_index(score, '-', -1)as unsigned)) as max_Score
            from matches
            where season = '2024'
            group by team_b
			) maxTeamScore on t.team_id = maxTeamScore.team_id
	order by max_score desc limit 1;

-- (쿼리결과)

-- team_name total_score
-- Dragons    15


 -- 2. 가장 많은 경기에 출전한 팀 조회
select T.team_name, count(*) as match_count
	from teams T
    join matches M on T.team_id = M.team_a or T.team_id = M.team_b
    group by team_name
    order by match_count desc limit 1;
    

SELECT team_name, 
       match_count
FROM teams t
JOIN (
       select team_id, 
              count(*) AS match_count
       FROM  (
               select team_a AS team_id from matches 
               UNION ALL
               select team_b AS team_id from matches 
               ) team_ab
       group by team_id
    ) all_match ON t.team_id = all_match.team_id
ORDER BY match_count DESC
LIMIT 1;

select * from teams;
select count(*) from matches
where team_a =3 or team_b =3;

-- (쿼리결과) 

-- team_name match_count
-- Knights    26
