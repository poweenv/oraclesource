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
    instr('HELLO, ORACLE', 'L', 5)    AS instr_2,
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
SELECT
    '010-1234-5678'                    AS 변경전,
    replace('010-1234-5678', '-', ' ') AS replace_1,
    replace('010-1234-5678', '-')      AS replace_2
FROM
    dual;

-- '이것이 Oracle 이다', 이것이=> this is로 변경
SELECT
    '이것이 Oracle 이다'                            AS 변경전,
    replace('이것이 Oracle 이다', '이것이', 'This is') AS replace_1
FROM
    dual;

--5) CONCAT : 두 문자열 데이터 합치기
SELECT
    concat(empno,
           concat(':', ename))
FROM
    emp;

--|| : 문자열 연결 연산자
SELECT
    empno || ename,
    empno
    || ':'
    || ename
FROM
    dual;

-- 6)TRIM,LTRIM,RTRIM : 공백 포함 특정 문자 제거
SELECT
    'SA        DS          ',
    TRIM('SA        DS          ')
FROM
    dual;

--2. 숫자함수
--1) round,trunc,ceil,floor,mod
--round(숫자,반올림 위치(선택))
SELECT
    round(1234.5678)      AS round,        -- 소수점 첫째자리에서 반올림
    round(1234.5678, 0)   AS round0,       -- 소수점 첫째자리에서 반올림
    round(1234.5678, 1)   AS round1,       -- 소수점 둘째자리에서 반올림
    round(1234.5678, 2)   AS round2,       -- 소수점 세번째자리에서 반올림
    round(1234.5678, - 1) AS round_minus1, -- 자연수 첫째 자리에서 반올림
    round(1234.5678, - 2) AS round_minus2  -- 자연수 둘째 자리에서 반올림
FROM
    dual;
 --trunc : 특정 위치에서 버리는 함수
 --trunc(숫자,버림 위치(선택))
SELECT
    round(1234.5678)      AS trunc,        -- 소수점 첫째자리에서 버림
    round(1234.5678, 0)   AS trunc0,       -- 소수점 첫째자리에서 버림
    round(1234.5678, 1)   AS trunc1,       -- 소수점 둘째자리에서 버림
    round(1234.5678, 2)   AS trunc2,       -- 소수점 세번째자리에서 버림
    round(1234.5678, - 1) AS trunc_minus1, -- 자연수 첫째 자리에서 버림
    round(1234.5678, - 2) AS trunc_minus2  -- 자연수 둘째 자리에서 버림
FROM
    dual;
    
--ceil(숫자), floor(숫자) : 입력된 숫자와 가까운 큰정수,작은 정수
SELECT
    ceil(3.14),
    floor(3.140),
    ceil(- 3.14),
    floor(- 3.14)
FROM
    dual;

SELECT
    mod(15, 6),
    mod(10, 2),
    mod(11, 2)
FROM
    dual;

--날짜 함수
--날짜 데이터+ 숫자 : 날짜 데이터보다 숫자만큼 일수 이후의 날짜
--날짜 데이터 - 날짜 데이터 : 두 날짜 데이터 간의 일수 차이

--날짜 데이터 + 날짜 데이터 : 연산불가

-- 1)sysdate 함수 : 오라클 데이터베이스 서버가 설치된 os의 현재 날짜와 시간을 가져옴
SELECT
    sysdate,
    sysdate - 1 AS yesterday,
    sysdate + 1 AS tomorrow
FROM
    dual;

-- 2)add,months(날짜, 더할 개월수) : 몇 개월 이후 날짜 구하기
SELECT
    sysdate,
    add_months(sysdate, 3)
FROM
    dual;

--입사 50주년이 되는 날짜 구하기
SELECT
    empno,
    ename,
    hiredate,
    add_months(hiredate, 600)
FROM
    emp;

-- 3) months_between(첫번째날짜,두번째 날짜) : 두 날짜 데이터간의 날짜 차이를 개월수로 계산하여 출력
--입사 45년 미만인 사원 데이터 조회
--empno, ename, hiredate

SELECT
    empno,
    ename,
    hiredate
FROM
    emp
WHERE
    months_between(sysdate, hiredate) < 540;

-- 현재 날짜와 6개월 후 날짜가 출력되도록
SELECT
    sysdate,
    add_months(sysdate, 6)
FROM
    emp;

SELECT
    empno,
    ename,
    hiredate,
    sysdate,
    months_between(hiredate, sysdate)        AS months1,
    months_between(sysdate, hiredate)        AS months2,
    trunc(months_between(sysdate, hiredate)) AS months3
FROM
    emp;
    
