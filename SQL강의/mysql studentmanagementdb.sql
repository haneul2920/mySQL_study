-- 1. 데이터베이스 생성

 

CREATE DATABASE StudentManagement;
USE StudentManagement;
 

-- 2. 테이블 생성

-- Students 테이블: 학생 정보를 저장합니다.
-- Courses 테이블: 강좌 정보를 저장합니다.
-- Enrollments 테이블: 학생의 강좌 수강 정보를 저장합니다.
-- Professors 테이블: 강좌를 담당하는 교수 정보를 저장합니다.
-- 학생 테이블 생성
CREATE TABLE Students (
   StudentID INT AUTO_INCREMENT PRIMARY KEY,
   Name VARCHAR(50),
   Age INT,
   Gender ENUM('남', '여'),
   Major VARCHAR(50),
   AdmissionDate DATE
);

-- 강좌 테이블 생성
CREATE TABLE Courses (
   CourseID INT AUTO_INCREMENT PRIMARY KEY,
   CourseName VARCHAR(100),
   Credits INT,
   Department VARCHAR(50)
);

-- 수강 정보 테이블 생성
CREATE TABLE Enrollments (
   EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
   StudentID INT,
   CourseID INT,
   EnrollmentDate DATE,
   Grade CHAR(1),
   FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
   FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 교수 테이블 생성
CREATE TABLE Professors (
   ProfessorID INT AUTO_INCREMENT PRIMARY KEY,
   Name VARCHAR(50),
   Department VARCHAR(50),
   Office VARCHAR(50)
);

-- 강좌-교수 관계 테이블 생성
CREATE TABLE CourseProfessors (
   CourseID INT,
   ProfessorID INT,
   PRIMARY KEY (CourseID, ProfessorID),
   FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
   FOREIGN KEY (ProfessorID) REFERENCES Professors(ProfessorID)
);
 

-- 3. 데이터 삽입 (50개 이상의 데이터)

-- 학생 데이터 삽입 (10명)
INSERT INTO Students (Name, Age, Gender, Major, AdmissionDate) VALUES
('김철수', 20, '남', '컴퓨터공학', '2023-03-02'),
('박영희', 21, '여', '경영학', '2023-03-02'),
('이민수', 22, '남', '전자공학', '2022-03-02'),
('정수진', 23, '여', '컴퓨터공학', '2021-03-02'),
('최준혁', 20, '남', '경영학', '2023-03-02'),
('조현우', 24, '남', '전자공학', '2020-03-02'),
('송지민', 21, '여', '경영학', '2022-03-02'),
('장서연', 22, '여', '컴퓨터공학', '2021-03-02'),
('한예지', 23, '여', '전자공학', '2020-03-02'),
('남궁민', 20, '남', '경영학', '2023-03-02');

-- 강좌 데이터 삽입 (10개)
INSERT INTO Courses (CourseName, Credits, Department) VALUES
('프로그래밍 기초', 3, '컴퓨터공학'),
('데이터베이스', 4, '컴퓨터공학'),
('전자회로', 3, '전자공학'),
('경영학원론', 3, '경영학'),
('마케팅관리', 3, '경영학'),
('운영체제', 4, '컴퓨터공학'),
('회로이론', 4, '전자공학'),
('재무관리', 3, '경영학'),
('소프트웨어 공학', 3, '컴퓨터공학'),
('통신이론', 3, '전자공학');

-- 교수 데이터 삽입 (5명)
INSERT INTO Professors (Name, Department, Office) VALUES
('김진호', '컴퓨터공학', 'C201'),
('이성훈', '경영학', 'B101'),
('박미영', '전자공학', 'D301'),
('최은영', '컴퓨터공학', 'C102'),
('정우성', '전자공학', 'D302');

-- 강좌-교수 관계 데이터 삽입
INSERT INTO CourseProfessors (CourseID, ProfessorID) VALUES
(1, 1), (2, 1), (3, 3), (4, 2), (5, 2),
(6, 1), (7, 3), (8, 2), (9, 4), (10, 5);

-- 수강 정보 데이터 삽입 (20개)
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade) VALUES
(1, 1, '2023-03-15', 'A'), (2, 1, '2023-03-15', 'B'),
(3, 2, '2022-03-12', 'A'), (4, 2, '2021-03-11', 'B'),
(5, 3, '2023-03-16', 'C'), (6, 3, '2020-03-12', 'A'),
(7, 4, '2022-03-13', 'B'), (8, 5, '2021-03-14', 'A'),
(9, 6, '2020-03-15', 'A'), (10, 6, '2023-03-14', 'C'),
(1, 7, '2023-03-15', 'B'), (2, 8, '2023-03-16', 'A'),
(3, 9, '2022-03-17', 'B'), (4, 10, '2021-03-18', 'A'),
(5, 1, '2023-03-15', 'A'), (6, 4, '2020-03-19', 'B'),
(7, 5, '2022-03-15', 'A'), (8, 7, '2021-03-20', 'C'),
(9, 8, '2020-03-21', 'A'), (10, 9, '2023-03-16', 'B');