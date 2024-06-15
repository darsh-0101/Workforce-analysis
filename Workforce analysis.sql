create database Employee
create table Location_table(Location_ID int primary key,City varchar(10))
create table Department_table (DepartmentID int primary key identity(10,10),Name varchar (10),Location_id int,
FOREIGN KEY (Location_Id)  references Location_table(Location_ID))


create table job_table (Job_ID int primary key identity (667,1),Designation varchar(30))
create table Employee_table(Employee_Id int,Last_Name varchar(20),First_Name varchar (20),
Middle_Name varchar(20), 
Job_Id int references job_table (Job_ID),
Hire_Date Date, Salary int, Comm int, Department_Id int references Department_table (DepartmentID));

--insert values
insert into Location_table
values (122,'New York'), (123, 'Dallas'), (124,' Chicago'), (167,'Boston' );
 
insert into  Department_table (Name,Location_ID)
values ('Accounting',122), (' Sales',123), (' Research',124),('Operations',167 );

insert into job_table (Designation)
values ('Clerk'), ('Staff') ,(' Analyst'), ('Sales Person'), ('Manager'), ('President');

insert Employee_table(Employee_Id, Last_Name, First_Name, Middle_Name,Job_Id, Hire_Date, Salary, Comm, Department_Id) 

values (7369,' Smith', 'John', 'Q', 667,' 17-Dec-84', 800, Null, 20), 
(7499, 'Allen', 'Kevin', 'J', 670 ,'20-Feb-85', 1600, 300, 30), 
(755, 'Doyle', 'Jean', 'K' ,671, '04-Apr-85', 2850, Null, 30),
(756, 'Dennis','Lynn','S', 671, '15-May-85', 2750, Null, 30), 
(757, 'Baker', 'Leslie', 'D', 671, '10-Jun-85', 2200, Null, 40), 
(7521, 'Wark', 'Cynthia', 'D', 670, '22-Feb-85', 1250, 50, 30); 
 update Employee_table 
 set Last_Name='Smith'
 where Employee_Id=7369
  






	   --tasks
--1.List all the employee details. 
select  * from  Employee_table

--2. List all the department details. 

select  * from [dbo].[Department_table]

--3. List all job details. 

select  * from [dbo].[job_table]

--4. List all the locations.

select * from [dbo].[Location_table]

--5. List out the First Name, Last Name, Salary, Commission for all Employees.

select First_Name, Last_Name, Salary, Comm from Employee_table

/*6. List out the Employee ID, Last Name, Department ID for all employees and alias 
Employee ID as "ID of the Employee", Last Name as "Name of the 
Employee", Department ID as "Dep_id". */

select Employee_ID as ID, Last_Name Name, Department_ID DEP_id from Employee_table;

--List out the annual salary of the employees with their names only.
select  CONCAT(first_name, ' ,' ,last_name) as Names,salary as annualsalary from Employee_table

--Where condition
 
--1. List the details about "Smith". 
select * from Employee_table
where Last_Name=' Smith';

--2. List out the employees who are working in department 20. 
select * from Employee_table
where Department_Id=20;

--3. List out the employees who are earning salary between 2000 and 3000. 

select * from Employee_table
where Salary between 2000 and 3000;

--4. List out the employees who are working in department 10 or 20. 

select * from Employee_table
where Department_Id in(10,20);

--5. Find out the employees who are not working in department 10 or 30. 

select * from Employee_table
where Department_Id not in(10,30);

--6. List out the employees whose name starts with 'L'. 
select * from Employee_table
where First_Name like 'L%';

--7. List out the employees whose name starts with 'L' and ends with 'E'. 
select * from Employee_table
where First_Name like 'L%E';
--8. List out the employees whose name length is 4 and start with 'J'. 
select * from Employee_table
where First_Name like 'J___';

/*9. List out the employees who are working in department 30 and draw the 
salaries more than 2500. */
select * from Employee_table
where Department_Id=30 and Salary>2500;

--10. List out the employees who are not receiving commission.
select * from Employee_table
where Comm is null;


--ORDER BY Clause: 
--1. List out the Employee ID and Last Name in ascending order based on the Employee ID. 

