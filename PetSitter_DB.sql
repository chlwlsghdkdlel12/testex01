create table member(
    MEMBER_ID varchar2(30) primary key, --ID
    MEMBER_NICKNAME varchar2(30) DEFAULT 'N', --�г���
    MEMBER_PW varchar2(30), --PW
    MEMBER_NAME varchar2(20), --�̸�
    MEMBER_TEL varchar2(20), --��ȭ��ȣ
    MEMBER_RANK varchar2(30) DEFAULT 'Green', --���('Green', 'Gold', 'VIP')
    MEMBER_COUNT number DEFAULT 0, --�̿�Ƚ��
    MEMBER_AMOUNT number DEFAULT 0, --�� �ݾ�
    MEMBER_DATE date default sysdate, --���Գ�¥
    MEMBER_PHOTO_FILE varchar2(100) DEFAULT 'N', --�����ʻ���
    MEMBER_REPORT number DEFAULT 0, --�Ű���Ƚ��
    MEMBER_GENDER varchar2(4) DEFAULT 'N', -- ����, �߰�
    MEMBER_ADDRESS varchar2(100) DEFAULT 'N',-- �ּ�, �߰�
    MEMBER_POINT number DEFAULT 0 -- ����Ʈ
); 
commit;
create table PETSITTER(
    PETSITTER_ID varchar2(30) primary key, --ID
    PETSITTER_NICKNAME varchar2(30) DEFAULT 'N', --�г���
    PETSITTER_NAME varchar2(20) default 'N', --�̸�
    PETSITTER_PW varchar2(30) default 'N', --PW
    PETSITTER_TEL varchar2(20) default 'N', --��ȭ��ȣ
    PETSITTER_EMAIL varchar2(30) default 'N', --�̸���
    PETSITTER_SCORE number(2,1) DEFAULT 0, --����
    PETSITTER_COUNT number(5) DEFAULT 0, --Ȱ��Ƚ��
    PETSITTER_RANK varchar2(20) DEFAULT 'N', --���('N','Pro', 'GoldPro')
    PETSITTER_ADDRESS varchar2(100) default 'N', --�ּ�
    PETSITTER_INTRODUCE varchar2(2000) default 'N', --�ڱ�Ұ�
    PETSITTER_PRICE_30M varchar2(10), --30�а���(�湮 ����)
    PETSITTER_PRICE_60M varchar2(10), --60�а���(��Ź ����)
    PETSITTER_SERVICE_LIST varchar2(60) default 'N', --������ ����
    PETSITTER_PHOTO_UPFILE varchar2(100) default 'N', --���� ����
    PETSITTER_PHOTO_PROFILE_FILE varchar2(100) default 'N', --������ ����
    PETSITTER_CERT_LIST varchar2(100) default 'N', --�ڰ����̸�
    PETSITTER_PHOTO_CERT_FILE varchar2(300) default 'N', --�ڰ��� ����
    PETSITTER_PHOTO_HOME_FILE varchar2(300) default 'N', --�� ����
    PETSITTER_DATE date DEFAULT sysdate, --���� ��¥
    PETSITTER_TYPE varchar2(20) default 'N', -- �ɾ�����
    PETSITTER_REPORT number(2) default 0, --�Ű���Ƚ��, �߰�
    PETSITTER_GENDER varchar2(4) default 'N',-- ����, �߰�
    PETSITTER_REVIEWCOUNT number(5) DEFAULT 0, --���� ����
    PETSITTER_PHOTO_APPEAL varchar2(300) default 'N', --���� ����
    PETSITTER_AMOUNT number default 0, --�� ���� �ݾ�
    PETSITTER_ADDRX number default 0, -- �ּ��� X��ǥ
    PETSITTER_ADDRY number default 0, -- �ּ��� Y��ǥ
    PETSITTER_SAFEADDR varchar2(100) default 'N' -- �Ƚ��ּ� (���θ��ּ�, ���ּ�)
); 

create table petsitter_schedule(
    PETSITTER_ID varchar2(30),
    START_DATE date,
    END_DATE date
);

