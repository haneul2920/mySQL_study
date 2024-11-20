USE Librarydb;

SELECT * FROM books;
SELECT * FROM loans;
SELECT * FROM members;

-- WHERE 문제
-- 1. 대출 가능한 책들 중 특정 출판사(예: HarperOne)의 책만 조회하세요.
select * from books
	where Available = 1 and publisher = "HarperOne";
 

-- 2. 가입 날짜가 2024-05-01과 2024-07-31 사이인 회원을 조회하세요.
select * from members
	where joindate between '2024-05-01' and '2024-07-31';

 

-- 3. LoanDate가 ReturnDate 이전인 대출 기록을 조회하세요.
select * from loans
	where LoanDate < ReturnDate;

 

-- GROUP BY 문제
-- 1. 책의 출판사별로 책 수를 조회하고, 출판사 이름과 해당 출판사에 속한 책의 수를 출력하세요.
select title,Publisher, count(*) bookcount from books
	group by title,Publisher;
 

-- 2. LoanDate를 기준으로 연도별 대출된 책의 수를 조회하세요.
select LoanDate,memberID, count(*)loancount from loans
	group by LoanDate,MemberID
	order by LoanDate;
 

-- 3. 가입 연도별 회원 수를 조회하고, 해당 연도와 해당 연도에 가입한 회원 수를 출력하세요.
select joindate,count(*) joindatecount from members
	group by joindate;

 

-- HAVING 문제
-- 1. 각 작가별 책 수가 2권 이상인 작가만 조회하세요.
select Author,count(*) bookcount from books
	group by author
    having bookcount >= 2;

 

-- 2. 출판 연도별 책의 수가 3권 이상인 연도만 조회하세요.
select YearPublished,count(*) bookcount from books
	group by YearPublished
	having bookcount >=3;

 

-- 3. 회원별 대출 기록 수가 1회 이상인 회원만 조회하세요.
select MemberID,count(*) loancount from loans
	group by MemberID
    having loancount >=1 ;

-- 1. 특정 장르의 책을 조회 (예: Fiction)
SELECT * FROM books
	WHERE Genre = "fiction";
 

-- 2. 특정 작가의 책 목록 조회 (예: George Orwell)
SELECT * FROM books
	WHERE Author = "George Orwell";
 

-- 3. 대출된 책만 조회
 SELECT * FROM loans
	WHERE Returned = 0;

-- 4. 특정 날짜 이후에 가입한 회원 조회 (예: 2024-04-01 이후)
SELECT * from members
	where joindate > "2024-04-01";
 

-- 5. 특정 회원이 대출한 책 목록 조회 (예: MemberID가 1인 경우)
SELECT * FROM loans
	where MemberID = "1";
    
    
-- 1. 장르별 책 수 조회
select genre, count(*) genrecount from books
	group by genre;

-- 2. 출판 연도별 책 수 조회
select YearPublished,count(*) from books
	group by YearPublished;

-- 3. 각 회원이 대출한 책 수 조회
select memberID,count(*) from loans
	group by memberid;


-- 4. 가입 년도별 회원 수 조회
select joindate, count(*) from members
	group by joindate ;


-- 5. 작가별 책 수 조회
select author, count(*) from books
	group by author;
 
 
 -- 1. 장르별 책 수가 2권 이상인 장르만 조회
select genre, count(*) genrecount from books
	group by genre
    having genrecount>=2;

-- 2. 특정 출판 연도에 출간된 책이 1권 이상인 출판 연도 조회
select yearpublished, count(*) yearpublishedcount from books
	group by yearpublished
    having yearpublishedcount >= 1;

-- 3. 대출 수가 2회 이상인 회원 조회
select MemberID, count(*) MemberIDcount from loans
	group by MemberID
    having MemberIDcount >= 2;

-- 4. 작가별 책 수가 1권 이상인 작가 조회
select author, count(*)authorcount from books
	group by author
    having authorcount>=1;

-- 5. 특정 장르에 대해 대출 가능한 책 수가 1권 이상인 장르만 조회
select genre,available, count(*) genrecount from books
	group by genre,available
    having available >= 1;  
 

-- 1. 책의 출판 연도순으로 정렬
select *from books
    order by yearpublished;	
 

-- 2. 최신 가입 날짜순으로 회원 정렬
select * from members
	order by joindate desc;

-- 3. 대출 날짜를 기준으로 대출 기록을 오름차순 정렬
select * from loans
	order by loandate;

 

-- 4. 책 제목을 기준으로 내림차순 정렬
select * from loans
	order by loandate desc; 

-- 5. 작가별로 오름차순, 같은 작가 내에서는 출판 연도순으로 정렬
select * from books
	order by Author;

-- 1. 최신 출간된 책 5권 조회
select title,yearpublished
	from books
    order by yearpublished desc limit 0,5;
 

-- 2. 가장 먼저 가입한 회원 3명 조회
select * from members
	order by JoinDate limit 0,3;
 

-- 3. 최근 대출된 대출 기록 5건 조회
select * from loans
	order by LoanDate desc limit 0,5;
 

-- 4. 장르별 책 수 조회에서 상위 3개 장르만 조회
select * from books;
select genre "장르",COUNT(*) bookcount from books	
	group by genre
    order by bookcount desc limit 0,3;

-- 5. 책을 제목순으로 정렬하여 상위 5권 조회
select * from books
	order by title asc limit 0,5; 
 
 
 -- 1. 특정 작가들의 책만 조회 (예: George Orwell, Jane Austen, J.D. Salinger)
 select * from books
	where Author in("George Orwell", "Jane Austen", "J.D. Salinger");
 
-- 2. 특정 출판 연도에 출판된 책 조회 (예: 1949, 1951, 1988)
select * from books
	where YearPublished in(1949, 1951, 1988);

-- 3. 특정 회원들만 조회 (예: MemberID가 1, 3, 5인 회원들)
select * from members
	where MemberID in(1,3,5);

-- 4. 특정 장르들만 조회 (예: Fiction, Adventure)
select * from books
	where genre in('Fiction', 'Adventure');

 

-- 5. 특정 대출 상태(반납 여부)가 적용된 대출 기록 조회 (예: Returned가 TRUE인 기록들)
select * from loans
	where Returned in(true);

 
 
 -- 1. 'The'로 시작하는 책 제목 조회
 select * from books
	where title like "The%"; 

-- 2. 'son'으로 끝나는 성을 가진 회원 조회
select * from members
	where lastname like "%son";


-- 3. 이메일 도메인이 'example.com'인 회원 조회
select * from members
	where Email like "%example%";
 

-- 4. 작가 이름에 'Leo'가 포함된 책 조회
select * from books
	where author like "%Leo%";
 

-- 5. 전화번호가 '123'로 시작하는 회원 조회
select * from members
	where phone like "123%";