select Employee_ID, Last_Name from Employee_table
order by Employee_ID;

--2. List out the Employee ID and Name in descending order based on salary. 

select Employee_ID,CONCAT(first_name,',', Last_Name) Name from Employee_table
order by Salary desc;
--3. List out the employee details according to their Last Name in ascending-order. 
select * from Employee_table
order by  Last_Name;

--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order
select * from Employee_table
order by  Last_Name asc ,Department_Id desc;

--GROUP BY and HAVING Clause: 
--1. List out the department wise maximum salary, minimum salary and average salary of the employees. 
select Department_Id,MAX(salary) max_salary,MIN(salary) as min_salary ,AVG(Salary) as avg_salary  from Employee_table
group by Department_Id;

--2. List out the job wise maximum salary, minimum salary and average salary of the employees.
select Job_Id,MAX(salary) max_salary,MIN(salary) as min_salary ,AVG(Salary) as avg_salary  from Employee_table
group by Job_Id;

--3. List out the number of employees who joined each month in ascending order. 
select month(hire_date) as month,COUNT(employee_id) as noofempy from Employee_table
group by MONTH(Hire_Date)
order by month;

--4. List out the number of employees for each month and year in ascending order based on the year and month. 
select COUNT(employee_id)as noofempy,YEAR(Hire_Date) as year,month(hire_date) as month from Employee_table
group by MONTH(Hire_Date),YEAR(Hire_Date)
order by YEAR(Hire_Date), month;


--5. List out the Department ID having at least four employees. 
select Department_Id from Employee_table
group by Department_Id 
having COUNT(employee_id)=4;

--6. How many employees joined in February month.
SELECT MONTH(Hire_Date) as Month ,COUNT(*) as feb_joined_employee from Employee_table
GROUP by MONTH(Hire_Date)
having  MONTH(Hire_Date)=2;


--7. How many employees joined in May or June month.
select month(hire_date) as Month,COUNT(*) as employ from Employee_table
group by MONTH(hire_date)
having MONTH(hire_date)='5' or MONTH(hire_date)='6';

--8. How many employees joined in 1985? 
select year(hire_date) as year, COUNT(*) as employee from Employee_table
group by year(hire_date)
having year(hire_date)=1985;

--9. How many employees joined each month in 1985? 
select year(hire_date) as year, month(hire_date) month, COUNT(*) as employee from Employee_table
group by  year(hire_date), month(hire_date)
having year(hire_date)=1985;


--10. How many employees were joined in April 1985? 
select year(hire_date) as year, month(hire_date) month,COUNT(*) as employee_joined from Employee_table
group by year(hire_date),month(hire_date) 
having year(hire_date)=1985 and month(hire_date)=4;

--11. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
select Department_ID, Employee_Id,  year(hire_date) Year, month(hire_date) Month from Employee_table
group by Department_ID,Employee_Id,year(hire_date),month(hire_date)
having Employee_Id>=3 and  year(hire_date)=1985 and month(hire_date)=4;

--Joins: 
--1. List out employees with their department names. 
select employee_id,Name from employee_table empy
join department_table dept on empy.Department_Id=dept.DepartmentID;



--2. Display employees with their designations. 
select employee_id,designation from employee_table empy
join job_Table job on job.job_id=empy.job_id

--3. Display the employees with their department names and city. 
select employee_id,Name,City from employee_table empy
join department_table dept on dept.departmentID=empy.department_ID
join location_table loc on loc.location_id=dept.location_id;

--4. How many employees are working in different departments? Display with department names. 
select name,count(employee_id) employee_count from employee_table empy
join department_table dept on dept.departmentID=empy.department_ID
GROUP by Name;



--5. How many employees are working in the sales department? 
select COUNT(employee_id) employee_count from Department_table dept
join Employee_table emp on dept.DepartmentID=emp.Department_Id
GROUP by Name
having Name=' Sales';




/*6. Which is the department having greater than or equal to 3 
employees and display the department names in 
ascending order.*/
select name,count(employee_id) from Department_table dept
join Employee_table emp on dept.DepartmentID=emp.Department_Id
group by Name
having count(employee_id)>=3
order by name;