create table PET(
	MEMBER_ID varchar2(30),
	PET_CATEGORY varchar2(20),
	PET_KIND varchar2(20),
	PET_NAME varchar2(20), 
	PET_PHOTO varchar2(150), 
	PET_WEIGHT number(3), 
	PET_SIZE varchar2(5), 
	PET_GENDER varchar2(6),
	PET_BIRTH date,
	PET_NEUTERED varchar2(10), 
	PET_POTTYTRAN varchar2(10),
	PET_VAOONE varchar2(10),
	PET_QUESTION varchar2(30), 
	PET_ETC varchar2(200),
	PET_DATE date
);

create table REVIEW_BOARD(
    LIST_NUM number(10), -- ���� ��ȣ
    USINGLIST_NUM number(10), -- �̿볻�� ��ȣ
    MEMBER_ID varchar2(30), -- ȸ�� ���̵�
    PETSITTER_ID varchar2(30), -- ����� ���̵�
    REVIEW_CONTENT varchar2(250) default 'N', -- ���� ����
    REVIEW_SCORE number(2,1) default 0, -- ���� ����
    REVIEW_UP_PHOTO varchar2(200) default 'N', -- ���ε�� ���� ����
    REVIEW_DATE date default sysdate, -- ���� �ۼ���
    LIKE_COUNT number(6) default 0, -- ���ƿ� ��
    BOARD_TYPE VARCHAR2(20) default 'REVIEW_BOARD', -- �Խ��� Ÿ��
    REVIEW_REFLY VARCHAR2(250) DEFAULT 'N'--�ı�Խ��� �亯
);

CREATE TABLE LIKE_COUNT(
    LIKE_NUM NUMBER primary key, --���ƿ� ��ȣ
    LIKE_ID varchar2(2000), -- ���ƿ� ���̵�
    LIKE_TYPE varchar2(20) default 'REVIEW_BOARD' -- ���ƿ� Ÿ��
);
/
--Ʈ����(REVIEW_BOARD, LIKE_COUNT Ʈ����)
CREATE OR REPLACE TRIGGER REVIEW_LIKE_INSERT_TRG1
BEFORE INSERT ON REVIEW_BOARD
BEGIN
INSERT into LIKE_COUNT
VALUES ((SELECT NVL(MAX(LIST_NUM),0)+1 FROM REVIEW_BOARD),'N','REVIEW_BOARD');
END;
/

-- ������ �Խ��� ���̺�
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

-- ���κ��� ���ƿ� ���̺�
CREATE TABLE PRO_LIKE_COUNT(
    LIKE_NUM NUMBER primary key, --���ƿ� ��ȣ
    LIKE_ID varchar2(4000) DEFAULT 'N' -- ���ƿ� ���̵�
);

-- ���κ��� ���ƿ� Ʈ����
CREATE OR REPLACE TRIGGER PRO_LIKE_INSERT_TRG1
BEFORE INSERT ON PRO_BOARD
BEGIN
INSERT into PRO_LIKE_COUNT
VALUES ((SELECT NVL(MAX(PRO_NUM),0)+1 FROM PRO_BOARD),'N');
END;
/

CREATE TABLE PROREPLY (
    BNO NUMBER, 
    RNO NUMBER, 
    CONTENT VARCHAR2(2000 BYTE), 
    WRITER_ID VARCHAR2(30 BYTE), 
    REGDATE DATE DEFAULT sysdate, 
    WRITER_NICKNAME VARCHAR2(30 BYTE),
    B_TYPE VARCHAR2(20) default 'PRO_BOARD' 
);

-- �� �Ű� ���̺�
create table report_article (
    member_num number,
    report_reason varchar2(4000),
    member_id varchar2(30),
    btype varchar2(100),
    processing varchar2(10) default 'N'
);
    
-- ��� �Ű� ���̺�    
create table report_reply (
    bno number,
    rno number,
    report_reason varchar2(4000),
    member_id varchar2(30),
    btype varchar2(100),
    processing varchar2(10) default 'N'
);

