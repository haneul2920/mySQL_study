
CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Departments (
   dept_id INT PRIMARY KEY AUTO_INCREMENT,
   dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
   emp_id INT PRIMARY KEY AUTO_INCREMENT,
   emp_name VARCHAR(50) NOT NULL,
   dept_id INT,
   salary DECIMAL(10, 2),
   hire_date DATE,
   FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Projects (
   project_id INT PRIMARY KEY AUTO_INCREMENT,
   project_name VARCHAR(50) NOT NULL,
   dept_id INT,
   FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

 


-- Employees (직원 정보)

-- emp_id (INT) - 직원 ID (Primary Key)
-- emp_name (VARCHAR) - 직원 이름
-- dept_id (INT) - 부서 ID (외래 키)
-- salary (DECIMAL) - 월급
-- hire_date (DATE) - 입사일
-- Departments (부서 정보)

-- dept_id (INT) - 부서 ID (Primary Key)
-- dept_name (VARCHAR) - 부서 이름
-- Projects (프로젝트 정보)

-- project_id (INT) - 프로젝트 ID (Primary Key)
-- project_name (VARCHAR) - 프로젝트 이름
-- dept_id (INT) - 부서 ID (외래 키)
--  

-- Departments 데이터
INSERT INTO Departments (dept_name) VALUES
('Marketing'),
('Sales'),
('Engineering'),
('Human Resources'),
('Finance');
-- Employees 데이터
INSERT INTO Employees (emp_name, dept_id, salary, hire_date) VALUES
('Alice', 1, 5000.00, '2022-03-15'),
('Bob', 2, 4500.00, '2021-08-25'),
('Charlie', 3, 6000.00, '2020-07-11'),
('Diana', 4, 4800.00, '2019-12-05'),
('Edward', 5, 5500.00, '2022-01-18'),
('Fiona', 1, 5200.00, '2020-04-10'),
('George', 2, 4300.00, '2018-10-20'),
('Hannah', 3, 6100.00, '2021-06-23'),
('Ian', 4, 4900.00, '2020-09-13'),
('Jane', 5, 5700.00, '2019-11-03'),
('Kyle', 1, 5400.00, '2021-05-09'),
('Linda', 2, 4600.00, '2018-04-17'),
('Michael', 3, 6200.00, '2019-08-22'),
('Nina', 4, 5000.00, '2021-03-03'),
('Oscar', 5, 5800.00, '2020-06-19'),
('Paula', 1, 5300.00, '2018-07-15'),
('Quinn', 2, 4400.00, '2019-01-10'),
('Rita', 3, 6300.00, '2022-02-07'),
('Steve', 4, 5100.00, '2018-05-30'),
('Tina', 5, 5900.00, '2021-09-12');

-- Projects 데이터
INSERT INTO Projects (project_name, dept_id) VALUES
('Alpha Project', 1),
('Beta Project', 2),
('Gamma Project', 3),
('Delta Project', 4),
('Epsilon Project', 5),
('Zeta Project', 1),
('Eta Project', 3),
('Theta Project', 4),
('Iota Project', 5);
 

