SET IDENTITY_INSERT EMPLOYEE ON;
CREATE TABLE EMPLOYEE(
	EMP_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	FIRST_NAME CHAR(100),
	LAST_NAME CHAR(100),
	SALARY INT,
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(100)
);

INSERT INTO EMPLOYEE(EMP_ID,FIRST_NAME,LAST_NAME,SALARY,JOINING_DATE,DEPARTMENT)
values (001,'Anika', 'Arora', 100000, '02-14-2020 09:00:00', 'HR'),
(002,'Veena', 'Verma', 80000, '06-15-2011 09:00:00', 'Admin'),
(003,'Vishal', 'Singhal', 300000,'02-16-2020 09:00:00', 'HR'),
(004,'Sushanth', 'Singh', 500000,'02-17-2020 09:00:00', 'Admin'),
(005,'Bhupal', 'Bhati', 500000, '06-18-2011 09:00:00', 'Admin'),
(006,'Dheeraj', 'Diwan', 200000,'06-19-2011 09:00:00', 'Account'),
(007,'Karan', 'Kumar', 75000,'01-14-2020 09:00:00', 'Account'),
(008,'Chandrika', 'Chauhan', 90000,'04-15-2011 09:00:00','Admin')

CREATE TABLE EMP_BONUS (
	EMP_REF_ID INT,
	BONUS_AMOUNT INT,
	BONUS_DATE DATETIME,
	FOREIGN KEY (EMP_REF_ID) REFERENCES EMPLOYEE(EMP_ID)
	ON DELETE CASCADE
);

INSERT INTO EMP_BONUS 
	(EMP_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '02-16-2020'),
		(002, 3000, '06-16-2011'),
		(003, 4000, '02-16-2020'),
		(001, 4500, '02-16-2020'),
		(002, 3500, '06-16-2011');
CREATE TABLE EMP_TITLE (
	EMP_REF_ID INT,
	EMP_TITLE CHAR(25),
	AFFECTIVE_FROM DATETIME,
	FOREIGN KEY (EMP_REF_ID)
		REFERENCES EMPLOYEE(EMP_ID)
        ON DELETE CASCADE
);

