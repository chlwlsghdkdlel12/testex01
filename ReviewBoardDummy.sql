commit;
select * from review_board;
select * from like_count;
select * from member;
select * from petsitter;

drop table REVIEW_BOARD;
drop table like_count;


/*riviewBoard*/
create table REVIEW_BOARD(
    LIST_NUM number(10) primary key, -- 리뷰 번호
    USINGLIST_NUM number(10), --이용내역 번호
    MEMBER_ID varchar2(30), -- 회원 아이디
    PETSITTER_ID varchar2(30), -- 펫시터 아이디
    REVIEW_CONTENT varchar2(250), -- 리뷰 내용
    REVIEW_SCORE number(2), -- 리뷰 평점
    REVIEW_UP_PHOTO varchar2(200) default 'N', -- 업로드된 리뷰 사진
    REVIEW_DATE date default sysdate, -- 리뷰 작성일
    LIKE_COUNT number(6), -- 좋아요 수
    BOARD_TYPE VARCHAR2(20) default 'REIVIEW_BOARD', -- 게시판 타입
    REVIEW_REFLY VARCHAR2(250) DEFAULT 'N'--후기게시판 답변
);



/*LIKE_COUNT*/
CREATE TABLE LIKE_COUNT(
    LIKE_NUM NUMBER primary key, --좋아요 번호
    LIKE_ID varchar2(2000), -- 좋아요 아이디
    LIKE_TYPE varchar2(20) default 'REIVIEW_BOARD' -- 좋아요 타입
);

/*트리거*/
CREATE OR REPLACE TRIGGER REVIEW_LIKE_INSERT_TRG1
BEFORE INSERT ON REVIEW_BOARD
BEGIN
INSERT into LIKE_COUNT
VALUES ((SELECT NVL(MAX(LIST_NUM),0)+1 FROM REVIEW_BOARD),'N','REVIEW_BOARD');
END;
/

/*join추가로 닉네임과 주소 값 같이 가져옴*/ 
    select R.RNUM, R.LIST_NUM, R.USINGLIST_NUM, R.MEMBER_ID, R.PETSITTER_ID, R.REVIEW_CONTENT,
        R.REVIEW_SCORE, NVL(R.REVIEW_UP_PHOTO, 'N') REVIEW_UP_PHOTO, 
        R.REVIEW_DATE , R.LIKE_COUNT, R.BOARD_TYPE, R.REVIEW_REFLY,
        M.MEMBER_NICKNAME, NVL(M.MEMBER_PHOTO_FILE, 'N') MEMBER_PHOTO_FILE, P.PETSITTER_NICKNAME, P.PETSITTER_ADDRESS, 
        NVL(P.PETSITTER_PHOTO_PROFILE_FILE, 'N') PETSITTER_PHOTO_PROFILE_FILE , NVL(L.LIKE_ID, 'N') LIKE_ID
    from (select rownum as rnum, LIST_NUM, USINGLIST_NUM, MEMBER_ID, PETSITTER_ID, REVIEW_CONTENT,
        REVIEW_SCORE, REVIEW_UP_PHOTO, REVIEW_DATE, LIKE_COUNT, BOARD_TYPE ,REVIEW_REFLY
    from (select * from REVIEW_BOARD order by LIST_NUM desc)) R, MEMBER M, PETSITTER P, LIKE_COUNT L
    WHERE R.MEMBER_ID = M.MEMBER_ID AND R.PETSITTER_ID = P.PETSITTER_ID AND R.LIST_NUM = L.LIKE_NUM
    order by R.RNUM;
    
    
/*특정 like 추출*/
select R.LIST_NUM, R.MEMBER_ID, R.PETSITTER_ID, R.LIKE_COUNT, R.BOARD_TYPE, 
        NVL(L.LIKE_ID, 'N') LIKE_ID 
        from review_board R, LIKE_COUNT L
        WHERE R.LIST_NUM=2 AND L.LIKE_NUM=2;


INSERT into LIKE_COUNT values('', '','REVIEW_BOARD' );

