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