INSERT INTO EMP_TITLE 
	(EMP_REF_ID, EMP_TITLE, AFFECTIVE_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');

 SELECT * FROM EMPLOYEE
 SELECT * FROM EMP_BONUS
 SELECT * FROM EMP_TITLE

 --1 Display the “FIRST_NAME” from Employee table using the alias name as Employee_name.

 SELECT FIRST_NAME AS EMPLOYEE_NAME FROM EMPLOYEE

 --2 Display “LAST_NAME” from Employee table in upper case.

 SELECT UPPER(LAST_NAME) FROM EMPLOYEE

 --3 Display unique values of DEPARTMENT from EMPLOYEE table.

 Select distinct DEPARTMENT from EMPLOYEE;

 --4 Display the first three characters of  LAST_NAME from EMPLOYEE table.

 Select substring(LAST_NAME,1,3) from EMPLOYEE;

 --5 Display the unique values of DEPARTMENT from EMPLOYEE table and prints its length.

 Select distinct lEN(DEPARTMENT) from EMPLOYEE;

 --6 Display the FIRST_NAME and LAST_NAME from EMPLOYEE table into a single column AS FULL_NAME. 
 --A space char should separate them.

 Select CONCAT(ltrim(rtrim(FIRST_NAME)),' ',ltrim(rtrim(LAST_NAME))) AS 'FULL_NAME' from EMPLOYEE;

 --7 DISPLAY all EMPLOYEE details from the Worker table 
 --order by FIRST_NAME Ascending.

Select * from EMPLOYEE order by FIRST_NAME asc;

--8. Display all EMPLOYEE details order by FIRST_NAME Ascending and DEPARTMENT Descending.

Select * from EMPLOYEE order by FIRST_NAME asc,DEPARTMENT desc;

--9 Display details for EMPLOYEE with the 
--first name as “VEENA” and “KARAN” from EMPLOYEE table.

Select * from EMPLOYEE where FIRST_NAME in ('VEENA','KARAN');

--10 Display details of EMPLOYEE with DEPARTMENT name as “Admin”.

Select * from EMPLOYEE where DEPARTMENT like 'Admin%';

--11 DISPLAY details of the EMPLOYEES whose FIRST_NAME contains ‘V’.

Select * from EMPLOYEE where FIRST_NAME like '%V'

--12 DISPLAY details of the EMPLOYEES whose SALARY lies between 100000 and 500000.

Select * from EMPLOYEE where SALARY between 100000 and 500000;
 
 --13 Display details of the employees who have joined in Feb-2020.

  Select * from Employee where year(JOINING_DATE) = 2020 and month(JOINING_DATE) = 2;

  --14 Display worker names with salaries >= 50000 and <= 100000.

SELECT CONCAT(ltrim(rtrim(FIRST_NAME)), ' ', ltrim(rtrim(LAST_NAME))) as full_name , Salary 
FROM EMPLOYEE 
WHERE emp_ID IN 
(SELECT emp_ID FROM EMPLOYEE 
WHERE Salary BETWEEN 50000 AND 100000);


--16 DISPLAY details of the EMPLOYEES who are also Managers.

SELECT DISTINCT E.FIRST_NAME, T.EMP_TITLE
FROM EMPLOYEE E
INNER JOIN EMP_TITLE T
ON E.EMP_ID = T.EMP_REF_ID
AND T.EMP_TITLE in ('Manager');

--17 DISPLAY duplicate records having matching data in some fields of a table.

SELECT EMP_TITLE, AFFECTIVE_FROM, COUNT(*) AS NUM_DUPLICATES
FROM EMP_Title
GROUP BY EMP_TITLE, AFFECTIVE_FROM
HAVING COUNT(*) > 1;

--18 Display only odd rows from a table.

SELECT * FROM EMPLOYEE WHERE (EMP_ID%2)<>0

--19 Clone a new table from EMPLOYEE table.

SELECT * INTO EMPBKP FROM EMPLOYEE;

--20 DISPLAY the TOP 2 highest salary from a table.

 SELECT DISTINCT TOP 2 Salary
 FROM EMPLOYEE 
 ORDER BY Salary DESC

 --21. DISPLAY the list of employees with the same salary.

Select distinct E.EMP_ID, E.FIRST_NAME, E.Salary 
from EMPLOYEE E, EMPLOYEE E1 
where E.Salary = E1.Salary 
and E.EMP_ID != E1.EMP_ID;

--22 Display the second highest salary from a table.

Select max(Salary) from employee 
where Salary not in (Select max(Salary) from employee);

--23 Display the first 50% records from a table.

SELECT *
FROM employee
WHERE emp_ID <= (SELECT count(emp_ID)/2 from employee);

--24. Display the departments that have less than 4 people in it.

SELECT DEPARTMENT, COUNT(emp_id) as 'Number of employees' 
FROM employee GROUP BY DEPARTMENT HAVING COUNT(emp_id) < 4;

--25. Display all departments along with the number of people in there.

SELECT DEPARTMENT, COUNT(DEPARTMENT) as 'Number of Workers' 
FROM employee GROUP BY DEPARTMENT;

--26 Display the name of employees having the highest salary in each department.

SELECT e.DEPARTMENT,e.FIRST_NAME,e.Salary from(SELECT max(Salary) as TotalSalary,DEPARTMENT from employee group by DEPARTMENT) as Temp 
Inner Join employee e on Temp.DEPARTMENT=e.DEPARTMENT 
 and Temp.TotalSalary=e.Salary;

--27 Display the names of employees who earn the highest salary.

SELECT FIRST_NAME, SALARY from employee WHERE SALARY=(SELECT max(SALARY) from employee);

--28 Diplay the average salaries for each department

select department,avg(salary) as avg_salary from employee group by department

--29 display the name of the employee who has got maximum bonus
select first_name
from
employee e
inner join
emp_bonus_bkp b
on e.EMP_ID=b.EMP_REF_ID
where total_bonus = (select max(total_bonus) from emp_bonus_bkp)

--30 Display the first name and title of all the employees
select FIRST_name, emp_title
from
employee e 
inner join
EMP_TITLE t
on e.EMP_ID=t.EMP_REF_ID