-- 4)next_day(날짜,요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출력
--   last_day(날짜) : 특정 날짜가 속한 달의 마지막 날짜를 출력

SELECT
    sysdate,
    next_day(sysdate, '금요일'),
    last_day(sysdate)
FROM
    dual;

--날짜의 반올림, 버림 : round,trunc
-- CC : 네 자리 연도의 끝 두자리를 기준으로 사용
--      2023 년인 경우 2050 이하이므로 2001년으로 처리
SELECT
    sysdate,
    round(sysdate, 'CC')   AS format_cc,
    round(sysdate, 'yyyy') AS format_yyyy,
    round(sysdate, 'DDD')  AS format_ddd,
    round(sysdate, 'HH')   AS format_hh
FROM
    dual;
    
    
    
    
    
    
-- 형변환 함수 : 자료형을 형 변환
-- number,varchar2,date
-- TO_CHAR(): 숫자 또는 날짜 데이터를 문자 데이터로 변환
-- TO_NUMBER() : 문자 데이터를 숫자 데이터로 변환
-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환
SELECT
    empno,
    ename,
    empno + '500'
FROM
    emp
WHERE
    ename = 'FORD';

SELECT
    empno,
    ename,
    'abcd' + empno
FROM
    emp
WHERE
    ename = 'FORD';

SELECT
    sysdate,
    to_char(sysdate, 'YYYY/MM/DD HH:MI:SS') AS 현재날짜시간,
    to_char(sysdate, 'YYYY/MM/DD')          AS 현재날짜,
    to_char(sysdate, 'MM')                  AS 현재월1,
    to_char(sysdate, 'MOM')                 AS 현재월2,
    to_char(sysdate, 'DDD')                 AS 현재월3,
    to_char(sysdate, 'DD')                  AS 현재월
FROM
    dual;

-- MOM, MONTH : 월 이름
-- DDD, : 365일 중에 며칠

SELECT
    1300 - '1500',
    '1300' + 1500
FROM
    dual;

SELECT
    TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
FROM
    dual;

-- SAL 필드에 콤마나 통화표시($ 등)를 하고 싶다면?
-- L (locale) 지역 화폐단위 기호 붙여줌
SELECT
    sal,
    to_char(sal, '$999,999') AS sal_$,
    to_char(sal, 'L999,999') AS sal_l
FROM
    emp;

--to, date(문자열데이터, '인식될 날짜 형태')
SELECT
    TO_DATE('2018-07-14', 'YYYY-MM-DD') AS todate1,
    TO_DATE('20230320', 'YYYY-MM-DD')   AS todate2
FROM
    emp;

SELECT
    TO_DATE('2023-03-21') - TO_DATE('2023-02-01')
FROM
    emp;

-- null처리 함수
-- null + 300=> null

--NVL(데이터, null 일 경우 반환할 데이터)
SELECT
    empno,
    ename,
    sal,
    comm,
    sal + comm,
    nvl(comm, 0),
    sal + nvl(comm, 0)
FROM
    emp;

--nvl2(데이터,널이 아닐경우 반환할 데이터, 널일 경우 반환할 데이터)
SELECT
    empno,
    ename,
    comm,
    nvl2(comm, '0', 'x'),
    nvl2(comm, sal * 12 + comm, sal * 12) AS annsal
FROM
    emp;
    
--decode함수 / case문
    
--decode(검사 대상이 될 데이터,
--      조건1. 조건1이 일치할때 실행할 구문
--      조건2. 조건2이 일치할때 실행할 구문)

--emp 테이블에 직책이 manager인 사람은 급여의 10%인상,
-- salesman 인 사람은 5%,analyst 인 사람은 그대로, 나머지는 3%인상된 급여 출력

SELECT
    empno,
    ename,
    job,
    sal,
    decode(job, 'MANAGER', sal * 1.1, 'SALESMAN', sal * 1.05,
           'ANALYST', sal, sal * 1.03) AS upsal
FROM
    emp;

SELECT
    empno,
    ename,
    job,
    sal,
    CASE job
        WHEN 'MANAGER'  THEN
            sal * 1.1
        WHEN 'SALESMAN' THEN
            sal * 1.05
        WHEN 'ANALYST'  THEN
            sal
        ELSE
            sal * 1.03
    END AS upsal
FROM
    emp;

SELECT
    empno,
    ename,
    job,
    sal,
    CASE
        WHEN comm IS NULL THEN
            '해당사항 없음'
        WHEN comm = 0 THEN
            '수당없음'
        WHEN comm > 0 THEN
            '수당 : ' || comm
    END AS comm_text
FROM
    emp;

SELECT
    empno,
    ename,
    sal,
    trunc(sal / 21.5, 2)     AS day_pay,
    round(sal / 21.5 / 8, 1) AS time_pay
FROM
    emp;

SELECT
    comm,
    nvl(to_char(comm),
        'N/A')
FROM
    emp;

SELECT
    empno,
    ename,
    hiredate,
    next_day(add_months(hiredate, 3),
             '월요일') AS r_job,
    nvl(to_char(comm),
        'N/A')      AS comm
FROM
    emp;

SELECT
    empno,
    ename,
    mgr,
    decode(substr(to_char(mgr),
                  1,
                  2),
           NULL,
           '0000',
           '75',
           '5555',
           '76',
           '6666',
           '77',
           '7777',
           '78',
           '8888',
           substr(to_char(mgr),
                  1)) AS chg_mgr
FROM
    emp;

SELECT
    empno,
    ename,
    mgr,
    CASE
        WHEN mgr IS NULL THEN
            '0000'
        WHEN substr(to_char(mgr),
                    1,
                    2) = '75' THEN
            '5555'
        WHEN substr(to_char(mgr),
                    1,
                    2) = '76' THEN
            '6666'
        WHEN substr(to_char(mgr),
                    1,
                    2) = '77' THEN
            '7777'
        WHEN substr(to_char(mgr),
                    1,
                    2) = '78' THEN
            '8888'
        ELSE
            to_char(mgr)
    END AS chg_mgr
FROM
    emp;
    
--다중행 함수 : sum,count,average,max,min,
-- sum() : null값을 제외하고 합계 구해줌
SELECT
    ename,
    SUM(sal)
FROM
    emp;

SELECT
    SUM(sal)
FROM
    emp;

SELECT
    SUM(DISTINCT sal),
    SUM(ALL sal),
    SUM(sal)
FROM
    emp;

SELECT
    SUM(comm)
FROM
    emp;

SELECT
    COUNT(sal)
FROM
    emp;

SELECT
    MAX(sal)
FROM
    emp;

SELECT
    COUNT(comm)
FROM
    emp;

SELECT
    COUNT(*)
FROM
    emp;

SELECT
    COUNT(*)
FROM
    emp
WHERE
    deptno = 30;

SELECT
    MAX(sal)
FROM
    emp
WHERE
    deptno = 30;

SELECT
    MAX(hiredate)
FROM
    emp;

SELECT
    MIN(hiredate)
FROM
    emp;

SELECT
    AVG(sal)
FROM
    emp;

SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 30;

-- group by : 결과 값을 원하는 열로 묽어 출력
-- 부서별 sal 평균 guhagi
SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 20;

SELECT
    AVG(sal),
    deptno
FROM
    emp
GROUP BY
    deptno;
    
-- group by+ having : group by 절애 조건을 줄때
-- having : 그룹화된 대상을 출력 제한 걸때
--각 부서의 직책별 평균 급여 구하기(단, 평균 급여가 2000이상인 그룹만 출력)
-- dempno,job, 평균

SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;

-- 1)from 구문 실행  2)where 실행 3) group by 4) having 5)select
SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
WHERE
    sal <= 3000
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;

SELECT
    deptno,
    floor(AVG(sal)) AS avg_sal,
    MAX(sal)        AS max_sal,
    MIN(sal)        AS min_sal,
    COUNT(deptno)
