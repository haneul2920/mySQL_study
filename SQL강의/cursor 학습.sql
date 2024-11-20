-- 1. 변수 준비하기
declare noNumber int default 0;  -- 초기값
declare endOfRow boolean default false; -- 행의 끝을 파악하기 위한 변수

-- 2. 커서 선언
declare memberCursor cursor for 
	select mem_number from member;
    
-- 3. 반복 조건 선언
declare continue handler 
	for not found set endOfRow = true;
    
-- 4. 커서 열기
open memberCursor;

-- 5. 행 반복 하기
cursor_loop : loop
-- 반복할 내용
-- fetch : 한 행씩 읽어 오는 것
-- leave : break 와 동일
	fetch memberCursor into memNumber;

	if endOfRow then
		leave cursor_loop;
	end if;

	set cnt = cnt + 1;
	set totNumber = totNumber + memNumber;
end loop cursor_loop;

select (totNumber/cnt) as '회원의 평균 인원수';

-- 6. 커서 닫기
close memberCursor;

