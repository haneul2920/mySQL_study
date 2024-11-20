select * from departments;
select * from employees;
select * from projects;


-- 서브쿼리 예제1. 특정 강좌에 등록된 학생들의 이름 조회
-- '데이터베이스'라는 강좌에 등록된 학생들의 이름을 조회합니다.
select C.coursename,S.name
from courses C
inner join enrollments E on E.CourseID = C.CourseID
inner join students S on E.StudentID = S.StudentID
where C.CourseName = "데이터베이스";

select name from students
where StudentID in(select studentid from enrollments
					where courseid = (select courseid from courses where coursename = "데이터베이스"));

-- 예제2. 특정 학생과 같은 강의를 수강하는 다른 학생들의 이름 조회
-- 예를 들어, '김철수' 학생과 같은 강의를 수강 중인 다른 학생들을 조회합니다.
-- in을 두번 한다.

select name from students
where StudentID in(
	select studentid from enrollments
	where courseid in(
    select courseid from enrollments 
    where studentid in(
    select studentid from students 
    where name = "김철수")));
    
    
-- 예제3. 가장 많은 강의를 수강한 학생의 이름과 수강 강의 수 조회
-- 가장 많은 강의를 수강한 학생의 이름과 그 수강 강좌 수를 조회합니다.

select * from students;
select * from enrollments;
select * from courses;

select name,count(courseid) coursecount 
	from students S
	inner join enrollments E on E.StudentID = S.StudentID
    group by S.name
    having coursecount = (
    select max(coursecount) 
    from (select count(courseid) 
    from enrollments 
    group by studentid));

-- 예제1.특정 부서의 평균 급여 이상인 직원 찾기
--  특정 부서(예: 'marketing')의 평균 급여보다 높은 급여를 받는 직원들을 찾는 쿼리입니다.
select emp_name ,salary
from employees
where salary >= (
	select avg(salary) 
    from employees E
    inner join departments D on D.dept_id = E.dept_id
    where dept_name = "marketing"
    );
    
    
-- 예제2. 부서별 최고 급여를 받는 직원
-- 각 부서에서 최고 급여를 받는 직원 정보를 조회 하는 쿼리 

select E.emp_name , E.salary, D.dept_name
from employees E
inner join departments D on D.dept_id = E.dept_id
where salary in(
	select max(salary) from employees
    group by dept_id);


-- 예제3. 특정 프로젝트에 참여하는 직원의 부서명과 직원 수
-- 특정 프로젝트('Alpha Project')에 참여하는 직원의 부서와 직원의 수를 조회하는 쿼리

select * from projects;
select * from departments;
select * from employees;

select D.dept_name , count(E.emp_id)
	from employees E
    inner join departments D on E.dept_id = D.dept_id
    where E.dept_id =(
		select dept_id from projects
		where project_name = "Alpha Project"
		)
    group by D.dept_name;

select D.dept_name,count(emp_id) empcount
from departments D
inner join projects P on P.dept_id = D.dept_id
inner join employees E on E.dept_id = D.dept_id
where project_name = "Alpha Project"
group by  D.dept_name;

-- 예제 4. 부서별로 가장 최근에 입사한 직원의 이름과 입사일 select

select emp_name, hire_date ,dept_name
from employees E
inner join departments D on D.dept_id = E.dept_id
where E.hire_date in (
	select max(hire_date) 
	from employees
    group by dept_id);

-- (쿼리결과)

-- emp_name hire_date   dept_name
-- Alice    2022-03-15    Marketing
-- Bob    2021-08-25    Sales
-- Rita    2022-02-07    Engineering
-- Nina    2021-03-03    Human Resources
-- Edward    2022-01-18    Finance

 

-- 예제 5. Gamma Project에 관련된 부서의 전체 급여 합계 구하기
select * from projects;
select * from departments;
select * from employees;


select sum(salary) "급여 합계"
from employees
where dept_id = (
	select dept_id 
	from projects 
	where project_name = "Gamma project");

-- (쿼리결과)

-- 급여합계

-- 24600.00


-- CASE WHEN
-- 예제 1: 직원 급여에 따른 급여 등급 추가하기
-- 급여가 6000 이상이면 "high", 4000이상 6000미만이면 "medium", 그 이하이면 "LOW"로 분류 합니다.
 select emp_name, salary,
	case 
		when salary >= 6000 then "high"
        when salary >= 4000 then "medium"
        else "LOW"
	end "급여 등급" 
 from employees;
 
 -- 예제 2: 부서별 직원 수에 따라 직원의 보너스 계산하기
 -- 직원수가 5명 이상이면 보너스를 1000, 그 이하면 500으로 설정합니다.
select * from projects;
select * from departments;
select * from employees;
 
 
select E.emp_name,E.salary,dept_name,
	case
		when count(D.dept_id) >= 5 then "1000"
        else "500"
	end "보너스"
from departments D
inner join employees E on E.dept_id = D.dept_id
group by E.emp_name,D.dept_name,E.salary;

-- 예제 3: 각 부서에서 가장 최근에 입사한 직원의 입사일 기준으로 그들에게 특별 보너스 지급 여부 확인하기

-- 입사일이 2021년 1월 1일 이후인 직원들에게 특별 보너스를 지급하는 쿼리입니다. 입사일이 2021년 1월 1일 이후이면 "Yes", 아니면 "No"를 반환합니다.
select E.emp_name,E.hire_date,D.dept_name,
	case
		when hire_date >= "2021-01-01" then "yes"
        else "no"
	end "special_bonus"
from employees E
inner join departments D on D.dept_id = E.dept_id;



-- (쿼리결과)

-- emp_name hire_dae    dept_name  special_bonus
-- Ian    2020-09-13    Human Resources    No
-- Nina    2021-03-03    Human Resources    Yes
-- Steve    2018-05-30    Human Resources    No
-- Edward    2022-01-18    Finance    Yes
-- Jane    2019-11-03    Finance    No
-- Oscar    2020-06-19    Finance    No
-- Tina    2021-09-12    Finance    Yes

-- 예제 4: 특정 프로젝트에 참여한 직원들의 참여 여부를 표시하기

-- 특정 프로젝트(예: 'Alpha Project')에 참여한 직원들에게 'Participated', 참여하지 않은 직원들에게는 'Not Participated'로 표시
select E.emp_name,P.project_name,
	case
		when project_name = "Alpha Project" then "Participated"
        else "Not Participated"
	end "participation_status"
from employees E
inner join projects P on P.dept_id = E.dept_id;


-- 전체 부서의 평균 직원 수보다 직원 수가 많은 부서를 찾기 위한 쿼리는 다음과 같습니다.

select D.dept_name, count(*) "직원 수"
from employees E
inner join departments D on D.dept_id = E.dept_id
group by D.dept_name;