create database EmployeeInfo;

create table Employee_1Info
(
EmpID int,
EmpfName varchar(50),
EmplName varchar (50),
Department varchar (50),
Project Varchar (50),
Adress varchar (50),
DOB date ,
Gender varchar (50),
);
insert into Employee_1Info (EmpID,EmpfName,EmplName,Department,Project,Adress,DOB,Gender)
values('1','Sanjay','Mehra','HR','P1','Hyderabad(HYD)','01-12-1976','M'),
('2','Ananya','Mishra','Admin','P2','delhi(DEL)','02-05-1968','F'),
('3','Roshan','Diwan','Account','P3','Mumbai(BOM)','01-01-1980','M'),
('4','Sonia','Kulkarni','HR','P1','Hyderabad(HYD)','02-05-1992','F'),
('5','Ankit','kapoor','Admoin','P2','Delhi(DEL)','03-07-1994','M');
select * from Employee_1Info;

create database EmployePosition;
create table EmployeePosition
(
EmpID int,
EmpPosition varchar (50),
DateOfJoining date,
Salary int,
);
insert into EmployeePosition (EmpID,EmpPosition,DateOfJoining,Salary)
values('1','Manager','01/05/2024','500000'),
('2','Executive','02/05/2024','75000'),
('3','Manager','01/05/2024','90000'),
('4','Lead','02/05/2024','85000'),
('5','Executive','01/05/2024','300000');
select * from EmployeePosition

--1.Upper case and use the ALIAS name as EmpName----

SELECT UPPER(EmpFname) AS EmpName FROM Employee_1Info;

--2.The number of employees working in the department ‘HR’.----

SELECT COUNT(*) FROM Employee_1Info WHERE Department = 'HR';

--3.Get the current date.---

SELECT GETDATE();

--4.The first four characters of  EmpLname from the EmployeeInfo table.---

SELECT SUBSTRING(EmpLname, 1, 4) FROM Employee_1Info;

--5.The place name(string before brackets) from the Address column of EmployeeInfo table.---

SELECT SUBSTRING(Adress, 1, CHARINDEX('(',Adress)) FROM Employee_1Info;

--6.Create a new table which consists of data and structure copied from the other table.

SELECT * INTO NewTable FROM Employee_1Info WHERE 1 = 0;

--7.All the employees whose salary is between 50000 to 100000.

SELECT * FROM EmployeePosition WHERE Salary BETWEEN '50000' AND '100000';

--8.Names of employees that begin with ‘S’.---

SELECT * FROM Employee_1Info WHERE EmpFname LIKE 'S%';

--9.Top Number of  records.

SELECT TOP 2 * FROM EmployeePosition ORDER BY Salary DESC;

--10.EmpFname and EmpLname in a single column as “FullName”. The first name and the last name must be separated with space.---

SELECT CONCAT(EmpFname, ' ', EmpLname) AS 'FullName' FROM Employee_1Info;

--11.Employees whose DOB is between 02/05/1970 to 31/12/1975 and are grouped according to gender.--

SELECT COUNT(*), Gender FROM Employee_1Info WHERE DOB BETWEEN '1976-05-02' AND '1980-12-31' GROUP BY Gender;

--12.All the records from the Employee_1Info table ordered by EmpLname in descending order and Department in the ascending order.---

SELECT * FROM Employee_1Info ORDER BY EmpFname desc, Department asc;

--13.Details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets.---

SELECT * FROM Employee_1Info WHERE EmpLname LIKE '____a';

--14.Details of all employees excluding the employees with first names, “Sanjay” and “Sonia” from the Employee_1Info table.---

SELECT * FROM Employee_1Info WHERE EmpFname NOT IN ('Sanjay','Sonia');

--15.Details of employees with the address as “DELHI(DEL)”.---

SELECT * FROM Employee_1Info WHERE Adress LIKE 'DELHI(DEL)%';

