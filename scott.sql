--scott 

--emp 테이블 구성 보기
-- 필드명(열이름) 제약조건   데이터타입
-- empno(사원번호)not null   number(4)
-- ename(사원명),job(직책),mgr(직속상관 번호),hiredate(입사일),sal(급여),comm(수당),deptno(부서번호) 
-- number : 소수점 자릿수를 포함해서 지정가능
-- number(4) : 4자리 숫자까지 허용 , number(8,2) : 전체 자릿수는 8자리이고 소수점 2자리를 포함한다.
--varchar2 : 가변형 문자열 저장
--varchar2 : 10byte 문자까지 저장 가능
--date :  날쫘 데이터


desc emp;
--deptno(부서번호),dname(부서명),loc(부서위치)
desc dept;
--select: 데이터 조회
desc salgrade
--grade(급여등급),losal(최소 급여액),hisal(최대 급여액)

--select : 데이터 조회
--조회 방식: 섹렉션(행 단위로 조회),프로젝션(열 단위로 조회,조인(두개 이상의 테이블을 사용하여 조회)
--select 열이름1, 열이름2.... (조회할 열이 전체라면*로 처리)
--from 테이블명;

--1.emp 테이블의 전체 열을 조회
SELECT
    *
FROM
    emp;

--2. emp 테이블에서 사원번호,이름,급여 열을 조회
--ctrl + f7 : 정렬
SELECT
    empno,
    ename,
    sal
FROM
    emp;

SELECT
    *
FROM
    emp;
    
--3. dept 테이블 전체 조회
SELECT
    *
FROM
    dept;
--4. dept 테이블안에 부서번호, 지역만 조회
SELECT
    deptno,
    loc
FROM
    dept;

SELECT
    deptno
FROM
    emp;

--6. emp 테이블안에 부서번호 조회(단, 중복된 부서 번호는 제거)
--distinct : 중복 제거
SELECT DISTINCT
    deptno
FROM
    emp;
-- 열이 여러개인 경우 (묶어서 중복이냐 아니냐를 판단)
SELECT DISTINCT
    job,
    deptno
FROM
    emp;
    
-- 7. 연산
-- 별칭 : 필드에 별칭을 임의로 부여( as 별칭, 혹은 한칸 띄고 별칭, 별칭에 공백이 있다면 ""로 묶어주기
-- ex)사원들의 1년 연봉 구하기 ( sal * 12 *comm)
SELECT
    empno,
    ename,
    sal * 12 + comm AS annsal
FROM
    emp;

SELECT
    empno,
    ename           사원명,
    job             직책,
    sal * 12 + comm annsal
FROM
    emp;

--8.정렬 : ORDER BY
--        내림차순 정렬 => DESC, 오름차순 정렬 => ASC

--ENAME, SAL 열 추출하고, SAL 내림차순으로 정렬

SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    ename;  --ASC 생략가능
    
--전체 내욜 출력 사원번호의 오름차순

SELECT
    *
FROM
    emp
ORDER BY
    empno;

--전체 내용 출력하고, 결과가 부서번의 오름차순과 급여 내림차순으로 정렬
--ORDER BY 는 데이터양이 많을수록 시간이 많이 걸려서 권장하는 방식은 아니다
SELECT
    *
FROM
    emp
ORDER BY
    deptno,
    sal DESC;
    
--[실습] EMP 테이블의 모든 열 출력
-- EMPNO => EMPLOYEE_NO
-- ENAME => EMPLOYEE_NAME
-- MGR => MANEGER
-- SAL => SALARY
-- COMM => COMMISSION
-- DEPT => DEPARTMENT_NO
-- 부서번호를 기준으로 정렬하되 부서번호가 같다면 사원이름을 기준으로 오름차순정렬

SELECT
    empno  AS employee_no,
    ename  employee_name,
    job,
    mgr    AS maneger,
    hiredate,
    sal    AS salary,
    comm   commission,
    deptno department_no
FROM
    emp
ORDER BY
    deptno DESC,
    ename;
    
--WHERE : 특정 조건을 기준으로 원하는 행을 조회
--WHERE 절에서 여러개 나열하고싶다면 AND 이고 문자는 ''안에 쓴다
--부서번호가 30인 데이터만 조회

SELECT
    *
FROM
    emp
WHERE
    deptno = 30;

SELECT
    *
FROM
    emp
WHERE
    empno = 7782;

SELECT
    *
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN';

SELECT
    *
FROM
    emp
WHERE
        empno = 7499
    AND deptno = 30;

SELECT
    *
FROM
    emp
WHERE
    deptno = 30
    OR job = 'CLERK';

-- 산술연산자 : +-*/ , MOD(나머지- 표준은 아님(오라클에서만 제공))
-- 비교연산자 : >,<,<=,>=
-- 등가비교연산자 : =,!=, <>, ^= 뒤에 3개는 같은 의미(A값과 B값이 같을경우 TRUE 다를경우 FALSE)
-- 논리부정연산자 : NOT
-- IN 연산자
-- BETWEEN A AND B 연산자
-- LIKE연산자와 와일드카드(_,%)
-- IS NULL 연산자
-- 집행연산자 : UNION(합집합-중복제거), UNION ALL(합집합-중복포함) , MINUS(차집합), INTERSECT(교집합)
-- 연산자 우선순위
-- 1)산술연산자 *,/
-- 2)산술연산자 +,-
-- 3)비교연산자
-- 4)IS NULL, IS NOT NULLN LIKE,IN
-- 5)BETWEEN A AND B
-- 6) NOT
-- 7) AND
-- 8) OR
-- 우선순위를 줘야 한다면 소괄호 사용
--EMP 테이블에서 급여 열에 12를 곱한 값이 36000인 행 조회