-- ȸ�� �Խ��� ���̺�
create table MEMBER_BOARD(
    MEMBER_NUM number(10) PRIMARY KEY, -- ȸ�� �Խ��� �� ��ȣ
    MEMBER_ID varchar2(30), -- ȸ�� ���̵�
    MEMBER_SUBJECT varchar2(100), -- ����
    MEMBER_CONTENT varchar2(4000), -- ����
    MEMBER_ORG_FILE varchar2(100), -- ���� �̸�
    MEMBER_UP_FILE varchar2(100), -- ���ε� ���� �̸�
    MEMBER_READCOUNT number, -- ��ȸ��
    MEMBER_DATE date default sysdate, -- �ۼ���
    MEMBER_LIKECOUNT number, -- ���ƿ� ��
    MEMBER_NICKNAME varchar2(20), -- ȸ�� �г���
    MEMBER_SECRET varchar2(2) default 'N' -- ��� ��
);

-- ����� �Խ��� ���̺�
CREATE TABLE petsitter_qna_board (
    petsitter_id           VARCHAR2(30),
    petsitter_nickname      VARCHAR2(30),
    member_id              VARCHAR2(30),
    member_nickname        VARCHAR2(30),
    petsitter_qna_subject  VARCHAR2(100),
    petsitter_qna_content  VARCHAR2(4000),
    petsitter_qna_date     DATE,
    petsitter_qna_bno      NUMBER
);
-- ����� Q&A ��� ���̺�
CREATE TABLE PQREPLY (
    BNO NUMBER, 
    RNO NUMBER, 
    CONTENT VARCHAR2(2000 BYTE), 
    WRITER_ID VARCHAR2(30 BYTE), 
    REGDATE DATE DEFAULT sysdate, 
    WRITER_NAME VARCHAR2(30 BYTE),
    WRITER_RANK VARCHAR2(10 BYTE)
);

create table report_article (
    member_num number,
    report_reason varchar2(4000),
    member_id varchar2(30),
    btype varchar2(100),
    processing varchar2(10)
);

create table mreply(
    BNO number,
    RNO number,
    CONTENT varchar2(2000),
    WRITER_ID varchar2(30),
    REGDATE date default sysdate,
    WRITER_NAME varchar2(30),
    writer_rank varchar2(10)
);

-- ����Ϳ��� ���� �Խ���
create table COMMUNICATION_BOARD(
	BOARD_NUM number(10) PRIMARY KEY, -- ȸ�� �Խ��� �� ��ȣ
    USINGLIST_NUM number(10), -- �̿� ���� ��ȣ
    BOARD_WRITER varchar2(30), -- �ۼ���(�Ϲ� ȸ�� �г��� or ����� �г���)
	MEMBER_ID varchar2(30), -- �Ϲ� ȸ�� ���̵�
	PETSITTER_ID varchar2(30), -- ����� ȸ�� ���̵�
	BOARD_SUBJECT varchar2(100), -- ����
	BOARD_CONTENT varchar2(4000), -- ����
	BOARD_DATE date default sysdate, -- �ۼ���
	BOARD_CONDITION varchar2(10) default '�亯 ����', -- �亯����/�亯�Ϸ�
	BOARD_TYPE varchar2(10) -- �� ����(������/��Ÿ)
);

-- ����Ϳ��� ���� ���� �Խ���(�Ϸ翡 3�� ���ε� ����)
create table COMMUNICATION_PHOTO_LIST(
    USINGLIST_NUM number(10), -- �̿� ���� ��ȣ
    COMMUNICATION_PHOTO_FILE varchar2(100) default 'N', -- ���ε�� ���� ����
    UPLOAD_DATE date default sysdate, -- ���ε� ����
    PETSITTER_ID varchar2(30) -- ����� ȸ�� ���̵�
);