FROM
    emp
GROUP BY
    deptno
ORDER BY
    avg_sal;

SELECT
    job,
    COUNT(*)
FROM
    emp
GROUP BY
    job
HAVING
    COUNT(job) >= 3;

SELECT
    to_char(hiredate, 'YYYY') AS hire_year,
    deptno,
    COUNT(*)                  AS cnt
FROM
    emp
GROUP BY
    to_char(hiredate, 'YYYY'),
    deptno;

-- 조인 : 여러테이블을 하나의 테이블처럼 사용
-- 1) 내부조인(inner join) : 여러개의 테이블에서 공통된 부분만 추출
--  1.등가조인 : 두 개의 열이 일치할 때 값 추출
--  2.비등가조인 : 범위에 해당할 때 값 추출
-- 2) 외부조인(outer join) 
--  1.left outer join
--  2.right outer join
--  3.full outer join

--dept : 4행, emp : 12행 => 4*12=48행
--크로스조인(나올 수 있는 모든 조합 추출)
SELECT
    *
FROM
    emp,
    dept
ORDER BY
    empno;

--ORA-00918: 열의 정의가 애매합니다 ->> 중복됬을때 나오는 메세지
--inner join- 테이블에 별칭을 붙인다(ex->e,d)
SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND sal >= 3000;

--sql-99 표준
--join ~ on
SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno;

SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
                   AND sal >= 3000;

SELECT
    e.empno,
    e.ename,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
                   AND e.sal <= 2500
                   AND e.empno <= 9999;

SELECT
    *
FROM
         emp e
    JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

--급여가 2500 이하이고, 사원번호가 9999 이하인 사원정보 조회
SELECT
    e.empno,
    e.ename,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.sal <= 2500
    AND e.empno <= 9999;

--emp와 salgrade 조인
-- emp 테이블의 sal 이 salgrade 테이블의 losal 과 hisal 범위에 들어가는 형태로 조인
SELECT
    *
FROM
    emp      e,
    salgrade s
WHERE
    e.sal BETWEEN s.losal AND s.hisal;

--self join : 자기 자신 테이블과 조인

SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr = e2.empno;

--outer join
--left outer join
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr = e2.empno (+);
 --join ~ on
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1
    LEFT OUTER JOIN emp e2 ON e1.mgr = e2.empno;


--right outer join
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr (+) = e2.empno;

 --join ~ on
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1
    RIGHT OUTER JOIN emp e2 ON e1.mgr = e2.empno;

--full outer join

SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1
    FULL OUTER JOIN emp e2 ON e1.mgr = e2.empno;
    
--select*
--from table1 t1, table2 t2, table t3
--where t1.empno= t2.empno and t2.empno=t3.empno;

--select* 
--from table1 t1 join table2 t2 on t1.empno = t2.empno join table3 on t2.deptno

SELECT
    d.deptno,
    d.dname,
    e.empno,
    e.ename,
    e.sal
FROM
         dept d
    JOIN emp e ON d.deptno = e.deptno
                  AND e.sal > 2000;

SELECT
    d.deptno,
    d.dname,
    empno,
    e.ename,
    e.sal
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.sal > 2000;

SELECT
    d.deptno,
    d.dname,
    floor(AVG(sal)) AS avg_sal,
    MAX(e.sal)      AS max_sal,
    MIN(e.sal)      AS min_sal,
    COUNT(e.sal)    AS cnt
FROM
         dept d
    JOIN emp e ON d.deptno = e.deptno
GROUP BY
    d.deptno,
    d.dname;

SELECT
    d.deptno,
    d.dname,
    floor(AVG(sal)) AS avg_sal,
    MAX(e.sal)      AS max_sal,
    MIN(e.sal)      AS min_sal,
    COUNT(e.sal)    AS cnt
FROM
    emp  e,
    dept d
WHERE
    e.deptno = d.deptno
GROUP BY
    d.deptno,
    d.dname;

SELECT
    d.deptno,
    d.dname,
    e.empno,
    e.ename,
    e.job,
    e.sal
FROM
    dept d
    LEFT OUTER JOIN emp  e ON d.deptno = e.deptno
ORDER BY
    d.deptno,
    d.dname;

SELECT
    d.deptno,
    d.dname,
    e.empno,
    e.ename,
    e.job,
    e.sal
FROM
    dept d,
    emp  e
WHERE
    d.deptno = e.deptno
ORDER BY
    d.deptno,
    d.dname;
    
-- 서브쿼리
-- sql 문을 실행하는 데 필요한 데이터를 추가로 조회하기 위해 sql 문 내부에서 사용하는 select
-- 1)단일행 서브쿼리 2) 다행 서브쿼리
--select 조회할 열
--from 테이블명
--where 조건식(select 조회할 열 from 테이블 where 조건식)

--존스의 급여보다 높은 급여를 받는 사원 조회
-- jones 급여 알아내기 / 알아낸 jones 급여를 가지고 조건식

SELECT
    sal
FROM
    emp
WHERE
    ename = 'JONES';

SELECT
    *
FROM
    emp
WHERE
    sal > 2975;
-- 단일행 서브쿼리
-- =,<,>,<=,>=,<>,!= 연산자 사용가능
SELECT
    *
FROM
    emp
WHERE
    sal > (
        SELECT
            sal
        FROM
            emp
        WHERE
            ename = 'JONES'
    );
    
--사원이름이 ALLEN 인 사람의 추가수당보다 많은 추가수당을 받는 사원 조회
SELECT
    *
FROM
    emp
WHERE
    comm > (
        SELECT
            comm
        FROM
            emp
        WHERE
            ename = 'ALLEN'
    );

--사원이름이 WARD 인 사원의 입사일보다 빨리 입사한 사원 조회
SELECT
    *
FROM
    emp
WHERE
    hiredate < (
        SELECT
            hiredate
        FROM
            emp
        WHERE
            ename = 'WARD'
    );

--20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원 정보 및 
-- 부서정보 조회
-- 사원번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
SELECT
    e.empno,
    e.ename,
    e.job,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
        e.deptno = 20
    AND e.sal > (
        SELECT
            AVG(sal)
        FROM
            emp
    );