SELECT
    *
FROM
    emp
WHERE
    sal * 12 = 36000;


--ENAME 이 F 이후의 문자로 시작하는 사원 조회

SELECT
    *
FROM
    emp
WHERE
    ename >= 'F';

--문자 표현시 ' '만 사용

--JOB이 MANEGER, SALESMAN,CLERK 사원 조회

SELECT
    *
FROM
    emp
WHERE
    job = 'MANAGER'
    OR job = 'SALESMAN'
    OR job = 'CLERK';

--SAL 이 3000이 아닌 사원만 조회

SELECT
    *
FROM
    emp
WHERE
    sal != 3000;

--IN

SELECT
    *
FROM
    emp
WHERE
    job IN ( 'MANAGER', 'SALESMAN', 'CLERK' );

SELECT
    *
FROM
    emp
WHERE
        job != 'MANAGER'
    AND job <> 'SALESMAN'
    AND job^= 'CLERK';

SELECT
    *
FROM
    emp
WHERE
    job NOT IN ( 'MANAGER', 'SALESMAN', 'CLERK' );

--부서번호가 10,20인 사원조회(IN 사용)

SELECT
    *
FROM
    emp
WHERE
    deptno IN ( 10, 20 )
ORDER BY
    sal;

--급여가 2000이상 3000이하인 사원 조회

SELECT
    *
FROM
    emp
WHERE
        sal >= 2000
    AND sal <= 3000;

SELECT
    *
FROM
    emp
WHERE
    sal NOT BETWEEN 2000 AND 3000;

--LIKE 연산자와 와일드카드(_,%)
-- _ : 어떤 값이든 상관없이 한개의 문자 데이터를 의미
--% : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자 데이터를 의미
--사원 이름이 S로 시작하는 사원 정보 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE 'S%';
--사원 이름의 두번째 글자가 L인 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '_L%';
--사원 이름에 AM이 포함된 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE 'AM%';
--사원 이름에 AM이 포함되지 않은 사원만 조회

-- NULL : 데이터 값이 완전히 비어있는 상태              

SELECT
    *
FROM
    emp
WHERE
    comm IS NULL;

SELECT
    *
FROM
    emp
WHERE
    mgr IS NULL;

--집합연산자
--UNION(동일한 결과값인 경우 자동으로 중복 제거),UNION ALL(중복 제거 안함) : 합집합
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION ALL
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;


--MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;


--INTERSECT
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
INTERSECT
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;


--EMP 테이블에서 사원이름이 S로 끝나는 사원 데이터 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%S';
--EMP 테이블에서 30번 부서에서 근무하는 사원 중에서 직책이 SALESMAN 인 사원의 사원번호,이름,급여 조회(SAL 내림차순)
SELECT
    empno,
    ename,
    sal
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN'
ORDER BY
    sal DESC;
