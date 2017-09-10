go
create procedure sp_UserLoginNew
@Password varchar(50),
@Id int
as
declare @PasswordInDb varchar(50)
declare @ReturnValue varchar(150)

select	@PasswordInDb =	UserInformationTable.UserPassword
from	UserInformationTable
where	UserInformationTable.UserId = @Id

if (@Password is null)
	set @ReturnValue = '1|invalid login'
else if (@Password = @PasswordInDb)
	set @ReturnValue = '1|valid login'
else
	set @ReturnValue = '1|invalid login'
select @ReturnValue
go

go
alter procedure sp_UserLoginNew
@Password varchar(50),
@Id int
as
declare @PasswordInDb varchar(50)
declare @ReturnValue varchar(150) 
set @PasswordInDb = null

select	@PasswordInDb =	UserInformationTable.UserPassword
from	UserInformationTable
where	UserInformationTable.UserId = @Id

if (@Password is null)
	set @ReturnValue = '1|invalid login'
else if (@Password = @PasswordInDb)
	set @ReturnValue = '0|valid login'
else
	set @ReturnValue = '1|invalid login'
select @ReturnValue
go

exec sp_UserLoginNew 'abc2', 2


go
create procedure sp_GetIdentityValue
as
declare @identityValue int
Insert into UserInformationTable values('khushboo7', 'abc7')
set @identityValue = SCOPE_IDENTITY()
select @identityValue
go

exec sp_GetIdentityValue

go
create procedure sp_GetMidPoint
@LowerValue int,
@HigherValue int,
@MidPoint int output
as
if @LowerValue > @HigherValue
	raiserror('Invalid input', 16,1)
else
	set @MidPoint = ((@HigherValue - @LowerValue)/2) + @LowerValue
	--select @MidPoint
go

go
alter procedure sp_GetMidPoint
@LowerValue int,
@HigherValue int,
@MidPoint int output
as
if @LowerValue > @HigherValue
	raiserror('Invalid input', 16,1)
else
	set @MidPoint = ((@HigherValue - @LowerValue)/2) + @LowerValue
	select @MidPoint
go


declare @MidPointOut integer;
exec sp_GetMidPoint 50, 100, @MidPoint = @MidPointOut;
print @MidPointOut;


go
create procedure sp_GetCompleteInformation
as
select		co.CountryName, co.Sate, cust.CustomerAddress, cust.CustomerName, uinfo.UserName, uinfo.UserPassword
from		customer.CountryTable as co
inner join	customer.CustomerTable as cust
on			co.Id = cust.CustomerId
inner join	UserInformationTable as uinfo
on			cust.CustomerId = uinfo.UserId;
go

exec sp_GetCompleteInformation

create table Manager
(
ManagerId int identity(1,1) primary key,
ManagerDepartment varchar(100),
MgrName varchar(200)
);
insert into Manager values('er1', 'mgr1')
insert into Manager values('er2', 'mgr2')
insert into Manager values('er3', 'mgr3')
insert into Manager values('er4', 'mgr4')
insert into Manager values('er5', 'mgr5')

--drop table Manager;
select * from Manager;

create table Employee
(
EmployeeId int identity(1,1) primary key,
EmployeeName varchar(100),
EmployeeAddress varchar(200),
EmpManagerId int foreign key references Manager(ManagerId)
)

--drop table Employee;
--drop table EmployeeAppraisal;

insert into Employee values('emp1','adr1', 1)
insert into Employee values('emp2', 'adr2', 2)
insert into Employee values('emp3', 'adr3', 3)
insert into Employee values('emp4','adr4', 4)
insert into Employee values('emp5', 'adr5', 5)

select * from Employee;

create table EmployeeAppraisal
(
EmpAppraisalId int identity(1,1) primary key,
EmployeeName varchar(100),
EmployeeId int foreign key references Employee(EmployeeId)
);
insert into EmployeeAppraisal values('emp1', 1)
insert into EmployeeAppraisal values('emp2', 2)
insert into EmployeeAppraisal values('emp3', 3)
insert into EmployeeAppraisal values('emp4', 4)
insert into EmployeeAppraisal values('emp5', 5)

select * from EmployeeAppraisal;

go
create procedure sp_CompleteEmployeeDetails
as
select m.MgrName, m.ManagerDepartment, e.EmployeeName, e.EmployeeAddress, ea.EmployeeName
from Manager as m
inner join Employee as e
on m.ManagerId = e.EmpManagerId
inner join EmployeeAppraisal ea
on e.EmployeeId = ea.EmployeeId
go

exec sp_CompleteEmployeeDetails















