--16.All employees who also hold the managerial position..---

SELECT E.EmpFname, E.EmpLname, P.EmpPosition 
FROM Employee_1Info E INNER JOIN EmployeePosition P ON
E.EmpID = P.EmpID AND P.EmpPosition IN ('Manager');

--17.department-wise count of employees sorted by department’s count in ascending order.---

SELECT Department, count(EmpID) AS EmpDeptCount FROM Employee_1Info GROUP BY Department ORDER BY EmpDeptCount ASC;

--18. calculate the even and odd records from a table.

Select * from Employee_1Info where EmpID%2='0';

Select * from Employee_1Info where EmpID%2='1';

--19.Employee details from Employee_1Info table who have a date of joining in the EmployeePosition table.--

SELECT * FROM Employee_1Info E WHERE EXISTS (SELECT * FROM EmployeePosition P WHERE E.EmpId = P.EmpId);

--20.Two minimum and maximum salaries from the EmployeePosition table.

SELECT DISTINCT Salary FROM EmployeePosition E1 WHERE 2 >= (SELECT COUNT(DISTINCT Salary) FROM EmployeePosition E2 
WHERE E1.Salary <= E2.Salary) ORDER BY E1.Salary DESC;

--21.Nth highest salary from the table without using TOP/limit keyword.

SELECT Salary FROM EmployeePosition E1 WHERE 2-1 = ( SELECT COUNT( DISTINCT ( E2.Salary ) ) 
FROM EmployeePosition E2 WHERE E2.Salary >  E1.Salary );

--22.Duplicate records from a table.---

---SELECT EmpID, EmpFname, Department COUNT(*) 
FROM Employee_1Info GROUP BY EmpID, EmpFname, Department 
HAVING COUNT(*) > 1;

SELECT EmpID, EmpFname, Department, COUNT(*) 
FROM Employee_1Info 
GROUP BY EmpID, EmpFname, Department 
HAVING COUNT(*) > 1;-----

--23.List of employees working in the same department.---

SELECT DISTINCT E.EmpID, E.EmpFname, E.Department FROM Employee_1Info E
JOIN Employee_1Info E1 ON E.Department = E1.Department AND E.EmpID != E1.EmpID;

--24.last 3 records from the EmployeeInfo table.---

--SELECT * FROM Employee_1Info WHERE EmpID <=3 UNION SELECT * FROM
(SELECT * FROM Employee_1Info E ORDER BY E.EmpID DESC) AS E1 WHERE E1.EmpID <=3;

SELECT * FROM Employee_1Info WHERE EmpID <= 3
UNION
SELECT TOP 3 * FROM (
    SELECT * FROM Employee_1Info E ORDER BY E.EmpID DESC
) AS E1;---

--25.Third-highest salary from the EmpPosition table.---

SELECT TOP 1 salary FROM(SELECT TOP 3 salary FROM EmployeePosition ORDER BY salary DESC) AS emp
ORDER BY salary ASC;

--26.Last record from the EmployeeInfo table.---

SELECT * FROM Employee_1Info WHERE EmpID = (SELECT MIN(EmpID) FROM Employee_1Info);

--27.Add email validation to your database.--

SELECT Email FROM Employee_1Info WHERE NOT REGEXP_LIKE(Email, ‘[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}’, ‘i’);


--28.Departments who have less than 2 employees working in it.---

SELECT DEPARTMENT, COUNT(EmpID) as 'EmpNo' FROM Employee_1Info GROUP BY DEPARTMENT HAVING COUNT(EmpID) < 2;

--29.EmpPostion along with total salaries paid for each of them.---

SELECT EmpPosition, SUM(Salary) from EmployeePosition GROUP BY EmpPosition;

--30.fetch 50% records from the EmployeeInfo table.---

SELECT * 
FROM Employee_1Info WHERE
EmpID <= (SELECT COUNT(EmpID)/2 from Employee_1Info);