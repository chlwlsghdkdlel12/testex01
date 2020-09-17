COMMIT;
select * from pro_board;
drop table pro_board; 
select * from member;
select * from petsitter;

create table PRO_BOARD(
    PRO_NUM number(6) primary key, -- 글 번호  
    MEMBER_ID varchar2(30), -- 아이디
    MEMBER_NICKNAME varchar2(30) DEFAULT 'N', --닉네임  
    PRO_SUBJECT varchar2(100), -- 제목
    PRO_CONTENT varchar2(3000), -- 내용
    PRO_ORG_FILE varchar2(100), -- 파일이름
    PRO_UP_FILE varchar2(100), -- 업로드된 파일이름
    PRO_READCOUNT number, -- 조회수
    PRO_DATE date default sysdate, -- 작성일
    PRO_LIKECOUNT number, -- 좋아요 수
    BOARD_TYPE VARCHAR2(20) default 'PRO_BOARD', -- 게시판 타입 
    SECRET_CHECK VARCHAR2(4) default 'N' -- 비밀게시판 확인 
);

select rnum, PRO_NUM, MEMBER_ID, MEMBER_NICKNAME, PRO_SUBJECT, PRO_CONTENT, PRO_ORG_FILE, PRO_UP_FILE, PRO_READCOUNT, PRO_DATE, PRO_LIKECOUNT, BOARD_TYPE , SECRET_CHECK
from (select rownum rnum,PRO_NUM, MEMBER_ID, MEMBER_NICKNAME, PRO_SUBJECT, PRO_CONTENT, PRO_ORG_FILE, PRO_UP_FILE, PRO_READCOUNT, PRO_DATE, PRO_LIKECOUNT, BOARD_TYPE, SECRET_CHECK 
     from (select * from PRO_BOARD order by PRO_NUM desc))
where rnum>=1 and rnum<=6;


SELECT MEMBER_NICKNAME FROM MEMBER
WHERE MEMBER_ID = 'rgus492@member.com';


insert into PRO_BOARD values (1, 'roah631@member.com', 'nickname01','제목1','1안녕하세요 유기견을 입양했는데 아픈부분을 발견했어요 어떻게 치료할가요.',
'123.jpg','12321312.jpg',0 ,sysdate, 0, 'PRO_BOARD', NVL(null, 'N'));
    
insert into PRO_BOARD values (2, 'rgus492@member.com', 'nickname01','제목2','2안녕하세요 유기견을 입양했는데 아픈부분을 발견했어요 어떻게 치료할가요.',
'123.jpg','12321312.jpg',0 ,sysdate, 0, 'PRO_BOARD', NVL(null, 'N'));

insert into PRO_BOARD values (3, 'xrwv879@member.com', 'nickname01','제목3','3안녕하세요 유기견을 입양했는데 아픈부분을 발견했어요 어떻게 치료할가요.',
'123.jpg','12321312.jpg',0 ,sysdate, 0, 'PRO_BOARD', NVL(null, 'N'));

select * from PRO_BOARD where PRO_NUM = 12;


/*PRO_BOARD 파일*/
insert into PRO_BOARD select
    level AS PRO_NUM,
    DBMS_RANDOM.STRING('L', 4) || LPAD(ROUND (DBMS_RANDOM.VALUE(100, 999), 0), 3) || '@member.com' as member_id,
    DBMS_RANDOM.STRING('L', 2) || LPAD(ROUND (DBMS_RANDOM.VALUE(100, 999), 0), 2) || 'MN' as member_nickname,    
    DBMS_RANDOM.STRING('P', 20) as PRO_SUBJECT,
    DBMS_RANDOM.STRING('P', 200) as PRO_CONTENT,
    '' as PRO_ORG_FILE,
    '' as PRO_UP_FILE,
    0 as PRO_READCOUNT,
    sysdate as pro_date,
    0 as PRO_LIKECOUNT,
    'PRO_BOARD' AS BOARD_TYPE,
    'N' AS SECRET_CHECK
    from dual
connect by level <= 200;
/*PRO_BOARD종료*/