--20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 작거나 같은 급여를 받는 사원정보 및 부서정보 조회
SELECT
    e.empno,
    e.ename,
    e.job,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
        e.deptno = 20
    AND e.sal <= (
        SELECT
            AVG(sal)
        FROM
            emp
    );

-- 다중행 서브쿼리 : 서브쿼리 결과로 여러개의 행 반환
-- in ,any(some), all,exists 연산자 허용 (단일행 서브쿼리에 쓰는 연산자 사용 불가)
-- any(some) : 메인쿼리 결과가 서브쿼리 결과 중 하나 이상이면  true
--각 부서별 최고 급여와 동일한 급여를 받는 사원정보 조회
SELECT
    deptno,
    MAX(sal)
FROM
    emp
GROUP BY
    deptno;
-- in() : main query 결과가 sub query 결과중 하나라도 일치하면 true
SELECT
    *
FROM
    emp
WHERE
    sal IN (
        SELECT
            MAX(sal)
        FROM
            emp
        GROUP BY
            deptno
    );

-- 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보 조회
SELECT
    *
FROM
    emp
WHERE
    sal < ANY (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

SELECT
    *
FROM
    emp
WHERE
    sal < SOME (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );
--위 결과는 단일행 쿼리로 작성이 가능한 상황임
SELECT
    *
FROM
    emp
WHERE
    sal < SOME (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE
            deptno = 30
    );

-- 30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원 정보 조회
--1.단일행 서브쿼리
SELECT
    *
FROM
    emp
WHERE
    sal > (
        SELECT
            MIN(sal)
        FROM
            emp
        WHERE
            deptno = 30
    );
--2. 다중행 서브쿼리
SELECT
    *
FROM
    emp
WHERE
    sal > ANY (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

--all : 서브쿼리 모든 결과가 조건식에 맍아 떨어져야만 메인쿼리 조건식이 true
SELECT
    *
FROM
    emp
WHERE
    sal < ALL (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

-- exists : 서브 쿼리에 결과 값이 하나 이상 존재하면 조건식이 모두 true, 존재하지 않으면false
SELECT
    *
FROM
    emp
WHERE
    EXISTS (
        SELECT
            dname
        FROM
            dept
        WHERE
            deptno = 10
    );

SELECT
    *
FROM
    emp
WHERE
    EXISTS (
        SELECT
            dname
        FROM
            dept
        WHERE
            deptno = 50
    );
--전체 사원중 ALLEN과 같은 직책인 사원들의 사원정보, 부서 정보를 다음과 같이 출력
SELECT
    e.job,
    e.empno,
    e.ename,
    e.sal,
    d.deptno,
    d.dname
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
    e.job = (
        SELECT
            job
        FROM
            emp
        WHERE
            ename = 'ALLEN'
    );

--전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 사원정보, 부서정보,
--급여 등급 정보를 출력하는 sql문을 작성하시오(단, 출력할 때 급여가
--많은 순으로 정렬하되 급여가 같을 경우에는 사원 번호를 기준으로 오름차순으로 정렬하기)
SELECT
    empno,
    ename,
    dname,
    hiredate,
    loc,
    sal,
    grade
FROM
    emp      e,
    dept     d,
    salgrade s
WHERE
        e.deptno = d.deptno
    AND e.sal BETWEEN s.losal AND s.hisal
    AND e.sal > (
        SELECT
            AVG(sal)
        FROM
            emp
    )
ORDER BY
    e.sal DESC,
    e.empno ASC;

--다중열 서브쿼리 : 서브쿼리의 select 절에 비교할 데이터를 여러개 지정
SELECT
    *
FROM
    emp
WHERE
    ( deptno, sal ) IN (
        SELECT
            deptno, MAX(sal)
        FROM
            emp
        GROUP BY
            deptno
    );
    
--from 절에 사용하는 서브쿼리 (인라인 뷰)
--from 절에 직접 테이블을 명시해서 사용하기에는 테이블 내 데이터 규모가 클때, 불필요한 열이 많을 때
SELECT
    e10.empno,
    e10.ename,
    e10.deptno,
    d.dname,
    d.loc
FROM
    (
        SELECT
            *
        FROM
            emp
        WHERE
            deptno = 10
    ) e10,
    (
        SELECT
            *
        FROM
            dept
    ) d
WHERE
    e10.deptno = d.deptno;

--select 절에 사용하는 서브쿼리(스칼라 서브쿼리)
--select 절에 사용하는 서브쿼리는 반드시 하나의 결과만 반환해야 함
SELECT
    empno,
    ename,
    job,
    sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            e.sal BETWEEN losal AND hisal
    ) AS salgrade,
    deptno,
    (
        SELECT
            dname
        FROM
            dept
        WHERE
            e.deptno = dept.deptno
    ) AS dname
FROM
    emp e;
    
--10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원정보, 부서 정보를
--다음과 같이 출력하는 sql문을 작성히
SELECT
    e.empno,
    e.ename,
    e.job,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.job NOT IN (
        SELECT
            job
        FROM
            emp
        WHERE
            deptno = 30
    )
    AND e.deptno = 10;

--직책이 salesman인 사람들의 최고 급여보다 급여를 받는 사원들의 사원정보, 급여등급 정보를 출력하는 sql문을 작성하시오
SELECT
    e.empno,
    e.ename,
    e.sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            e.sal BETWEEN losal AND hisal
    ) AS grade
FROM
    emp e
WHERE
    e.sal > ALL (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE
            job = 'SALESMAN'
    )
ORDER BY
    e.empno;
    
--DML(Data Manipulation Language) : 데이터 추가(INSERT),수정(UPDATE),삭제(DELETE)하는 데이터 조작어
--COMMIT : DML 작업을 데이터베이스에 최종 반영
--ROLLBACK : DML 작업 취소
-- select + DML ==> 자주 사용하는 sql 임

-- 연습용 테이블 생성
-- 기존 테이블 복사
CREATE TABLE dept_temp
    AS
        SELECT
            *
        FROM
            dept;

--열이름은 선택사항임
--insert into 테이블이름(열이름1,열이름2....);
--values(데이터1,데이터2,.....);

--dept_temp에 새로운 부서 추가
INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    50,
    'DATABASE',
    'SEOUL'
);

