use gametournamentdb;
-- 3-1. Player_info 테이블에서 해당 팀에서 가장 빠른 100m 속도를 가진 선수의 이름을 반환하는 함수를 
-- 만들어 제출하시오.
delimiter //
create function fastPlayer(team_id int)
	returns varchar(50)
begin
	declare fastPlayer varchar(50);
	
	select player_name into fastPlayer
    from player_info
    where team_id = team_id
    order by speed_100m limit 1;
    return fastPlayer;
end //
delimiter ;
select fastPlayer(1);

-- 3-2. Matches 테이블에서 팀별 경기 승리 횟수를 계산하는 함수를 구하시오.
delimiter //
create function teamWinCount(teamID int)
	returns int
begin
	declare winCount int;	
	select sum(case
					when (team_a = teamid OR team_b = teamid) AND result = 'win' THEN 1
                   ELSE 0
               END
			  ) into winCount
    from matches
    where team_a = teamID or team_b = teamID;
    return winCount;
end //
delimiter ;
select teamWinCount(1);

-- 4. WITH 문으로 쿼리 하시오.  (10점)

--  4-1. 팀별 평균 연봉과 나이 비교 

--  Player_info 테이블을 기반으로 팀별 평균 연봉과 평균 나이를 계산하고, 

--  연봉 수준에 따라 팀을 분류합니다. 

--  (연봉수준 680 초과 '비싼팀', 650 이상 '적당한팀', 650 미만 '저렴한 팀')

select * from player_info;
with avgSalaryAge as (
					select team_id, 
                    avg(salary) as avg_salary, 
                    avg(age) as avg_age
					from player_info
                    group by team_id
),
avgSalaryStats as(
					select team_id, avg_salary,avg_age,
                    case 
						when avg_salary > 680 then '비싼팀'
                        when avg_salary >= 650 then '적당한팀'
                        when avg_salary < 650 then '저렴한팀'
					end as salary_rank
                    from avgSalaryAge
                    )
select team_id, avg_salary,avg_age, salary_rank
from avgSalaryStats;
			
-- 4-2. 선수 연봉 상위 5명 조회

-- 선수의 연봉 순위를 계산하고, 상위 5명을 추출합니다.

with TopSalary as(
				select player_id, max(salary) as salary
                from player_info
                group by player_id
                )
select P.player_id,P.player_name, T.salary
from TopSalary T
join player_info P on T.player_id = P.player_id
order by salary desc limit 5;

-- 5. JOIN 문으로 쿼리 하시오. (10점)

--   5-1. 선수와 팀 이름을 포함한 연봉 순위
select * from player_info;

select PI.player_id,T.team_name,PI.player_name,PI.salary,
rank() over(order by PI.salary desc) as salary_rank
from player_info PI
join teams T on T.team_id = PI.team_id;

-- 5-2. 팀별 총 골 및 총 어시스트
with totalGoals as(
	select team_id, sum(goals) total_goals
		from player_info
        group by team_id
),
totalAssists as (
	select team_id,sum(assists) total_assists
		from player_info
        group by team_id
)
select T.team_id, T.team_name,total_goals,total_assists
from teams T
join totalGoals TG on T.team_id = TG.team_id
join totalAssists TA on T.team_id = TA.team_id;

-- 서브 쿼리 문으로 쿼리 하시오. (10점)
select * from teams;
select * from matches;
--   6-1. 경기에 참가한 두 팀의 이름과 점수
select match_id, season,(select team_name from teams where team_a = team_id)as team_a_name,(select team_name from teams where team_b = team_id) as team_b_name, score
from matches;


--  6-2. 평균 연봉이 가장 높은 팀과 해당 평균 연봉
select team_name, (select avg(salary) from player_info P where P.team_id = T.team_id) as avg_team_salary
from teams T
order by avg_team_salary desc limit 1;