UPDATE LIKE_COUNT SET LIKE_ID = concat('N',',RTY321' ) WHERE LIKE_NUM = 1;
UPDATE LIKE_COUNT SET LIKE_ID = 'N' WHERE LIKE_NUM = 1;
UPDATE review_board SET LIKE_COUNT=0 WHERE LIST_NUM=1;
/*특정부분값 변경 update*/
UPDATE LIKE_COUNT SET LIKE_ID = REPLACE(LIKE_ID,',wlsghkr12@naver.com','') WHERE LIKE_NUM = 2;
      
/*member petsitter 테이블 더미 랜덤 생성시 아이디 맞추어주어야함*/
insert into REVIEW_BOARD
    values(1, 1, 'roah631@member.com', 'sddntk252', '1따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다사막이다스도 없는 사막이다사막이다', 
    4, 'b20bb30b99304d92bb6d5c2f68df953e.jpg','2020/06/01', 0, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');
    
insert into REVIEW_BOARD 
    values(2, 2, 'rgus492@member.com', 'nebbqa249', 'lksdjfklsdjflksjdaf;nvfio aiovjoisjfojwje eiowjfweijfklwsnm oiewmnfoiwijwofijoiw jfwoie joifj w woei jewmfewim oiwefm oiwem wo me imwoefmeowfoiwjfowijfio jif jowefj oiewfj oi jijeiowjfoiwfjwfjiwieji fiewjo ijwof joewijwjiefowijof', 
    3,'N','2020/06/02', 0, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');

insert into REVIEW_BOARD
    values(3, 3, 'xrwv879@member.com', 'tqjkyc427', '3따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, 'b20bb30b99304d92bb6d5c2f68df953e.jpg,367d90d709b1409aa06f5a22bbdf0476.jpg,70b56dcfeac3435a99094ec36b8348cf.png','2020/06/03', 0, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');

insert into REVIEW_BOARD
    values(4, 4, 'djud878@member.com', 'rttqhf161', '4따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    4, '70b56dcfeac3435a99094ec36b8348cf.png,b20bb30b99304d92bb6d5c2f68df953e.jpg','2020/06/04', 0, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');

insert into REVIEW_BOARD
    values(5, 5, 'fvvv519@member.com', 'nwsfuv416', '4따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, '70b56dcfeac3435a99094ec36b8348cf.png,b20bb30b99304d92bb6d5c2f68df953e.jpg','2020/06/05', 0, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');
    
insert into REVIEW_BOARD
    values(6, 6, 'frgw837@member.com', 'jybpuh271', '4따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    1, '70b56dcfeac3435a99094ec36b8348cf.png,b20bb30b99304d92bb6d5c2f68df953e.jpg','2020/06/06', 0, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');
    
insert into REVIEW_BOARD
    values(7, 7, 'qmtl901@member.com', 'fvblmv253', '7따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, 'b20bb30b99304d92bb6d5c2f68df953e.jpg,367d90d709b1409aa06f5a22bbdf0476.jpg,70b56dcfeac3435a99094ec36b8348cf.png','2020/06/07', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');
    
insert into REVIEW_BOARD
    values(8, 8, 'oxag826@member.com', 'luyvor122', '8따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, '70b56dcfeac3435a99094ec36b8348cf.png,b20bb30b99304d92bb6d5c2f68df953e.jpg','2020/06/08', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');
    
    
insert into REVIEW_BOARD
    values(9, 9, 'tcat516@member.com', 'hdsvjs107', '9따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, 'b20bb30b99304d92bb6d5c2f68df953e.jpg,367d90d709b1409aa06f5a22bbdf0476.jpg,70b56dcfeac3435a99094ec36b8348cf.png','2020/06/09', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');
    
insert into REVIEW_BOARD
    values(10, 10, 'nkyk643@member.com', 'nzlvmo369', '10따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, '70b56dcfeac3435a99094ec36b8348cf.png,b20bb30b99304d92bb6d5c2f68df953e.jpg','2020/06/10', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');

insert into REVIEW_BOARD
    values(11, 11, 'yvoe599@member.com', 'noiwzt902', '11따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, 'b20bb30b99304d92bb6d5c2f68df953e.jpg,367d90d709b1409aa06f5a22bbdf0476.jpg,70b56dcfeac3435a99094ec36b8348cf.png','2020/06/11', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');

insert into REVIEW_BOARD
    values(12, 12, 'bhsm580@member.com', 'efulip859', '12따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, '70b56dcfeac3435a99094ec36b8348cf.png,b20bb30b99304d92bb6d5c2f68df953e.jpg','2020/06/12', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');
    
insert into REVIEW_BOARD
    values(13, 13, 'nzpn502@member.com', 'fhmukb100', '13따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, 'b20bb30b99304d92bb6d5c2f68df953e.jpg,367d90d709b1409aa06f5a22bbdf0476.jpg,70b56dcfeac3435a99094ec36b8348cf.png','2020/06/13', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');
    
insert into REVIEW_BOARD
    values(14, 14, 'yteg322@member.com', 'etnomw672', '14따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    3, '70b56dcfeac3435a99094ec36b8348cf.png','2020/06/14', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');
    
insert into REVIEW_BOARD
    values(15, 15, 'tfxu194@member.com', 'odfvsm174', '15따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    1, '','2020/06/15', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');
    
insert into REVIEW_BOARD
    values(16, 16, 'jahh983@member.com', 'idelkg141', '16따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    4, '70b56dcfeac3435a99094ec36b8348cf.png,b20bb30b99304d92bb6d5c2f68df953e.jpg','2020/06/16', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');    

insert into REVIEW_BOARD
    values(17, 17, 'laza919@member.com', 'oupnyp486', '17따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, 'b20bb30b99304d92bb6d5c2f68df953e.jpg,367d90d709b1409aa06f5a22bbdf0476.jpg,70b56dcfeac3435a99094ec36b8348cf.png','2020/06/17', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');     
    
insert into REVIEW_BOARD
    values(18, 18, 'ermf102@member.com', 'dpnbhm123', '17따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, 'b20bb30b99304d92bb6d5c2f68df953e.jpg,367d90d709b1409aa06f5a22bbdf0476.jpg,70b56dcfeac3435a99094ec36b8348cf.png','2020/06/18', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');   

insert into REVIEW_BOARD
    values(19, 19, 'ermf102@member.com', 'iruvoj897', '17따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, 'b20bb30b99304d92bb6d5c2f68df953e.jpg','2020/06/19', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');       

insert into REVIEW_BOARD
    values(20, 20, 'qqyf915@member.com', 'kkifrg607', '17따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, 'b20bb30b99304d92bb6d5c2f68df953e.jpg,367d90d709b1409aa06f5a22bbdf0476.jpg,70b56dcfeac3435a99094ec36b8348cf.png','2020/06/20', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');  

insert into REVIEW_BOARD
    values(21, 21, 'svin801@member.com', 'wtqlol739', '17따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, 'b20bb30b99304d92bb6d5c2f68df953e.jpg,367d90d709b1409aa06f5a22bbdf0476.jpg,70b56dcfeac3435a99094ec36b8348cf.png','2020/06/21', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');  

insert into REVIEW_BOARD
    values(22, 22, 'xnix735@member.com', 'rzmnbj992', '17따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, 'b20bb30b99304d92bb6d5c2f68df953e.jpg,367d90d709b1409aa06f5a22bbdf0476.jpg,70b56dcfeac3435a99094ec36b8348cf.png','2020/06/22', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');  
    
insert into REVIEW_BOARD
    values(23, 23, 'pbop973@member.com', 'zovhsx280', '17따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    3, '','2020/06/23', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');  
    
insert into REVIEW_BOARD
    values(24, 24, 'ufnp475@member.com', 'kckscp311', '17따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, 'b20bb30b99304d92bb6d5c2f68df953e.jpg,367d90d709b1409aa06f5a22bbdf0476.jpg,70b56dcfeac3435a99094ec36b8348cf.png','2020/06/24', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');  
    
insert into REVIEW_BOARD
    values(25, 25, 'okhu936@member.com', 'qnucec183', '17따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, '367d90d709b1409aa06f5a22bbdf0476.jpg,70b56dcfeac3435a99094ec36b8348cf.png','2020/06/25', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');     

insert into REVIEW_BOARD
    values(26, 26, 'nyyu864@member.com', 'iivsps415', '17따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    5, '70b56dcfeac3435a99094ec36b8348cf.png,b20bb30b99304d92bb6d5c2f68df953e.jpg','2020/06/26', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');  
   
insert into REVIEW_BOARD
    values(27, 27, 'yfkb691@member.com', 'lhpwzv658', '17따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    1, '','2020/06/27', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');      

insert into REVIEW_BOARD
    values(28, 28, 'uytm978@member.com', 'qzwnui599', '17따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    3, '70b56dcfeac3435a99094ec36b8348cf.png,b20bb30b99304d92bb6d5c2f68df953e.jpg','2020/06/28', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');   
    
insert into REVIEW_BOARD
    values(29, 29, 'ryxx648@member.com', 'rrykfp445', '17따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    2, 'b20bb30b99304d92bb6d5c2f68df953e.jpg,367d90d709b1409aa06f5a22bbdf0476.jpg,70b56dcfeac3435a99094ec36b8348cf.png','2020/06/29', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');    

insert into REVIEW_BOARD
    values(30, 30, 'xmdk450@member.com', 'ldrnrz884', '17따뜻한 봄바람을 불어 보내는 것은 청춘의 끓는 피다 청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다', 
    4, '367d90d709b1409aa06f5a22bbdf0476.jpg','2020/06/30', 13, 'REVIEW_BOARD', '언제나 신뢰가는 펫시터가 되기 위해 노력하겠습니다.');       
    
    
CREATE TABLE LIKE_COUNT(
    LIKE_NUM NUMBER DEFAULT -1, --좋아요 번호
    LIKE_ID CLOB, -- 좋아요 아이디
    LIKE_TYPE varchar2(30) -- 좋아요 타입
);



/*REVIEW_BOARD(닉네임 주소 join할시 안됨) 시작*/
insert into REVIEW_BOARD select
    level AS LIST_NUM,
    DBMS_RANDOM.STRING('L', 4) || LPAD(ROUND (DBMS_RANDOM.VALUE(100, 999), 0), 3) || '@member.com' as member_id,
    DBMS_RANDOM.STRING('L', 4) || LPAD(ROUND (DBMS_RANDOM.VALUE(100, 999), 0), 3) as PETSITTER_ID,
    DBMS_RANDOM.STRING('P', 200) as REVIEW_CONTENT,
    LPAD(ROUND (DBMS_RANDOM.VALUE(1, 5), 0),1) as REVIEW_SCORE,
    'dog06.jsp' as REVIEW_ORG_PHOTO,
    'b20bb30b99304d92bb6d5c2f68df953e.jsp' as REVIEW_UP_PHOTO,
    TO_DATE('20190201','YYYYMMDD') + (ROWNUM-1) AS REVIEW_DATE,
    LPAD(ROUND (DBMS_RANDOM.VALUE(0, 99), 0), 2) as LIKE_COUNT
    from dual
    connect by level <= 50;
/*REVIEW_BOARD 종료*/


/*join 안한 기본 select 문*/
select * 
from (select rownum as rnum, LIST_NUM, MEMBER_ID, PETSITTER_ID, MEMBER_NICKNAME, PETSITTER_NICKNAME, REVIEW_CONTENT,
	REVIEW_SCORE, REVIEW_ORG_PHOTO, REVIEW_UP_PHOTO, REVIEW_DATE, LIKE_COUNT 
from (select * from REVIEW_BOARD order by REVIEW_DATE desc)) ;
commit;