INSERT INTO dept_temp VALUES (
    60,
    'NETWORK',
    'BUSAN'
);


--INSERT 시 오류
--EX)이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
INSERT INTO dept_temp VALUES (
    600,
    'NETWORK',
    'BUSAN'
);

--EX)수치가 부적합합니다
INSERT INTO dept_temp VALUES (
    'DADA',
    'NETWORK',
    'BUSAN'
);

--값의 수가 충분하지 않습니다
INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    70,
    'DATABASE'
);

INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    80,
    'WEB',
    NULL
);

INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    90,
    'MOBLIE',
    ''
);

--NULL 삽입할 컬럼명 지정하지 않음
-- 삽입시 전체 컬럼을 삽입하지 않는다면 필드명 필수
INSERT INTO dept_temp (
    deptno,
    loc
) VALUES (
    91,
    'INCHON'
);

--emp_temp 생성(emp 테이블 복사 - 데이터는 복사를 하지 않을 때)
CREATE TABLE emp_temp
    AS
        SELECT
            *
        FROM
            emp
        WHERE
            1 <> 1;

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    9999,
    '홍길동',
    'president',
    NULL,
    '2001/01/01',
    5000,
    1000,
    10
);

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    1111,
    '성춘향',
    'manager',
    9999,
    '2002-01-05',
    4000,
    NULL,
    20
);

--날짜 형식의 지정에 불필요한 데이터가 포함되어 있습니다
INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    2222,
    '이순신',
    'president',
    NULL,
    '07/01/2001',
    5000,
    1000,
    10
);

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    2222,
    '이순신',
    'manager',
    NULL,
    TO_DATE('07/01/2001', 'DD/MM/YYYY'),
    4000,
    NULL,
    20
);

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    3333,
    '심봉사',
    'manager',
    9999,
    sysdate,
    4000,
    NULL,
    30
);

--서브쿼리로 insert 구현
--emp,salgrade 테이블을 조인해서 급여 등급이 1인 사원만 emp_temp 에 추가

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
)
    SELECT
        e.empno,
        e.ename,
        e.job,
        e.mgr,
        e.hiredate,
        e.sal,
        e.comm,
        e.deptno
    FROM
        emp      e,
        salgrade s
    WHERE
        e.sal BETWEEN s.losal AND s.hisal
        AND s.grade = 1;

SELECT
    *
FROM
    emp_temp;



-- UPDATE : 테이블에 있는 데이터 수정
--UPDATE 테이블명
--SET 변경할열이름 = 데이터,변경할열이름=데이터....
--WHERE 변경을 위한 대상 행을 선별하기 위한 조건



--dept_temp 열의 모든 값을 seoul 로 변경
UPDATE dept_temp
SET
    loc = 'SEOUL';

--데이터 일부분 수정: where 사용
--dept_temp 부서번호가 40번인 loc 열의 모든 값을 seoul 로 변경
UPDATE dept_temp
SET
    loc = 'SEOUL'
WHERE
    deptno = 40;

--부서번호가 80번인 dname 은 SALES, LOC 는 CHICAGO
UPDATE dept_temp
SET
    dname = 'SALES',
    loc = 'CHICAGO'
WHERE
    deptno = 80;

SELECT
    *
FROM
    dept_temp;

-- emp_temp 사원들 중에서 급여가 2500이하인 사원만 추가 수당을 50으로 수정
UPDATE emp_temp
SET
    comm = 50
WHERE
    sal < 2500;

--서브쿼리를 사용하여 데이터 수정
--dept 테이블의 40번 부서의 dname, loc를 dept_temp 40번 부서의 dname,loc로 업데이트
UPDATE dept_temp
SET
    ( dname,
      loc ) = (
        SELECT
            dname,
            loc
        FROM
            dept
        WHERE
            deptno = 40
    )
WHERE
    deptno = 40;

COMMIT;

--delete : 테이블에 있는 데이터 삭제

--delete 테이블명
--from (선택)
--where 삭제 데이터를 선별하기 위한 조건식


CREATE TABLE emp_temp2
    AS
        SELECT
            *
        FROM
            emp;

--job이 manager 인 사원 삭제
DELETE FROM emp_temp2
WHERE
    job = 'MANAGER';

--job이 salesman 인 사원 삭제
DELETE emp_temp2
WHERE
    job = 'SALESMAN';

--job이 manager 인 사원 삭제
DELETE FROM emp_temp2;

ROLLBACK;

-- 서브쿼리를 사용하여 삭제
-- 급여 등급이 3등급이고, 30번부서의 사원 삭제

DELETE FROM emp_temp2
WHERE
    empno IN (
        SELECT
            e.empno
        FROM
            emp_temp2 e, salgrade  s
        WHERE
            e.sal BETWEEN s.losal AND s.hisal
            AND s.grade = 30
            AND e.deptno = 30
    );

CREATE TABLE exam_dept
    AS
        SELECT
            *
        FROM
            dept;

CREATE TABLE exam_emp
    AS
        SELECT
            *
        FROM
            emp;

CREATE TABLE exam_salgrade
    AS
        SELECT
            *
        FROM
            salgrade;

INSERT INTO exam_emp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    7201,
    'TEST_USER1',
    'MANAGER',
    7788,
    '2016-01-02',
    4500,
    NULL,
    50
);

INSERT INTO exam_emp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    7202,
    'TEST_USER2',
    'CLERK',
    7201,
    '2016-02-21',
    1800,
    NULL,
    50
);

INSERT INTO exam_emp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    7203,
    'TEST_USER3',
    'ANALYST',
    7201,
    '2016-04-11',
    3400,
    NULL,
    60
);

INSERT INTO exam_emp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    7204,
    'TEST_USER4',
    'SALESMAN',
    7201,
    '2016-05-31',
    2700,
    300,
    60
);

INSERT INTO exam_emp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    7205,
    'TEST_USER5',
    'CLERK',
    7201,
    '2016-07-20',
    2600,
    NULL,
    70
);

INSERT INTO exam_emp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    7206,
    'TEST_USER6',
    'CLERK',
    7201,
    '2016-09-08',
    2600,
    NULL,
    70
);

