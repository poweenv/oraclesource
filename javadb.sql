--javadb

-- userTBL 테이블 생성
-- no(번호-숫자(4)), username(이름-한글(4)), birthYear(년도-숫자(4)),addr(주소-문자(한글,숫자)),mobile(010-1234-1234)
-- no pk 제약조건 지정(제약조건명 pk_userTBL)
create table userTBL(
    no number(4) constraint pk_userTBL PRIMARY KEY,
    username nvarchar2(10) not null,
    birthYear number(4) not null,
    addr varchar2(50) not null,
    mobile varchar2(14)
);

drop table userTBL;


-- 시퀀스 생성
-- user_seq 생성(기본)
create sequence user_seq;

--insert
-- no : user_seq 넣기
insert into userTBL(no, username,birthyear,addr,mobile)
 values(user_seq.NEXTVAL,'홍길동',2000,'종로구 5길 30','010-1111-2222');

commit;

-- commit == > git : 로컬저장소 저장, git bash,eclipse
-- commit == > sql : DML 작업 시 한번에 실행되어야 하는 단위, DML 작업 한 후 commit(DB 최종 반영) 해야 함, sqldeveloper

--  모든 컬럼 not null
-- paytype : pay_no(number-1,pk), info(문자- card, cash)
-- paytype_seq 시퀀스 생성
create table paytype (
    pay_no number(1) primary key,
    info char(4) not null
);
alter table paytype modify info varchar2(10);
create sequence paytype_seq;
insert into paytype values(paytype_seq.NEXTVAL, 'card');
insert into paytype values(paytype_seq.NEXTVAL, 'cash');
select *from paytype;
drop table paytype;

-- shop
-- user : user_id(숫자-4자리,pk),name(문자-한글), pay_no(숫자-1 : paytype table에 있는 pay_no 참조해서 사용)
create table suser(
    user_id number(4) primary key,
    name nvarchar2(4) not null,
    pay_no number(1) references paytype(pay_no) not null
);
alter table suser modify name varchar2(20);
-- product
-- product_id(숫자-8자리,pk), pname(문자), price(숫자), content(문자), 
create table product(
    product_id number(8) primary key,
    pname nvarchar2(10) not null,
    price number(10) not null,
    content nvarchar2(20) not null
);
alter table product modify pname varchar2(30);
alter table product modify content varchar2(50);
create sequence product_seq;
-- order
-- order_id(숫자-8자리,pk), user_id(user 테이블의 user_id 참조), product_id(product 테이블의 product_id 참조)
create table sorder(
    order_id number(8) primary key,
    user_id number(4) references suser(user_id) not null,
    product_id number(8) references product(product_id) not null
);
create sequence order_seq;
drop table sorder;
alter table sorder add order_date DATE; -- 구매날짜
--insert into sorder values(order_seq.nextval,물건을 구매한id,상품id,날짜)
commit;

select u.user_id,u.name, p.pay_no,p.info
from suser u join paytype p on u.pay_no=p.pay_no where u.user_id=1000;


select * from sorder;

-- 주문목록 조회
-- user_id, name, card/cash, product_id, pname, price, content
select s.user_id, u.name, t.info, p.product_id, p.pname, p.price, p.content, s.order_date
from suser u, product p, paytype t, sorder s
where u.user_id=s.user_id and u.pay_no=t.pay_no and s.product_id=p.product_id;

-- 기준 : sorder
-- suser 테이블 : name, 
-- paytype 테이블 : info,
-- product 테이블 : product_id, pname, price, content

-- security 프로젝트에서 사용할 테이블
-- user 테이블 작성 시 enabled 컬럼 추가

create table sp_user(
    userid varchar2(50) primary key,
    email varchar2(100) not null,
    password varchar2(100) not null,
    enabled char(1) default '1'
);

-- user 테이블과 관련된 권한 테이블 작성
create table sp_user_authority(
    userid varchar2(50) not null,
    authority varchar2(50) not null);

alter table sp_user_authority add constraint sp_user_authority_fk foreign key(userid) references sp_user(userid);

insert into sp_user(userid,email,password) values('hong123','hong123@gmail.com','1111');
insert into sp_user_authority(userid,authority) values('hong123','ROLE_USER');
insert into sp_user_authority(userid,authority) values('hong123','ROLE_ADMIN');
commit;

-- sp_user 와 sp_user_authority left outher join
select s1.userid,email,password,enabled,authority
from sp_user s1 left outer join sp_user_authority s2 on s1.userid=s2.userid;


-- 특정 user의 정보 추출
select s1.userid,email,password,enabled,authority
from sp_user s1 left outer join sp_user_authority s2 on s1.userid=s2.userid
where s1.userid= 'kg12kg';

-- remember me 를 위한 테이블 생성
create table persistent_logins(
    username varchar2(64) not null,
    series varchar2(64) primary key,
    token varchar2(64) not null,
    last_used timestamp not null);
    
