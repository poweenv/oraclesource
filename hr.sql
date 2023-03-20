--employee 테이블 전체 내용 조회

--employee 테이블 first_name, last_name,job_id 만 조회

SELECT
    *
FROM
    employees;

SELECT
    first_name,
    last_name,
    job_id
FROM
    employees;

SELECT
    last_name
FROM
    employees
WHERE
    employee_id = 176;

SELECT
    last_name,
    salary
FROM
    employees
WHERE
    salary >= 12000;

SELECT
    last_name,
    salary
FROM
    employees
WHERE
    salary <= 5000
    OR salary >= 12000
ORDER BY
    salary DESC;

--20,50번 부서에서 근무하는 모든사람들의  LAST_NAME,부서번호를  오름차순으로 조회
SELECT
    last_name,
    department_id
FROM
    employees
WHERE
    department_id IN ( 20, 50 )
ORDER BY
    last_name,
    department_id;

--커미션을 받는 모든 사람들의 LAST_NAME,연봉, 커미션 조회(연봉은 내림차순, 커미션 내림차순)
SELECT
    last_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct > 0
ORDER BY
    last_name ASC,
    salary DESC,
    commission_pct DESC;
--연봉이 2500,3500,7000이 아니며 직업이 SA_REP 나 ST_CLERK 인 사원 조회
SELECT
    *
FROM
    employees
WHERE
    salary NOT IN ( 2500, 3500, 7000 )
    AND job_id IN ( 'SA_REP', 'ST_CLERK' );

--2008/02/20~2008/05/01 사이에 고용된 사원들의 last_name,사번,고용일자 조회
--고용일자 내림차순 정렬
--날짜 표현시 홀따올표 안에 표현 -,/ 사용가능

SELECT
    last_name,
    employee_id,
    hire_date
FROM
    employees
WHERE
        hire_date >= '2008-02-20'
    AND hire_date <= '2008-05-01'
ORDER BY
    hire_date DESC;

--2004년에 고용된 사람들의 LAST_NAME,HIRE_DATE 조회
--고용일자 오름차순 정렬

SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
        hire_date >= '2004-01-01'
    AND hire_date <= '2004-12-31'
ORDER BY
    hire_date;

SELECT
    last_name,
    employee_id,
    hire_date
FROM
    employees
WHERE
    hire_date BETWEEN '2008-02-20' AND '2008-05-01'
ORDER BY
    hire_date DESC;

SELECT
    last_name,
    salary
FROM
    employees
WHERE
    dEpartment_id IN ( 20, 50 )
    AND salary BETWEEN 5000 AND 12000
ORDER BY
    salary DESC;
    
    
    
    
    
    
    
    
    
--LAST_NAME 에 U가 포함된 사원들의 사번,LAST_NAME 조회
SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME LIKE '%u%';


--LAST_NAME 에 4번째 글자가 S인 사원들의 LAST_NAME 조회
SELECT LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME LIKE '___s%';
--LAST_NAME 에 a혹은 e글자가 포함된 사원들의 LAST_NAME 조회 LAST_NAME 오름차순 정렬
SELECT LAST_NAME
FROM EMPLOYEES
WHERE lAST_NAME LIKE '%e%'OR lAST_NAME LIKE '%a%'
ORDER BY LAST_NAME;
--LAST_NAME 에 a와 e글자가 포함된 사원들의 LAST_NAME 조회 LAST_NAME 오름차순정렬
SELECT LAST_NAME
FROM EMPLOYEES
WHERE lAST_NAME LIKE '%a%e%' OR lAST_NAME LIKE '%e%a%'
ORDER BY LAST_NAME;

--매니저가 없는 사람들의 LAST_NAME,JOB_ID 조회
SELECT LAST_NAME, JOB_ID
FROM employees
WHERE MANAGER_ID IS NULL OR MANAGER_ID='';
--JOB_ID가  ST_CLERK 인 사원의 부서번호 조회(단 부서번호가  NULL 인 사원은 제외한다.)
--중복을 제거한 후 부서번호만 조회
SELECT DISTINCT DEPARTMENT_ID
FROM EMPLOYEES
WHERE JOB_ID='ST_CLERK' AND DEPARTMENT_ID IS NOT NULL;
--COMMISSION_PCT NULL이 아닌 사원들 중에서  COMMISSION = SALARY*COMMISSION_PCT를 구하여
--EMPLOYEE_ID , FIRST_NAME, JOB_ID 출력
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID , SALARY*COMMISSION_PCT AS COMMISSION
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;



