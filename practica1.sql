INSERT INTO SYSTEM.ETL_PERSONAL_XXX(
	PER_ID,
    PER_ORIGEN,
    PER_FIRST_NAME,
    PER_LAST_NAME,
    PER_GENERO,
    PER_EMAIL_USR,
    PER_EMAIL_DOM,
    PER_SALARY_USD,
    PER_SALARY_MXP,
    PER_INCOME_YEAR,
    PER_INCOME_MONTH,
    PER_INCOME_DAY,
    PER_PHONE,
    PER_FEC_REG
)
SELECT
	ROWNUM AS PER_ID,
    PER_ORIGEN,
    PER_FIRST_NAME,
    PER_LAST_NAME,
    PER_GENERO,
    PER_EMAIL_USR,
    PER_EMAIL_DOM,
    PER_SALARY_USD,
    PER_SALARY_MXP,
    PER_INCOME_YEAR,
    PER_INCOME_MONTH,
    PER_INCOME_DAY,
    PER_PHONE,
    CURRENT_TIMESTAMP AS PER_FEC_REG
    FROM
    	(SELECT
	        2 AS PER_ORIGEN ,
	        FIRST_NAME AS PER_FIRST_NAME ,
	        last_name AS PER_LAST_NAME,
	        'null' AS PER_GENERO,
	        email AS PER_EMAIL_USR,
	        'null' AS PER_EMAIL_DOM,
	        salary AS PER_SALARY_USD,
	        salary*23.87 AS PER_SALARY_MXP,
	        extract (year from hire_date) AS PER_INCOME_YEAR ,
	        extract (month from hire_date) AS PER_INCOME_MONTH,
	        extract (day from hire_date) AS PER_INCOME_DAY,
	        REPLACE(PHONE_NUMBER,'.','-') AS PER_PHONE
	    FROM HR.employees
	    UNION 
	    SELECT
	        1 as PER_ORIGEN,
	        FIRST_NAME AS PER_FIRST_NAME,
	        last_name AS PER_LAST_NAME,
	        gender AS PER_GENERO,
	        SUBSTR(EMAIL,1,LENGTH(EMAIL)-LENGTH(SUBSTR(EMAIL,INSTR(EMAIL,'@',1)))) AS PER_EMAIL_USR,
	        SUBSTR(EMAIL,INSTR(EMAIL,'@',1)+1) AS PER_EMAIL_DOM,
	        salary AS PER_SALARY_USD,
	        salary*23.87 AS PER_SALARY_MXP,
	        year_of_joining AS PER_INCOME_YEAR,
	        month_of_joining AS PER_INCOME_MONTH,
	        day_of_joining AS PER_INCOME_DAY,
	        phone_no AS PER_PHONE
	    FROM RECORDS_HR);