USE LibraryDB;

 select * from members;
 select * from loans;
 select * from books;

-- 1. 회원의 이름과 대출한 책 제목을 조회 : Loans와 Books 테이블을 INNER JOIN하여, 대출된 책의 제목과 회원 이름을 출력합니다.
select distinct M.firstname,M.lastname, B.title
	from books B
	inner join loans L on B.bookid = L.bookid
    inner join members M on L.memberid = M.memberid
    where returned = 0;

 

-- 2. 반납되지 않은 책 목록과 해당 책을 대출한 회원의 이메일 조회 : Loans와 Members, Books 테이블을 INNER JOIN하여 반납되지 않은 책의 제목과 회원 이메일을 가져옵니다.
select distinct M.firstname,M.lastname, M.email, B.title
	from books B
	inner join loans L on B.bookid = L.bookid
    inner join members M on L.memberid = M.memberid
    where L.returned = 1;
 

-- 3. 특정 출판사의 책을 대출한 회원의 이름과 대출 날짜 조회 : Loans와 Books 및 Members 테이블을 INNER JOIN하여 특정 출판사(예: 'Scribner')의 책을 대출한 회원의 이름과 대출 날짜를 출력합니다.
select distinct M.firstname, M.lastname,L.loandate , B.publisher
	from books B
	inner join loans L on B.bookid = L.bookid
    inner join members M on L.memberid = M.memberid
    group by M.firstname, M.lastname,L.loandate , B.publisher
    having publisher = "Scribner";
 

-- 4. 대출된 책의 장르별 대출 횟수 조회 : Loans와 Books 테이블을 INNER JOIN하여, 각 장르별로 대출된 책의 수를 출력합니다.
select B.genre, count(L.bookid) genrecount
	from books B
	inner join loans L on L.bookid = B.bookid
    group by B.genre; 
 

-- 5. 대출한 회원이 많은 책 목록과 그 대출 횟수 조회 : Loans와 Books 테이블을 INNER JOIN하여 각 책별로 대출된 횟수를 조회하고, 대출 횟수가 많은 순으로 정렬합니다.
select B.title, L.memberid, count(*) loancount 
	from loans L
	inner join books B on B.bookid = L.loanid
	group by B.title, L.memberid
    order by loancount desc;