INSERT INTO exam_emp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    7207,
    'TEST_USER7',
    'LECTURER',
    7201,
    '2016-10-28',
    2300,
    NULL,
    80
);

INSERT INTO exam_emp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    7208,
    'TEST_USER8',
    'STUDENT',
    7201,
    '2018-03-09',
    1200,
    NULL,
    80
);

--[실습3] EXAM_EMP에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다 
--많은 급여를 받고 있는 사원들을 70번 부서로 옮기는 SQL 문 작성하기
UPDATE exam_emp
SET
    deptno = 70
WHERE
    sal > (
        SELECT
            AVG(sal)
        FROM
            exam_emp
        WHERE
            deptno = 50
    );

--[실습4] EXAM_EMP에 속한 60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다 
--늦게 입사한 사원의 급여를 10% 인상하고 80번 부서로 옮기는 SQL 문 작성하기
UPDATE exam_emp
SET
    sal = sal * 1.1,
    deptno = 80
WHERE
    hiredate > (
        SELECT
            MIN(hiredate)
        FROM
            exam_emp
        WHERE
            deptno = 60
    );

--[실습5] EXAM_EMP에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL문을 작성하기
DELETE FROM exam_emp
WHERE
    empno IN (
        SELECT
            e.empno
        FROM
                 exam_emp e
            JOIN exam_salgrade s ON e.sal BETWEEN s.losal AND s.hisal
                                    AND s.grade = 5
    );

DELETE FROM exam_emp
WHERE
    empno IN (
        SELECT
            empno
        FROM
            exam_emp, salgrade
        WHERE
            sal BETWEEN losal AND hisal
            AND grade = 5
    );

SELECT
    *
FROM
    emp_temp2;

--트랜잭션(transaction) : 최소 수행 단위, 여러개의 작업 수행
--트랜잭션 제어하는 구문 TCL(Transaction Control language) : commit,rollback

CREATE TABLE dept_tcl
    AS
        SELECT
            *
        FROM
            dept;

INSERT INTO dept_tcl VALUES (
    50,
    'DATABASE',
    'SEOUL'
);

UPDATE dept_tcl
SET
    loc = 'BOSAN'
WHERE
    deptno = 40;

DELETE FROM dept_tcl
WHERE
    dname = 'RESEARCH';

SELECT
    *
FROM
    dept_tcl;

--트랜잭션 취소
ROLLBACK;

--트랜잭션 최종 반영
COMMIT;

-- 세션 : 어떤 활동을 위한 시간이나 기간
-- 데이터베이스 세션 : 데이터베이스 접속을 시작으로 관련작업 수행한 후 접속 종료
--LOCK : 잠금(수정 중인 데이터 접근 막기)
DELETE FROM dept_tcl
WHERE
    deptno = 50;

UPDATE dept_tcl
SET
    loc = 'SEOUL'
WHERE
    deptno = 30;

SELECT
    *
FROM
    dept_temp;

-- DML : 데이터 정의어(데이터 베이스 객체 생성, 수정, 삭제)
-- 1. 테이블 생성
--  create table 테이블명(
--    열이름1, 자료형,
--    열이름2, 자료형,
--    열이름3, 자료형,
--    열이름4, 자료형
--);
-- 테이블 생성 /열이름 지정 규칙
-- 1) 테이블 이름은 문자로 시작
-- 2) 테이블 이름은 30BYTE 이하
-- 3) 같은 사용자 소유의 테이블 이름은 중복될 수 없다
-- 4) 테이블 명에 사용할 수 있는 특수문자 : $,#,_ 가능
-- 5) SQL 키워드(ex. SELECT, FROM, WHERE.....) 테이블명에 사용할 수 없음

--자료형
-- 1.
-- VARCHAR2(길이) : 가변 길이 문자열 데이터 저장(최대 4000BYTE)
-- CHAR(길이) : 고정 길이 문자열 데이터 저장
-- NVARCHAR2(길이) : 가변 길이(unicode) 데이터 저장
--    name varchar2(10) : 영어는 10자, 한글은 3자까지 입력
--    name nvarchar2(10) : 영어 10자, 한글 10자까지 입력
-- NCHAR(길이) : 고정 길이(unicode)
--   name char(10) : 영어는 10자, 한글은 3자, + 메모리 10byte 고정 
--   name nchar(10) : 영어는 10자, 한글은 10자, + 메모리 10byte 고정


-- 2. 숫자
-- NUMBER(전체자리수,소수점이하자릿수) 

-- 3. 날짜
-- DATE : 날짜,시간 저장
-- TIMESTAMP

-- 4. 기타
-- BLOB : 대용량 이진 데이터 저장
-- CLOB : 대용량 텍스트 데이터 저장
-- JSON : JSON 데이터 저장

CREATE TABLE emp_ddl (
    empno    NUMBER(4),    -- 사번을 총 4자리 지정
    ename    VARCHAR2(10), -- 사원명을 총 10byte로 지정 
    job      VARCHAR2(9),    -- 직무 총 9 byte 지정
    mgr      NUMBER(4),      -- 매니저 번호
    hiredate DATE,      -- 날짜/시간 저장
    sal      NUMBER(7, 2),    -- 급여를 전체 자릿수 7자리 지정(소수점 2자리까지 허용)
    comm     NUMBER(7, 2),   -- 추가수당   
    deptno   NUMBER(2)    -- 부서번호
);

desc emp_ddl;


-- 2. 테이블 수정 : ALTER
-- 1) 열 추가
ALTER TABLE emp_temp2 ADD hp VARCHAR2(20);

-- 2) 열 이름 변경 : RENAME 
ALTER TABLE emp_temp2 RENAME COLUMN hp TO tel;

-- 3) 열 자료형 변경 : MODIFY
ALTER TABLE emp_temp2 MODIFY
    empno NUMBER(5);

-- 4) 특정 열 삭제 : DROP
ALTER TABLE emp_temp2 DROP COLUMN tel;


-- 3. 테이블 삭제 : drop
DROP TABLE emp_rename;
--  데이블 명 변경
RENAME emp_temp2 TO emp_rename;

--테이블 데이터 전체 삭제
DELETE FROM emp_rename;

SELECT
    *
FROM
    emp_rename;

ROLLBACK;