-- �������� ���̺�
CREATE TABLE NOTICE_BOARD (
    NOTICE_NUM        NUMBER, -- ȸ�� �Խ��� �� ��ȣ
    NOTICE_ID         VARCHAR2(30), -- ȸ�� ���̵�
    NOTICE_SUBJECT    VARCHAR2(100), -- �� ����
    NOTICE_CONTENT    VARCHAR2(4000), -- �� ����
    NOTICE_ORG_FILE   VARCHAR2(100), -- ���� ����
    NOTICE_UP_FILE    VARCHAR2(100), -- ���ε� ���� 
    NOTICE_READCOUNT  NUMBER, -- ��ȸ ��
    NOTICE_DATE       DATE, -- �ۼ�����
    NOTICE_NICKNAME   VARCHAR2(30),
    NOTI			  VARCHAR2(10) -- ��� ���� ����
);

-- ���� ���̺�
create table pay(
    PAY_ID varchar2(30), -- ȸ�� ���̵�
    PAY_AMOUNT number, -- ���� �ݾ�
    PETSITTER_ID varchar2(30), -- �̿� ����� ���̵�
    MERCHANT_UID varchar2(20), -- ���� ��ȣ
    PAY_DATE date default sysdate, -- ������
    PAY_TYPE varchar2(10), -- ��Ź or �湮
    START_DATE date, -- �̿� ���� ��¥
    END_DATE date, -- �̿� ���� ��¥
    PAY_STATUS varchar2(10) default '���� �Ϸ�', -- ���� �Ϸ� or ���� ���
    PAY_POINT number -- ���� ��� ����Ʈ
);

-- �̿� ���� ���̺�
create table USINGLIST(
    LIST_NUM number(10) primary key,
    PETSITTER_ID varchar2(30),
    PETSITTER_ADDR varchar2(100),
    MEMBER_ID varchar2(30),
    LIST_PRICE number(8),
    LIST_START_DATE date,
    LIST_END_DATE date,
    LIST_TYPE varchar2(10),
    MERCHANT_UID varchar2(10) -- �ŷ� ���� ���̵�
);
commit;
-- ȸ��, ���, �Ŵ��� ������
-- ���̵�, �г���, ��й�ȣ, �̸�, �޴���, ���, �̿�Ƚ��, �� �ݾ�, ���� ��¥, ������ ����, �Ű� Ƚ��, ����, �ּ�, ����Ʈ
insert into member 
values('petmember2@naver.com', '���̶�', '123456', '�����', '01011111111', 'VIP', 0,0,sysdate,'xvxcverv.jpg',0, '��','06611,���� ���ʱ� ������� 459,��Ʈķ�� 3�� 302ȣ', 0);
insert into member 
values('petmember1@nate.com', 'Ǫ���', '123456', '������', '01022222222', 'Green', 0,0,sysdate,'sdfvzsffdvdzfv.PNG',0, '��','06611,���� ���ʱ� ������� 459,��Ʈķ�� 3�� 302ȣ', 0);
insert into member values('petmember3@nate.com', '��������', '123456', '������', '01022252222', 'Green', 0,0,sysdate,'N',0, '��','06611,���� ���ʱ� ������� 459,��Ʈķ�� 3�� 302ȣ',0);
insert into member values('petmember4@nate.com', '����', '123456', '������', '01022662222', 'Green', 0,0,sysdate,'089f68773d8e7d4e0e6865fca840bdc6.jpg',0, '��','06611,���� ���ʱ� ������� 459,��Ʈķ�� 3�� 302ȣ',0);
insert into member values('petmember5@nate.com', '�㽺Ű��', '123456', '������', '01022252222', 'Gold', 25,0,sysdate,'N',0, '��','06611,���� ���ʱ� ������� 459,��Ʈķ�� 3�� 302ȣ',0);
insert into member values('petmember6@nate.com', '��������', '123456', '������', '01022232222', 'Green', 0,0,sysdate,'fddfdfffb.jpg',0, '��','06611,���� ���ʱ� ������� 459,��Ʈķ�� 3�� 302ȣ',0);
insert into member values('petmember7@nate.com', '���̾�', '123456', '������', '01022522222', 'Gold', 25,0,sysdate,'sdfvzsffdvdzfv.PNG',0, '��','06611,���� ���ʱ� ������� 459,��Ʈķ�� 3�� 302ȣ',0);
insert into member values('petmember8@nate.com', '����������', '123456', '�̽ÿ�', '01032222222', 'Green', 0,0,sysdate,'N',0, '��','06611,���� ���ʱ� ������� 459,��Ʈķ�� 3�� 302ȣ',0);
insert into member values('doctor@nate.com', '���ǻ�', '123456', '�����', '01032222222', 'VIP', 0,0,sysdate,'AA222.jpg',0, '��','06611,���� ���ʱ� ������� 459,��Ʈķ�� 3�� 302ȣ',0);

