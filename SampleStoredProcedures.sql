
create schema customer;

create table customer.CustomerTable
(
CustomerId integer,
CustomerName varchar(100),
CustomerAddress varchar(150)

);

insert into customer.CustomerTable values ('Khushboo', 'NJ');
insert into customer.CustomerTable values ('Sahikha', 'MA');
insert into customer.CustomerTable values ('John', 'Boston');
insert into customer.CustomerTable values ('Tom', 'Brookline');
insert into customer.CustomerTable values ('Abhinav', 'NJ');
insert into customer.CustomerTable values ('Abhigyan', 'NJ');

alter table customer.CustomerTable drop column CustomerId
alter table customer.CustomerTable add CustomerId integer identity(1,1); 
select * from customer.CustomerTable;




create table customer.CountryTable
(
Id integer,
CountryName varchar(100),
Sate varchar(150)

);

select * from customer.CustomerTable;
select * from customer.CountryTable;

insert into customer.CountryTable values (1, 'India', 'Bihar');
insert into customer.CountryTable values (2, 'Bangaladesh', 'MA');
insert into customer.CountryTable values (3, 'USA', 'Boston');
insert into customer.CountryTable values (4, 'USA', 'Brookline');
insert into customer.CountryTable values (5, 'India', 'Bihar');
insert into customer.CountryTable values (6, 'India', 'Bihar');



use master
go
create procedure customer.sp_CustomerInformation
@CustomerId int,
@CountryId int
as
	select CustomerName, CustomerAddress, CountryName, Sate
	from		customer.CustomerTable 
	inner join	customer.CountryTable
	ON		CustomerId = @CustomerId and Id = @CountryId;
go

exec customer.sp_CustomerInformation 1, 1


go
create procedure customer.sp_CustomerInformation2
@CustomerId int,
@CountryId int
as
	select	CustomerName, CustomerAddress, CountryName, Sate
	from		customer.CustomerTable 
	left join	customer.CountryTable
	ON			CustomerId = @CustomerId and Id = @CountryId;
go

exec customer.sp_CustomerInformation2 3, 3

go
create procedure sp_CustomerCountryInfo
@CustomerId int,
@CountryId int
as
	select		CountryName, Sate
	from		customer.CustomerTable 
	right join	customer.CountryTable
	ON			CustomerId = @CustomerId and Id = @CountryId;			
go

alter procedure sp_CustomerCountryInfo
@CustomerId int,
@CountryId int
as
	select	CustomerName, CountryName, Sate
	from		customer.CustomerTable 
	right join	customer.CountryTable
	ON			CustomerId = @CustomerId and Id = @CountryId;			
go


exec sp_CustomerCountryInfo 4, 4

go
create procedure Eligibility
@MaxAge int
as
	if(@MaxAge > 18)
		begin
			print 'YOU ARE ELIGIBLE FOR ADMISSION'
		end
	else
		begin
			print 'YOU ARE NOT ELIGIBLE FOR ADMISSION'
		end
go

exec Eligibility 15



























