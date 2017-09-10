create table UserTable
(
FirstName varchar(100),
LastName varchar(50),
Age int
);

insert into UserTable values ('Khushboo', 'Jha', 32)
insert into UserTable values ('Abhinav', 'Jha', 34)
insert into UserTable values ('Abhigyan', 'Jha', 5)
insert into UserTable values ('Shipra', 'Jha', 30)
insert into UserTable values ('Ronak', 'Jha', 28)

go
create procedure sp_GetUser
as
select * from UserTable
go

exec sp_GetUser

