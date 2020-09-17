COMMIT;
select * from pro_board;
drop table pro_board; 
select * from member;
select * from petsitter;

create table PRO_BOARD(
    PRO_NUM number(6) primary key, -- �� ��ȣ  
    MEMBER_ID varchar2(30), -- ���̵�
    MEMBER_NICKNAME varchar2(30) DEFAULT 'N', --�г���  
    PRO_SUBJECT varchar2(100), -- ����
    PRO_CONTENT varchar2(3000), -- ����
    PRO_ORG_FILE varchar2(100), -- �����̸�
    PRO_UP_FILE varchar2(100), -- ���ε�� �����̸�
    PRO_READCOUNT number, -- ��ȸ��
    PRO_DATE date default sysdate, -- �ۼ���
    PRO_LIKECOUNT number, -- ���ƿ� ��
    BOARD_TYPE VARCHAR2(20) default 'PRO_BOARD', -- �Խ��� Ÿ�� 
    SECRET_CHECK VARCHAR2(4) default 'N' -- ��аԽ��� Ȯ�� 
);

select rnum, PRO_NUM, MEMBER_ID, MEMBER_NICKNAME, PRO_SUBJECT, PRO_CONTENT, PRO_ORG_FILE, PRO_UP_FILE, PRO_READCOUNT, PRO_DATE, PRO_LIKECOUNT, BOARD_TYPE , SECRET_CHECK
from (select rownum rnum,PRO_NUM, MEMBER_ID, MEMBER_NICKNAME, PRO_SUBJECT, PRO_CONTENT, PRO_ORG_FILE, PRO_UP_FILE, PRO_READCOUNT, PRO_DATE, PRO_LIKECOUNT, BOARD_TYPE, SECRET_CHECK 
     from (select * from PRO_BOARD order by PRO_NUM desc))
where rnum>=1 and rnum<=6;


SELECT MEMBER_NICKNAME FROM MEMBER
WHERE MEMBER_ID = 'rgus492@member.com';


insert into PRO_BOARD values (1, 'roah631@member.com', 'nickname01','����1','1�ȳ��ϼ��� ������� �Ծ��ߴµ� ���ºκ��� �߰��߾�� ��� ġ���Ұ���.',
'123.jpg','12321312.jpg',0 ,sysdate, 0, 'PRO_BOARD', NVL(null, 'N'));
    
insert into PRO_BOARD values (2, 'rgus492@member.com', 'nickname01','����2','2�ȳ��ϼ��� ������� �Ծ��ߴµ� ���ºκ��� �߰��߾�� ��� ġ���Ұ���.',
'123.jpg','12321312.jpg',0 ,sysdate, 0, 'PRO_BOARD', NVL(null, 'N'));

insert into PRO_BOARD values (3, 'xrwv879@member.com', 'nickname01','����3','3�ȳ��ϼ��� ������� �Ծ��ߴµ� ���ºκ��� �߰��߾�� ��� ġ���Ұ���.',
'123.jpg','12321312.jpg',0 ,sysdate, 0, 'PRO_BOARD', NVL(null, 'N'));

select * from PRO_BOARD where PRO_NUM = 12;


/*PRO_BOARD ����*/
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
/*PRO_BOARD����*/

