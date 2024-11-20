use companydb;

select * from departments;
select * from employees;
select * from projects;

-- 예제2 프로젝트와 직원 수 조회
-- projectcount CTE 를 통해 각 부서의 프로젝트 수를 계산했습니다
-- employeecount CTE를 통해 각 부서의 직원 수를 계산 했습니다.
-- 메인 쿼리에서는 departments 테이블과 두 CTE를 조인하여 부서 이름,프로젝트수, 직원 수를 조회 합니다.
-- *CTE : common table expression

select * from departments;

with ProjectCount as(
	select dept_id, count(*) as project_count
		from projects
        group by dept_id
),
employeecount as ( 
	select dept_id, count(*) as employee_count
		from employees
		group by dept_id
)
select dept_name, project_count, employee_count
from departments D
join projectcount PC on D.dept_id = PC.dept_id
join employeecount EC on D.dept_id = EC.dept_id;

-- 예제4 : 입사 연도별 평균 급여
-- 테이블에서 십사 연도별로 평균 급여를 계산하고 이를 조회하는 쿼리
-- avgsalaryByYear CTE를 통해 입사 연도별 평균 급여를 계산했습니다.
-- 메인 쿼리에서는 각 연도별 평균 급여를 조회합니다.
select * from employees;

with AvgSalarByYear as (
	select YEAR(hire_date) as hire_year, avg(salary) as avg_salary
    from employees
    group by YEAR(hire_date)
)
select hire_year,avg_salary
from AvgSalarByYear
group by hire_year;

-- 예제 5: 부서별 가장 높은 급여를 받는 직원 찾기
-- 부서별로 가장 높은 급여를 받는 직원의 정보를 조회하는 예제
-- MaxSalaryByDept CTE를 사용하여 각 부서의 최고 급여(max_salary)를 계산 했습니다.
-- Departments 와 Employees 테이블을 조인 하여 각 부서별 최고 급여를 받는 직원의 이름과 급여를 조회합니다.

with MaxSalaryByDapt as (
	select dept_id,Max(salary) as max_salary
		from employees
        group by dept_id
)
select D.dept_name ,E.emp_name, max_salary
from departments D
join MaxSalaryByDapt MSD on MSD.dept_id = D.dept_id
join employees E on E.salary = MSD.max_salary;

