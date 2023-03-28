-- 대소문자 구별하지 않음(단 비밀번호는 구별함)
-- CREATE : 생성 / ALTER : 수정 / DROP : 삭제 / DELETE : 삭제

-- 오라클 버전이 변경되면서 사용자 생성시 C## 문자를 넣어서 만들도록 변경 됨
-- JAVADB => C##JAVADB 이런 방식을 C## 사용하지 않겠음
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- 사용자 : scott,hr => 데이터베이스 접속하여 관리하는 계정
--        테이블, 인덱스, 뷰 등 여러 객체가 사용자별로 생성됨
--        업무에 따라 사용자들을 나눠서 관리

-- 스키마 : 데이터간 관계, 데이터 구조, 제약조건 등 데이터를 관리 저장하기 위해 정의한 데이터베이스 구조의 범위
-- 스키마 == 사용자(오라클 데이터베이스 경우)

-- 사용자 생성 : 사용자 생성 권한이 필요함 ==> sys, system



--USER 생성 : 공간 할당
--USER 생성은 SYS,SYSTEM 만 가능
--CREATE USER 사용자이름 IDENTIFIED BY 비밀번호
-- 사용자 생성 
-- 비밀번호는 대소문자 구별함 
 CREATE USER JAVADB IDENTIFIED BY 1234
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP;

alter user javadb quota 2m on users;

--GRANT : 권한 부여(사용자 생성만 해서는 아무것도 할 수 없음)
GRANT CONNECT, RESOURCE TO JAVADB;
--뷰 생성 권한
GRANT CREATE VIEW TO SCOTT;
--synonym 생성 권한 부여
grant create synonym to scott;
grant create public synonym to scott;

 CREATE USER JAVADB IDENTIFIED BY TIGER
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP;

GRANT CONNECT, RESOURCE TO SCOTT;

select * from all_users;

GRANT UNLIMITED TABLESPACE TO SCOTT;

GRANT UNLIMITED TABLESPACE TO SCOTT;
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;

-- test 사용자 생성 / 비번 1234
CREATE USER test IDENTIFIED BY 1234;

-- 접속 권한을 부여하지 않으면 의미가 없음

-- 권한 권리
-- 1) system 권한
--    사용자 생성(create user)/ 수정(alter user)/ 삭제(drop user)
--    데이터베이스 접근(create session) / 수정(alter session)
--    여러 객체 생성(view,synonym) 및 관리 권한
-- 2) 객체 권한
--    테이블 수정, 삭제, 인덱스 생성, 삽입, 참조, 조회, 수정
--    뷰 삭제, 삽입, 생성, 조회, 수정
--    시퀀스 수정, 조회
--    프로시저, 함수, 패키지 권한
-- 권한 부여
-- create session(데이터베이스 접근 권한) 을 test 에게 부여
grant create session to test ;

grant resource, create table to test;

-- 테이블 스페이스 users에 권한이 없습니다
ALTER USER test DEFAULT TABLESPACE USERS;
ALTER USER test TEMPORARY TABLESPACE TEMP;
alter user test quota 2m on users;   --users 에 공간 설정

-- scott 에게 test 가 생성한 member 테이블 조회 권한 부여
--grant select on member to scott;

-- 권한 취소
--REVOKE SELECT, INSERT ON member FROM scott;

-- 롤 : 여러 권한들의 모임
-- connect 롤 : create session
-- resource 롤 : create triger, create sequence, create procedure, create table...


-- 사용자 삭제
drop user test;
drop user test CASCADE;  --test와 관련된 모든 객체 같이 삭제

-- 사용자 생성 + 테이블 스페이스 권한 부여
 CREATE USER test2 IDENTIFIED BY 1234
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE TEMP;
-- 권한 부여
grant connect,resource to test2;















