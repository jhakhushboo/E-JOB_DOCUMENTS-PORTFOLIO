create table Customer
(
CustomerId int identity(1,1) primary key,
CustomerName varchar(100),
SalesAmount int,
Married bit
);
insert into Customer values(1,'Khushboo Jha', 2000, 1);
insert into Customer values(2,'Shipra Jha', 2000, 1);
insert into Customer values(3,'Ronak Jha', 1000, 0);
insert into Customer values(4,'Abhinav Jha', 1500, 1);
insert into Customer values(5,'Mukesh Jha', 900, 1);
insert into Customer values(6,'Pragya Jha', 1000, 0);
insert into Customer values(7,'Muskan Jha', 700, 0);

go
create procedure sp_CustomerName
as
select CustomerName from Customer;
go

exec sp_CustomerName


go
create procedure sp_CustomerInformation
@CustomerName varchar(100)
as
select SalesAmount, Married
from Customer
where customer.CustomerName = @CustomerName;
go

exec sp_CustomerInformation 'Khushboo Jha'

go
create procedure sp_UpdateCustomerInformation
@CustomerName varchar(100),
@SalesAmount int,
@Married bit
as
update	Customer
set customer.SalesAmount = @SalesAmount, customer.Married = @Married
where customer.CustomerName = @CustomerName;
go
exec sp_UpdateCustomerInformation 'Khushboo Jha', 3000, 1
select * from customer;


create table UserInfo
(
FirstName varchar(100),
LastName varchar(50),
EmailId varchar(150) primary key,
Password varchar(100),
ConfirmPassword varchar(100),
Address varchar(200)

);


go
create procedure sp_SubmitCommand
@FirstName varchar(100),
@LastName varchar(50),
@EmailId varchar(150),
@Password varchar(100),
@ConfirmPassword varchar(100),
@Address varchar(200),
@message varchar(100) output
as
begin
insert into UserInfo (FirstName,LastName, EmailId, Password, ConfirmPassword, Address)
values (@FirstName,@LastName, @EmailId, @Password, @ConfirmPassword,@Address)
set @message = 'Success';
go


go
alter procedure sp_SubmitCommand
@FirstName varchar(100),
@LastName varchar(50),
@EmailId varchar(150),
@Password varchar(100),
@ConfirmPassword varchar(100),
@Address varchar(200),
@message varchar(100) output
as
begin
insert into UserInfo (FirstName,LastName, EmailId, Password, ConfirmPassword, Address)
values (@FirstName,@LastName, @EmailId, @Password, @ConfirmPassword,@Address);
set @message = 'Success'
end
go



select * from UserInfo
delete from UserInfo

insert into UserInfo('a','a','a','a','a','a');
