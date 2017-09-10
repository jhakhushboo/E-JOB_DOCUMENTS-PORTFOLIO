--Stored procedures
go
create procedure sp_StoredProc1
--Input parameter
@parameter1 varchar(100),
@parameter2 varchar(200) output
as
begin
	declare @parameter3 varchar(100)
	set @parameter3 = '    is your development resource.'
		if @parameter1 is not null and LEN(@parameter1) > 1
			select @parameter2 = 'The ' +@parameter1 + @parameter3
		else
			select @parameter2 = 'God will save you!'
	return
end
go

go
alter procedure sp_StoredProc1
--Input parameter
@parameter1 varchar(100),
@parameter2 varchar(200) output
as
begin
	declare @parameter3 varchar(100)
	set @parameter3 = '    is your development resource.'
		if @parameter1 is not null and LEN(@parameter1) > 1
			select @parameter2 = 'The ' +@parameter1 + @parameter3
		else
			select @parameter2 = 'God will save you!'
	return
end
go


declare @parameter2Out varchar(200);
exec sp_StoredProc1 'Khushboo', @parameter2 = @parameter2Out output;
print 'Output is   ' + @parameter2Out;
go


go
if OBJECT_ID('customer.sp_CustomerInformation2','P') is not null
	drop procedure customer.sp_CustomerInformation2;
go
create procedure customer.sp_CustomerInformation2
@customerName varchar(100),
@countryName varchar(100) output
as
	select @countryName = CountryTable.CountryName
	from CountryTable
	join CustomerTable
	on CountryTable.Id = CustomerTable.CustomerId
	where CustomerTable.CustomerName = @customerName;
return
go

go
alter procedure customer.sp_CustomerInformation2
@customerName varchar(100),
@countryName varchar(100) output
as
	select @countryName = CountryTable.CountryName
	from CountryTable
	join CustomerTable
	on CountryTable.Id = CustomerTable.CustomerId
	where CustomerTable.CustomerName = @customerName;
return
go

-- Declare the variable to receive the output value of the procedure.
declare @countryNameOut varchar(100);
exec customer.sp_CustomerInformation2 'Khushboo', @countryName = @countryNameOut output;

-- Display the value returned by the procedure.
print 'Country name for this customer is ' + @countryNameOut;
--convert(varchar(100), @countryNameOut);


go
create procedure sp_MidPoint
@lowerNumber int,
@higherNumber int,
@midNumber int output
as
begin
	declare @Mid int
	if(@lowerNumber > @higherNumber)
		raiserror('Invalid input',16,1)
	set @Mid = ((@higherNumber - @lowerNumber)/2) + @lowerNumber
	select @Mid
end
go

declare @midNumberOut int;
exec sp_MidPoint 10, 20, @midNumber = @midNumberOut;
print @midNumberOut;


go
 create procedure sp_FetchIdentityColumn
 @CustomerName varchar(150),
 @CustomerAddress varchar(250),
 @id int output
 as
 begin
	insert into customer.CustomerTable (CustomerName, CustomerAddress) values(@CustomerName, @CustomerAddress)
	set @id = SCOPE_IDENTITY()
	select @id
	return @id
 end
go

go
 alter procedure sp_FetchIdentityColumn
 @CustomerName varchar(150),
 @CustomerAddress varchar(250),
 @id int output
 as
 begin
	insert into customer.CustomerTable (CustomerName, CustomerAddress) values(@CustomerName, @CustomerAddress)
	set @id = SCOPE_IDENTITY()
	select @id
	return @id
 end
go


declare @idOut int; 
exec sp_FetchIdentityColumn 'Renu', 'Allahabad', @id = @idOut;
print @idOut;


create table UserInformationTable
(
UserId integer identity(1,1),
UserName varchar(150),
UserPassword varchar(50)
);

insert into UserInformationTable values('khushboo1', 'abc1')
insert into UserInformationTable values('khushboo2', 'abc2')
insert into UserInformationTable values('khushboo3', 'abc3')
insert into UserInformationTable values('khushboo4', 'abc4')
insert into UserInformationTable values('khushboo5', 'abc5')
insert into UserInformationTable values('khushboo6', 'abc6')

select * from UserInformationTable

go
create procedure sp_UserLogin
@UserId int,
@PasswordIn varchar(200)
as
	declare @ReturnValue varchar(500)
	declare @Password varchar(50)
	set @Password = null

	select @Password = UserInformationTable.UserPassword
	from UserInformationTable
	where UserInformationTable.UserId = @UserId;

	if(@Password is null)
		set @ReturnValue = '1|Incorrect password'
	else if (@Password = HASHBYTES('SHA1', @PasswordIn))
		set @ReturnValue = '0|Logged in Successfully'
	else
		set @ReturnValue = '1|Incorrect password'
	select @ReturnValue
go

go
alter procedure sp_UserLogin
@UserId int,
@PasswordIn varchar(200)
as
	declare @ReturnValue varchar(500)
	declare @Password varchar(50)
	set @Password = null

	select @Password = UserInformationTable.UserPassword
	from UserInformationTable
	where UserInformationTable.UserId = @UserId;
	print @Password
	print @PasswordIn

	if(@Password is null)
		set @ReturnValue = '1|Incorrect password'
	else if (@Password = @PasswordIn)
		set @ReturnValue = '0|Logged in Successfully'
	else
		set @ReturnValue = '1|Incorrect password'
	select @ReturnValue
go

exec sp_UserLogin 1, 'abc1'

select * from UserInformationTable
















