--7. How many employees are working in 'Dallas'? 
select COUNT(employee_id) as Dallas_employee from Department_table dept
join Location_table loc on dept.Location_id=loc.Location_ID
join Employee_table emp on dept.DepartmentID=emp.Department_Id
where City='Dallas';



 
--8.Display all employees in sales or operation departments.
select Employee_Id ,name from Department_table dept
join Employee_table emp on dept.DepartmentID=emp.Department_Id

group by Employee_Id,Name
having Name in(' Sales','Operations');


--CONDITIONAL STATEMENT 
/*1. Display the employee details with salary grades. Use conditional statement to 
create a grade column. */
select Employee_Id,Salary,
case 
     when Salary >= 2000 then 'A'
	 when Salary >= 1000 then 'B' 
	 else 'C'
End as  grade
from Employee_table;

/*2. List out the number of employees grade wise. Use conditional statement to 
create a grade column. */
select grade,count(*)  as employee_count
from(
select
case 
     when Salary >= 2000 then 'A'
	 when Salary >= 1000 then 'B' 
	 else 'C'
End as  grade

from employee_table)as graded_column
group by grade
order by grade;


/*3. Display the employee salary grades and the number of employees between 
2000 to 5000 range of salary. */

select grade,count(*)  as employee_count
from(
select
case 
     when Salary >= 2000 then 'A'
	 when Salary >= 1000 then 'B' 
	 else 'C'
End as  grade

from employee_table
where Salary between 2000 and 5000)as graded_column
group by grade
order by grade;
 
--Subqueries: 
--1. Display the employees list who got the maximum salary. 
select
       employee_id,
	   salary 
from 
     Employee_table 
where 
      Salary=(select MAX(salary) from Employee_table);

/*2. Display the employees who are working in the sales department.*/ 
select employee_id,Department_Id from Employee_table
where Department_Id=(select DepartmentID from Department_table where Name=' Sales')


/*3. Display the employees who are working as 'Clerk'.*/
select employee_id,Job_Id from Employee_table
where Job_Id=(select Job_Id from job_table where Designation='Clerk')


--4. Display the list of employees who are living in 'Boston'. 
select Employee_Id as boston_living from Employee_table
where Department_Id in(select Department_Id
                          from Department_table
						  where Location_id=(select Location_id 
						                       from Location_table
											   where City='Boston'))

--5. Find out the number of employees working in the sales department. 
select count(employee_id) as sales_count from Employee_table
where Department_Id in(select DepartmentId from Department_table where Name=' Sales');


select * from Employee_table
select * from Department_table
--6. Update the salaries of employees who are working as clerks on the basis of 10%. 

select Employee_table.Employee_Id,
       Employee_table.Job_Id,
	   Employee_table.Salary*1.10 as salary
from Employee_table
where Job_Id=(select Job_Id from job_table where Designation='Clerk');

--update the salary for employee who are working a clerks to 10%
update Employee_table
set Salary=Salary*1.10
where Job_Id=(select Job_Id from job_table where Designation='Clerk');


--7. Display the second highest salary drawing employee details. 
select top 1 employee_id ,salary from (
select top 2 employee_id ,sum(salary) salary from Employee_table
group by Employee_Id
order by salary desc)as A
order by salary 
--(or)
select employee_id,Salary from Employee_table
where Salary in(select MAX(salary) from Employee_table
                where Salary<(select MAX(salary) from Employee_table))

--8. List out the employees who earn more than every employee in department 30. 

-- List out the employees who earn more than every employee in department 30
SELECT 
    Employee_Id, 
    salary 
FROM 
    Employee_table
WHERE 
    salary > (SELECT MAX(salary) FROM Employee_table WHERE Department_Id = 30);



--9. Find out which department has no employees.
select departmentid from Department_table
where DepartmentId not in (select Department_ID from Employee_table);



--10. Find out the employees who earn greater than the average salary for their department.*/
--"where Department_Id=e.Department_Id"condition it ensures both the values are equal and calculate each dept avg rather than overall avg

select Department_Id ,salary from Employee_table e
where Salary>(select AVG(salary) from Employee_table where Department_Id=e.Department_Id )





                