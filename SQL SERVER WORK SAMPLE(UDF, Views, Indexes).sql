--SQL SERVER WORK SAMPLE

--EMPLOYEE INFORMATION TABLE
--Id	int	Unchecked
--FirstName	nvarchar(MAX)	Unchecked
--LastName	nvarchar(MAX)	Unchecked
--FullName	nvarchar(MAX)	Unchecked
--Gender	nvarchar(MAX)	Unchecked
--DateOfBirth	datetime	Unchecked
--Married	int	Unchecked
--EmployeeTypeId	int	Unchecked
--AnnualSalary	int	Unchecked
--HourlyPay	int	Unchecked
--HoursWorked	int	Unchecked

-- user defined functions
--Scalar UDF
create function EmployeeMaritalStatus(@Ms int)
returns nvarchar(50)
as
begin
declare @MaritalStatus nvarchar(50)
	if(@Ms = 1)
		set @MaritalStatus = 'Married'
	else
		set @MaritalStatus = 'UnMarried'
	return @MaritalStatus 
end

select dbo.EmployeeMaritalStatus(0) as EmployeeMaritalStatus;

--Use of scalar udf
select FullName, Gender, Married, dbo.EmployeeMaritalStatus(Married) as EmployeeMaritalStatus
from EmployeeInformations
where dbo.EmployeeMaritalStatus(Married) = 'Married';

--Inline Table Valued Functions
create function fn_EmployeeByEmployeeType(@EmpTypeId int)
returns table
as
return(select FullName, Gender, DateOfBirth
from EmployeeInformations
where EmployeeTypeId = @EmpTypeId)

select * from fn_EmployeeByEmployeeType(1)

--The table returned by the inline table valued function, can also be used in joins with other tables.
select FullName, Gender, DateOfBirth
from fn_EmployeeByEmployeeType(1) E
inner join Hobby H
on E.Gender = H.GenderId

-- Multi-statement Table Valued function(MSTVF):
create function fn_MSTVF_GetEmployeePublicInfo()
returns @table table(Id int, FullName nvarchar(50), DOB date)
as
begin

insert into @table
select Id, FullName, CAST(DateOfBirth as date)
from EmployeeInformations

return
end

select * from fn_MSTVF_GetEmployeePublicInfo()

--Cross apply and outer apply in sql server

--SQL Script to create the tables and populate with test data
Create table Department
(
    Id int primary key,
    DepartmentName nvarchar(50)
)
Go

Insert into Department values (1, 'IT')
Insert into Department values (2, 'HR')
Insert into Department values (3, 'Payroll')
Insert into Department values (4, 'Administration')
Insert into Department values (5, 'Sales')
Go

Create table Employee
(
    Id int primary key,
    Name nvarchar(50),
    Gender nvarchar(10),
    Salary int,
    DepartmentId int foreign key references Department(Id)
)
Go

Insert into Employee values (1, 'Mark', 'Male', 50000, 1)
Insert into Employee values (2, 'Mary', 'Female', 60000, 3)
Insert into Employee values (3, 'Steve', 'Male', 45000, 2)
Insert into Employee values (4, 'John', 'Male', 56000, 1)
Insert into Employee values (5, 'Sara', 'Female', 39000, 2)
Go

create function fn_GetEmployeesByDepartmentId(@DepartmentId int)
returns table
as
return(select Id, Name, Gender, Salary, DepartmentId
from Employee where DepartmentId = @DepartmentId)
go

select * from fn_GetEmployeesByDepartmentId(1)
go

--To perform inner join between table and function, use CROSS APPLY
select D.DepartmentName, E.Name, E.Gender, E.Salary
from Department D
cross apply fn_GetEmployeesByDepartmentId(D.Id) E
go

--To perform left join between table and function, use OUTER APPLY
select D.DepartmentName, E.Name, E.Gender, E.Salary
from Department D
outer apply fn_GetEmployeesByDepartmentId(D.Id) E
go

--INDEXES

--Creates non-unique, non clustered index
create index ix_Employee_Salary
on Employee(Salary asc)

select * 
from Employee
where Salary > 50000 and Salary < 70000

--Clustered Index:
--A clustered index determines the physical order of data in a table. 
--For this reason, a table can have only one clustered index. 
--Example: Primary key creates unique clustered index automatically if no clustered index already exists on the table

sp_helpindex Employee

select * from Department











--Basic statements
alter table [dbo].[EmployeeInformations]
alter column Gender nvarchar(50)

select * from [dbo].[EmployeeInformations]


create table People
(
Id int primary key,
GenderId nvarchar(50),
Name nvarchar(50)
)


create table Hobby
(
GenderId nvarchar(50) primary key,
Hobby nvarchar(50)
)
select * from Hobby

alter table People
add constraint fk_People foreign key (GenderId)
references Hobby(GenderId);


 --views

-- tables, indexes (and their types)