--rollback 안됨 : DDL 구문이기 때문
TRUNCATE TABLE emp_rename;

CREATE TABLE emp_member (
    id     CHAR(8),
    name   VARCHAR2(10),
    addr   VARCHAR2(50),
    nation CHAR(4),
    email  VARCHAR2(50),
    age    NUMBER(7, 2)
);

ALTER TABLE emp_member ADD bigo VARCHAR2(20);

ALTER TABLE emp_member MODIFY
    bigo VARCHAR2(30);

ALTER TABLE emp_member RENAME COLUMN bigo TO remark;

RENAME emp_member TO member;

DROP TABLE member;

CREATE TABLE emp_member (
    id     CHAR(8),
    name   VARCHAR2(10),
    addr   VARCHAR2(50),
    nation NCHAR(4),
    email  VARCHAR2(50),
    age    NUMBER(7, 2)
);

INSERT INTO member VALUES (
    'hong1234',
    '홍길동',
    '서울시 종로구',
    '대한민국',
    'hong1234@naver.com',
    25,
    NULL
);

-- 데이터 베이스 객체
-- 테이블, 인덱스, 뷰, 데이터 사전, 시퀀스, 시노님, 프로시저, 함수, 패키지, 트리거
-- 생성 : create, 수정 : alter, 삭제 : drop

-- 인덱스 : 더 빠른 검색을 도와줄 
-- 인덱스 : 사용자가 직접 특정 테이블 열에 지정가능
--         기본키(혹은 (unique key)를 생성하면 인덱스로 지정

-- create index 인덱스 이름 on 테이블명(인덱스로 사용할 열이름)

-- emp 테이블의 sal 열을 인덱스로 지정
CREATE INDEX idx_emp_sal ON
    emp (
        sal
    );

-- select : 검색방식
-- FULL Scan
-- INDEX Scan

SELECT
    *
FROM
    emp;

SELECT
    *
FROM
    emp
WHERE
    empno = 7900;

--인덱스 삭제
DROP INDEX idx_emp_sal;

-- VIEW : 가상 테이블
-- 편리성 : SELECT 문의 복잡도를 완화하기 위해
-- 보완성: 테이블의 특정 열을 노출하고 싶지 않을 때

-- create[OR REPLACE] [FORCE : NOFORCE] VIEW 뷰이름(열이름1, 열이름2....)
-- AS (저장할 SELECT 구문)
-- [WITH CHECK OPTION]
-- [WITH READ ONLY]


-- select empno, ename,job, dempno from emp where deptno=20
CREATE VIEW vm_emp20 AS
    (
        SELECT
            empno,
            ename,
            job,
            deptno
        FROM
            emp
        WHERE
            deptno = 20
    );

--뷰 사용
SELECT
    *
FROM
    vm_emp20;

-- 뷰 삭제
DROP VIEW vm_emp20;

-- 서브쿼리를 사용
SELECT
    *
FROM
    (
        SELECT
            empno,
            ename,
            job,
            dempno
        FROM
            emp
        WHERE
            deptno = 20
    );

--뷰 생성시 읽기만 가능
CREATE VIEW vm_emp_read AS
    SELECT
        empno,
        ename,
        job
    FROM
        emp
WITH READ ONLY;

-- VIEW 에 INSERT 작업이 ㄱㄴ한가?
INSERT INTO vm_emp20 VALUES (
    8888,
    'KIM',
    'SALES',
    20
);
-- 원본 변경이 일어남
SELECT
    *
FROM
    emp;
-- 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
INSERT INTO vm_emp_read VALUES (
    9999,
    'JOB',
    'SALES'
);

--인라인 뷰 : 일회성으로 만들어서 사용하는 뷰
--ROWNUM : 조회된 순서대로 일련번호 매김

SELECT
    ROWNUM,
    e.*
FROM
    emp e;

SELECT
    ROWNUM,
    e.*
FROM
    (
        SELECT
            *
        FROM
            emp e
        ORDER BY
            sal DESC
    ) e
WHERE
    ROWNUM <= 3;

--시퀀스 : 규칙에 따라 순번 생서어
--CREATE SSEQUENCE :(설정안하는 것르드리


--CREEATE SEQUENCE 시퀜스명
--[IN BY 숫자 기본값1 강사님거 다시보기

CREATE TABLE dept_sequence
    AS
        SELECT
            *
        FROM
            dept
        WHERE
            1 <> 1;

CREATE SEQUENCE seq_dept_sequence 
INCREMENT BY 10 START WITH 10 MAXVALUE 90 MINVALUE 0 NOCYCLE CACHE 2;

-- 시퀀스 사용 : 시퀀스이름.CURRVAL, 시퀀스이름.NEXTVAL

-- 부서번호 입력시 시퀀스 사용
INSERT INTO dept_sequence (
    deptno,
    dname,
    loc
) VALUES (
    seq_dept_sequence.NEXTVAL,
    'DATABASE',
    'SEOUL'
);

drop sequence seq_dept_sequence;

-- 최대값 90까지 가능 
-- 시퀀스 
CREATE SEQUENCE seq_dept_sequence 
INCREMENT BY 3 START WITH 10 MAXVALUE 99 MINVALUE 0 CYCLE CACHE 2;

-- 시퀀스 사용 : 시퀀스이름.CURRVAL(마지막으로 생성된 시퀀스 조회), 시퀀스이름.NEXTVAL(시퀀스 생성)

-- 부서번호 입력시 시퀀스 사용
INSERT INTO dept_sequence (
    deptno,
    dname,
    loc
) VALUES (
    seq_dept_sequence.NEXTVAL,
    'DATABASE',
    'SEOUL'
);
select* from dept_sequence;

select seq_dept_sequence.CURRVAL
from dual;

--synonym(동의어) : 테이블,뷰, 시퀀스 등 객체 이름 대신 사용할 수 있는 다른 이름을 부여하는 객체
--emp 테이블의 별칭을 E로 지정
create synonym E for EMP;

--public : 동의어를 데이터베이스 내 모든 사용자가 사용할 수  있도록 설정
--create [public] synonym e for emp;

--데이터 사전 뷰를 통해 시퀀스 확인
select *from user_sequences;

select * from emp;
select * from E;

drop synonym E;
-- 실습1 emp테이블과 같은 구조의 데이터를 저장하는 empidx 테이블을 생성하시오
create table empidx as select * from emp;

create index idx_empidx_empno on empidx(empno);

create view EMPIDX_OVER15K as (SELECT empno, ename, job, deptno, sal, comm
from empidx where sal>1500);

drop sequence deptseq_sequence;
create table deptseq as select * from dept;

create sequence deptseq_sequence 
increment by 1 start with 1 maxvalue 99 minvalue 1 nocycle nocache;

-- 제약조건 : 테이블의 특정 열에 지정 
--          null 허용 / 불허용, 유일한 값, 조건식을 만족하는 데이터만 입력 가능...
--          데이터의 무결성(데이터 정확성, 일관성 보장) 유지 ==> DML 작업 시 지켜야 함.
--          영역 무결성, 개체 무결성, 참조 무결성
--          테이블 생성 시 제약조건 , OR 생성 후에 ALTER 를 통해 추가, 변경 가능

-- 1) NOT NULL : 빈값 허용 불가
-- 사용자로부터 입력값이 필수로 입력되어야함
create table table_notnull(
    login_id varchar2(20) not null,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
    );

insert into table_notnull(login_id,login_pwd) values('hong123','hong123');

select* from table_notnull;

insert into table_notnull(login_id,login_pwd,tel) values('hong123','hong123','010-1234-5678');

select* from  user_constraints;


-- 제약조건 + 제약조건 명 지정
create table table_notnull2(
    login_id varchar2(20) constraint TBLNN2_LOHIN_NN not null,
    login_pwd varchar2(20) constraint TBLNN2_Lgpwd_NN not null,
    tel varchar2(20) constraint TBLNN2_tel_NN not null
    );
    
-- 생성한 테이블에 제약조건 추가
-- 이미 삽입된 데이터도 체크 대상이 됨
alter table table_notnull modify(tel not null);

update table_notnull
set tel = '010-1234-5678'
where login_id = 'hong123';

alter table table_notnull2 rename constraint tblnn2_tel_nn to tblnn3_tel_nn;

alter table table_notnull2 drop constraint tel;

-- 2) unique : 중복되지 않는 값(null 삽입 가능) -> 아이디,전화번호
create table table_unique(
    login_id varchar2(20) not null,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
    );
insert into table_unique(
    login_id,
    login_pwd,
    tel
) values(
    null,
    'hong1234',
    '010-1234-5678'
);
--테이블 생성 제약조건 지정, 변경, 삭제 not null 형태와 동일함

-- 3) PTIMARY KEY(PK) : UNIQUE +NOT NULL
-- PRIMARY KEY ==> INDEX 자동 생성됨
create table table_PRIMARY(
    login_id  varchar2(20) PRIMARY KEY,
    login_pwd varchar2(20) not null,
    tel       varchar2(20)
    );