--EMP 테이블을 사용하여 20,30번 부서에 근무하고 있는 사원 중 급여가 2000 초과인 사원 조회
--사원번호,이름,급여,부서번호 조회
--집합 연산자를 사용하는 방식과 사용하지 않는 방식 두 가지를 사용한다
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno IN ( 20, 30 )
    AND sal > 2000;

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    sal > 2000
MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;
--사원 이름에 E가 포함되어 있는 30번 부서 사원 중 급여가 1000~2000 사이가 아닌 사원의 이름
--사원번호, 급여,부서번호를 조회하기
SELECT
    empno,
    sal,
    deptno
FROM
    emp
WHERE
    ename LIKE '%E%'
    AND sal NOT BETWEEN 1000 AND 2000;
--추가 수당이 존재하지 않으며, 상급자가 있고 직책이MANAGER,CLERK인 사원 중에서 사원이름의 두번째 글자가 L이 아닌 사원의 정보 조회
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL
    AND mgr IS NOT NULL
    AND job IN ( 'MANAGER', 'CLERK' )
    AND ename NOT LIKE '_L%';
            

-- 오라클 함수
-- 오라클 기본으로 제공하는 내장 함수와 사용자가 필요에 의해 직접 정의한 사용자 정의 함수

--1. UPPER : 모두 대문자,LOWER: 모두 소문자, INTICAP : 첫 글자만 대문자
SELECT
    ename,
    upper(ename),
    lower(ename),
    initcap(ename)
FROM
    emp;

SELECT
    *
FROM
    emp
WHERE
    upper(ename) = 'FORD';

SELECT
    *
FROM
    emp
WHERE
    upper(ename) LIKE upper('%ford%');

--2) length : 문자열 길이
-- DUAL : SYS가 소유하는 테이블(임시 연산이나 함수의 결과 값 확인하는 용도)
-- LENGTH,LENGTH(문자가 사용하는 바이트 수)
-- 영어 : 문자1 => 1BYTE, 한글 : 문자1=> 3BYTE

--SUBSTR(문자열데이터,시작위치,추출길이) : 추출길이 생략가능
-- 문자열 일부 추출
--INSTR : 문자열 데이터 안에서 특정 문자 위치 찾기
--INSTR(대상문자열,위치를 찾으려는 문자열,대상문자열에서 찾기를 시작할 위치(선택), 시작위치에서 찾으려는 문자가 몇번재인지 지정(선택))

--HELLO, ORACLE : 문자열에서 L 문자열 찾기
SELECT
    instr('HELLO, ORACLE', 'L')       AS instr_1,
    instr('HELLO, ORACLE', 'L',5)     AS instr_2,
    instr('HELLO, ORACLE', 'L', 2, 2) AS instr_3
FROM
    dual;

SELECT
    job,
    substr(job, 1, 2),
    substr(job, 2, 3),
    substr(job, 5),
    substr(job, - 3)
FROM
    emp;

SELECT
    ename,
    length(ename)
FROM
    emp
WHERE
    length(ename) >= 5;

SELECT
    length('한글')
FROM
    dual;

SELECT
    length('한글'),
    lengthb('한글')
FROM
    dual;

SELECT
    length('한글'),
    lengthb('한글'),
    lengthb('ABCDEFGI')
FROM
    dual;

--ENAME, 3번째 글자부터 출려

SELECT
    ename,
    substr(ename, 3)
FROM
    emp;
    
    
--4)REPLACE : 특정 문자를 다른 문자로 변경
--PEPLACE(문자열데이터,찾는문자,변경문자)
SELECT '010-1234-5678' AS 변경전,REPLACE('010-1234-5678','-',' ')AS REPLACE_1, REPLACE('010-1234-5678','-') AS REPLACE_2
FROM DUAL;

-- '이것이 Oracle 이다', 이것이=> this is로 변경
select '이것이 Oracle 이다' AS 변경전, replACE('이것이 Oracle 이다','이것이','This is') AS replace_1
from dual;

--5) CONCAT : 두 문자열 데이터 합치기
SELECT CONCAT(EMPNO,
                CONCAT(':',ENAME))
FROM EMP;

--|| : 문자열 연결 연산자
SELECT 
    EMPNO || ENAME, EMPNO || ':' || ENAME
FROM DUAL;

-- 6)TRIM,LTRIM,RTRIM : 공백 포함 특정 문자 제거
SELECT 'SA        DS          ',TRIM('SA        DS          ') FROM DUAL;