-- spring_board 연결할 user 테이블 생성
-- userid, userpw, username(성명), regdate, updatedate,enabled

------ spring_board 
-- bno 숫자(10) 제약조건 pk 제약조건명 pk_spring_board
-- title varchar2(200) 제약조건 not null
-- content varchar2(2000) 제약조건 not null
-- writer varchar2(50) 제약조건 not null
-- regdate date default 로 현재시스템날짜
-- updatedate date default 로 현재시스템날짜
create table spring_board(
    bno number(10) constraint pk_spring_board primary key,
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate);

-- 시퀀스 seq_board
create sequence seq_board;


-- mybatis 연습용 테이블
create table person(
    id varchar2(20) primary key,
    name varchar2(30) not null);
    
select * from person;

insert into person values('kim123','김길동');

commit;


-- 트랜잭션 테스트 테이블
-- 트랜잭션 : 하나의 업무에 여러개의 작은 업무들이 같이 묶여 있음 / 하나의 단위로 처리
-- 계좌이체 : 계좌 출금 => 타 계좌 입금

create table tbl_sample1(col1 varchar2(500));
create table tbl_sample2(col1 varchar2(50));

select * from tbl_sample1;
select * from tbl_sample2;

delete tbl_sample1;
commit;


ALTER TABLE membertbl MODIFY
    password varchar2(100);


-- 페이지 나누기(GET 방식)
-- rownum : 조회된 결과에 번호를 매겨줌
-- spring_board : bno 가 pk 상황(order by 기준도 bno)
-- 1 page : 가장 최신글 20개 
-- 2 page : 그 다음 최신글 20개

insert into spring_board(bno,title,content,writer)
(select seq_board.nextval,title,content,writer from spring_board);

commit;

select count(*) from spring_board;

-- 페이지 나누기를 할 때 필요한 sql 코드
select * 
from (select rownum rn, bno, title, writer
      from (select bno, title, writer from spring_board order by bno desc)
      where rownum <= 20)
where rn>0;


-- 오라클 힌트 사용
select bno, title, writer,regdate,updatedate
from (select /*+INDEX_DESC(spring_board pk_spring_board)*/ rownum rn, bno, title, writer,regdate,updatedate
      from spring_board
      where rownum <= 40)
where rn > 20;

-- 댓글 테이블 
create table spring_reply(
    rno number(10,0) constraint pk_reply primary key, -- 댓글 글번호
    bno number(10,0) not null,                        -- 원본글 글번호
    reply varchar2(1000) not null,                    -- 댓글 내용
    replyer varchar2(50) not null,                    -- 댓글 작성자
    replydate date default sysdate,                   -- 댓글 작성날짜
    constraint fk_reply_board foreign key(bno) references spring_board(bno) -- 외래키 제약조건
);

-- 댓글 테이블 수정(컬럼 추가) updatedate
ALTER TABLE spring_reply ADD updatedate date default sysdate;

create sequence seq_reply;

insert into spring_reply(rno, bno, reply, replyer)
values(seq_reply.nextval,1181,'댓글을 달아요','test1');
commit;

-- 파일첨부
-- spring_attach
-- uuid, uploadpath, filename, filetype
create table spring_attach(
    uuid varchar2(100) constraint pk_attach primary key,
    uploadpath varchar2(200) not null,
    filename varchar2(100) not null,
    filetype char(1) default '1',
    bno number(10,0) not null,
    constraint fk_board_attach foreign key(bno) references spring_board(bno)
);

-- spring_board bno 와 spring_attach bno 일치 시
-- title,content,writer,bno, uuid, uploadpath,filetype,filename
-- inner join

-- spring_reply 인덱스 추가 설정
create index idx_reply on spring_reply(bno desc, rno asc);


select rno, bno, reply, replyer,replydate,updatedate
from (select /*+INDEX(spring_reply idx_reply)*/ rownum rn, rno, bno, reply, replyer,replydate,updatedate
      from spring_reply
      where bno=1181 and rownum <= 10)
where rn > 0;

-- spring_board 에 컬럼 추가(댓글 수 저장)
alter table spring_board add replycnt number default 0;

-- 이미 들어간 댓글 수 삽입
update spring_board
set replycnt = (select count(rno) from spring_reply where spring_board.bno = spring_reply.bno);

commit;

select * from spring_board where bno = 1181;



create table spring_member(
    userid varchar2(50) primary key,
    userpw varchar2(100) not null,
    username varchar2(100) not null,
    regdate date default sysdate,
    updatadate date default sysdate,
    enabled char(1) default '1');

drop table spring_member;
drop table spring_member_auth;

-- spring_member 권한 테이블 생성 => spring_member_auth
-- userid, auth
create table spring_member_auth(
    userid varchar2(50) not null,
    auth varchar2(100) not null,
    constraint fk_member_auth foreign key(userid) references spring_member(userid));