insert into table_PRIMARY(
    login_id,
    login_pwd,
    tel
) values(
    'hong123',
    'hong123',
    '010-1234-5678'
);

-- 4)외래키 : FOreign key(FK) - 다른 테이블 간 관계를 정의하는데 사용
--          특정 테이블에서 primary key 제약조건을 지정한 열을 다른 테이블의 특정 열에서 참조

--사원 추가 시 부서번호 입력을 해야 함=> dept 테이블에 deptno 만 삽입
create table dept_fk(
    deptno number(2) constraint deptfk_deptno_pk primary key,
    dname varchar2(14),
    loc varchar2(13)
    );

-- references 참조할 테이블명( 참조할 열) : 외래키 지정
create table emp_fk(
    empno number(4) CONSTRAINT empfk_empno_pk primary key,
    ename varchar(10),
    job varchar(9),
    deptno number(2) constraint empfk_deptno_fk references dept_fk(deptno));

--무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다
insert into emp_fk values(1000,'test','sales',10);

-- 외래키 제약 조건
-- 부모 테이블 데이터가 데이터 먼저 입력

--삭제 시
-- 자식 테이블 데이터 먼저 삭제
-- 부모 테이블 데이터 삭제

insert into dept_fk values(10,'database','seoul');

delete from dept_fk where deptno=10;

-- 외래 키 제약조건 옵션
-- ON DELETE CASCADE : 부모가 삭제되면 부모를 참조하는 자식 레코드도 같이 삭제
-- ON DELETE SET NULL : 부모가 삭제되면 부모를 참조하는 자식 레코드의 값을 NULL로 변경

create table dept_fk2(
    deptno number(2) constraint deptfk_deptno_pk2 primary key,
    dname varchar2(14),
    loc varchar2(13)
    );
create table emp_fk2(
    empno number(4) CONSTRAINT empfk_empno_pk2 primary key,
    ename varchar(10),
    job varchar(9),
    deptno number(2) constraint empfk_deptno_fk2 references dept_fk2(deptno) ON DELETE CASCADE);    
    
insert into dept_fk2 values(10,'database','seoul');
insert into emp_fk2 values(1000,'test','sales',10);

    delete from dept_fk2 where deptno=10; 
    
-- 5) CHECK 제약조건 : 열에 지정할 수 있는 값의 범위 또는 패턴 지정
-- 비밀번호는 3자리보다 커야 한다
--
create table table_CHECK(
    login_id  varchar2(20) PRIMARY KEY,
    login_pwd varchar2(20) CHECK(LENGTH(LOGIN_PWD)>3),
    tel       varchar2(20)
    );
--체크 제약조건(SCOTT.SYS_C008381)이 위배되었습니다
INSERT INTO TABLE_CHECK VALUES('TEST','123','010-1234-5678');

INSERT INTO TABLE_CHECK VALUES('TEST','1235','010-1234-5678');

-- 6)DEFAULT : 기본값 지정
create table table_DEFAULT(
    login_id  varchar2(20) PRIMARY KEY,
    login_pwd varchar2(20) DEFAULT '12345',
    tel       varchar2(20)
    );
INSERT INTO TABLE_DEFAULT VALUES('TEST',NULL,'010-1111-1111');
INSERT INTO TABLE_DEFAULT(LOGIN_ID, TEL) VALUES('TEST1','010-1234-5678');
SELECT * FROM TABLE_DEFAULT;