insert into member 
values('admin@a.a', '���', '123456', '��', '01055555555', 'admin', 0,0,sysdate,'szdrfzdsegedrgd.png',0, '��','06611,���� ���ʱ� ������� 459,��Ʈķ�� 3�� 302ȣ', 0);
insert into member 
values('manager@m.m', '�Ŵ���', '123456', '���Ŵ�', '01066666666', 'manager', 0,0,sysdate,'szdrfzdsegedrgd.png',0, '��','06611,���� ���ʱ� ������� 459,��Ʈķ�� 3�� 302ȣ', 0);

-- ����� ���� ������
insert into PETSITTER values('petsitter', '����Բ�', '���Ʒ�', '123456',  '01033333333', 'petsitter@nate.com', 0, 0, 'Pro','06611,���� ���ʱ� ������� 459,��Ʈķ�� 3�� 302ȣ',
'�ȳ��ϼ��� �ŷڰ��� ����Ͱ� �Ǳ����� ����ϴ� ����Բ��Դϴ�. �׻� ���� ���񽺸����� �غ� ���߰� ������ Ư���� ������ �ִٸ� �ִ��� ���纸���� �ϰڽ��ϴ�.',5000,2000,'������ �ɾ� ����,�Ⱦ� ����,���� ����','sdgsdgsdg.jpg','sdgsdgsdg.jpg',
'Petstiny�Ʒû��ڰ���,�����ְ߰����ڰ���,�ְ߹̿��ڰ���','xzcsdzzzsz.jpg,ghjtyeeett.jpg,sdgsgsgdsdvvbvvccc.jpg', '999F1C415E3CECE02C.png,ae483d2d94a57dc606f7e8596fe21c41.jpg,5e94e4c7db7c809802d1585085f7cd40.jpg',
sysdate,'�湮,��Ź',0,'��',0,'awsvsvsv.jpg,vcervever.jpg,rewerwerw.jpg,', 0, 127.024481869429, 37.5031241023357, '���� ������ ������� ���� 102,�ų����� 7���ⱸ 5�аŸ�');

insert into PETSITTER values('sitter01', '���̶�', '�̼���', '123456',  '01044444444', 'sitter01@naver.com', 0, 25, 'GoldPro','06611,���� ���ʱ� ������� 459,��Ʈķ�� 3�� 302ȣ',
'�ȳ��ϼ��� �ŷڰ��� ����Ͱ� �Ǳ����� ����ϴ� ���̶��Դϴ�. �׻� ���� ���񽺸����� �غ� ���߰� ������ Ư���� ������ �ִٸ� �ִ��� ���纸���� �ϰڽ��ϴ�.',5000,2000,'�Ⱦ� ����,���� ����','awsvsvsv.jpg','awsvsvsv.jpg',
'Petstiny�Ʒû��ڰ���,�����ְ߰����ڰ���,�ְ߹̿��ڰ���','xzcsdzzzsz.jpg,ghjtyeeett.jpg,sdgsgsgdsdvvbvvccc.jpg', 'd6dcae1bc882dff4437b681705989106.jpg,c8192daa51629691994dfb373172f8f1.jpg,e172e8ad46d34a98a4587a8169ee7141.jpg',
sysdate,'�湮,��Ź',0,'��',0,'20190430_03a3da83912a14b8d9dfd67b7ccf538c.jpg,sdfsdfsaasaasassa.jpg,B003059676.jpg,', 0, 127.024481869429, 37.5031241023357, '���� ������ ������� ���� 102,�ų����� 7���ⱸ 5�аŸ�');
