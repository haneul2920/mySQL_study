use studentmanagement;


select * from courseprofessors;
select * from courses;
select * from enrollments;
select * from professors;
select * from students;


-- 1. 학생의 이름과 수강 중인 강좌명 조회
select S.name, C.CourseName
	from students S
	inner join courses C on S.major = C.Department;


-- 2. 강좌명과 담당 교수의 이름 조회
select P.name , C.CourseName
	from professors P
	inner join courses C on P.Department = C.Department;


-- 3. 학과별 교수와 해당 교수의 담당 강좌 목록 조회
select P.Department,P.name,C.CourseName
	from professors P
	inner join courses C on C.Department = P.Department;

 
-- 4. 특정 학생이 수강한 과목과 해당 과목의 학점 조회 (예: '김철수' 학생)
select S.name, C.Department, E.grade
	from students S
    inner join enrollments E on S.studentid = E.StudentID
    inner join courses C on C.department = S.major
    where S.name = "김철수";
 

-- 5. 각 학생의 이름과 성적, 그리고 담당 교수 이름 조회
select * from courseprofessors;
select * from courses;
select * from enrollments;
select * from professors;
select * from students;


select S.name, E.grade, P.name 
	from students S
	inner join emrollments E on S.StudentID = E.StudentID
    inner join professors P on P.Department = S.Major;
    
    
    
-- LEFT OUTER JOIN 예제
-- 1. 모든 학생과 그 학생이 수강 중인 강좌를 조회 (수강하지 않은 학생도 포함)
select S.name,C.CourseName
	from students S
	left outer join enrollments E
    on E.StudentID = S.StudentID
	left outer join courses C
    on S.StudentID = C.CourseID
    order by S.name desc;

    
 

-- 2. 모든 강좌와 해당 강좌에 등록된 학생의 이름 조회 (학생이 등록하지 않은 강좌도 포함)
select C.CourseName,S.name
	from courses C
    left join enrollments E
    on C.CourseID = E.CourseID
    left join students S
    on S.StudentID = E.StudentID; 
 

-- 3. 모든 학생과 각 학생의 성적을 조회 (성적이 없는 학생도 포함)
select S.name, E.grade
	from students S
    left join enrollments E
    on S.StudentID = E.StudentID;
 

-- 4. 모든 강좌와 담당 교수를 조회 (담당 교수가 없는 강좌도 포함)
select C.CourseName,P.name
	from courses C
    left join professors P
    on C.Department = P.Department
    left join courseprofessors CP
    on CP.CourseID = c.CourseID    
    order by P.name;
       

 

-- 5. 모든 교수가 담당하는 강좌를 조회 (강좌를 담당하지 않는 교수도 포함)
select P.name,C.CourseName
	from professors P
    left join courseprofessors CP
    on P.ProfessorID = CP.CourseID
    left join courses C
    on C.Department = P.Department;

 

-- RIGHT OUTER JOIN 예제
-- 1. 모든 강좌와 해당 강좌를 수강하는 학생의 이름 조회 (등록되지 않은 학생도 포함)
select S.name, C.CourseName
	from students S
    right join courses C
    on S.Major = C.Department
    order by S.name;

 

-- 2. 모든 수강 정보와 해당 강좌의 강좌명 조회 (강좌가 등록되지 않은 수강 정보도 포함)
select E.EnrollmentDate, C.CourseName
	from courses C
    right join enrollments E
    on C.CourseID = E.CourseID;

 

-- 3. 모든 교수와 담당 강좌 조회 (담당 강좌가 없는 교수도 포함)
select P.name, C.CourseName
	from courses C
    right join professors P
    on P.Department = C.Department;
    
 

-- 4. 모든 학생과 수강 정보 조회 (수강 기록이 없는 학생도 포함)
select S.name, E.EnrollmentDate
	from enrollments E
    right join students S
    on S.StudentID = E.StudentID;
 

-- 5. 모든 강좌와 각 강좌의 학점 및 담당 교수 조회 (담당 교수가 없는 강좌도 포함)
select C.CourseName, C.Credits, P.name
	from professors P
    right join courseprofessors CP
    on P.ProfessorID = CP.ProfessorID
    right join courses C
    on CP.CourseID = C.CourseID
    right join enrollments E
    on E.CourseID = C.CourseID;
    
    
-- 1. 학생별 수강 강좌와 성적을 조회 (수강하지 않은 학생 포함)
select S.name, C.coursename, E.grade
	from students S
    inner join enrollments E on E.StudentID = S.StudentID
    inner join courses C on C.CourseID = E.CourseID;

-- 2. 담당 교수와 그 교수가 담당하는 강좌 및 학과 조회 (강좌가 없는 교수 포함)
select P.name, C.CourseName, P.Department
	from professors p 
    inner join courseprofessors CP on P.ProfessorID = CP.ProfessorID
    inner join courses C on C.CourseID = CP.CourseID;

-- 3. 각 학생이 수강 중인 강좌와 해당 강좌의 교수 이름 조회 (수강하지 않은 학생 포함)
select S.Name, C.coursename,P.name
	from students S
    inner join enrollments E on S.StudentID = E.StudentID
    inner join courses C on C.CourseID = E.CourseID
    inner join courseprofessors CP on CP.CourseID = C.CourseID
    inner join professors P on CP.ProfessorID = P.ProfessorID;

-- 4.  강좌별로 수강 학생 수 조회 (학생이 등록되지 않은 강좌 포함)
select C.name
	from courses C
    inner join students S on ;

-- 5. 학생의 이름, 수강 강좌, 학점 및 담당 교수 이름 조회 (수강하지 않은 학생 포함)

-- 6. 교수별로 담당하는 강좌와 수강 중인 학생 수 조회 (담당 강좌가 없는 교수 포함)

-- 7. 강좌명과 해당 강좌에 등록된 학생 및 성적 조회 (학생이 등록하지 않은 강좌 포함)

-- 8. 강좌별 학과와 해당 학과의 교수 및 담당 강좌 조회 (담당 강좌가 없는 교수 포함)

-- 9. 학과별로 제공되는 강좌와 담당 교수 이름 조회 (담당 교수가 없는 강좌 포함)

-- 10. 특정 학과(예: '컴퓨터공학')에서 제공되는 강좌와 각 강좌의 담당 교수 조회 (담당 교수가 없는 강좌 포함)
    