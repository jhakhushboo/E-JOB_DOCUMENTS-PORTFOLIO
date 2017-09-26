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