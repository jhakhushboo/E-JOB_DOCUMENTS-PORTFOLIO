create table ViewExpenseReport
(
Names varchar(100) primary key
);

insert into ViewExpenseReport values('Mike');
insert into ViewExpenseReport values('Lisa');
insert into ViewExpenseReport values('John');
insert into ViewExpenseReport values('Mary');

create table ExpenseReportFor
(
ExpenseId int identity(1,1) primary key,
ExpenseType varchar(200),
Amount int,
Names varchar(100),
foreign key (Names) references ViewExpenseReport(Names)
);

insert into ExpenseReportFor values('Magazine subscription',50,'John');
insert into ExpenseReportFor values('New machine',600,'John');
insert into ExpenseReportFor values('Software',500,'John');
insert into ExpenseReportFor values('Magazine subscription',50,'Mike');
insert into ExpenseReportFor values('New machine',600,'Mike');
insert into ExpenseReportFor values('Software',500,'Mike');
insert into ExpenseReportFor values('Magazine subscription',50,'Lisa');
insert into ExpenseReportFor values('New machine',600,'Lisa');
insert into ExpenseReportFor values('Software',500,'Lisa');

go
create procedure sp_GetNames
as
Select * from ViewExpenseReport;
go

go
alter procedure sp_GetNames
as
Select Names from ViewExpenseReport;
go

exec sp_GetNames

go
create procedure sp_ViewExpenseReport
@Names varchar(100)
as
select ExpenseType, Amount from ExpenseReportFor
where Names = @Names;
go


exec sp_ViewExpenseReport 'Mike';

alter table ViewExpenseReport
add Department varchar(100);

select * from ViewExpenseReport;
delete from ViewExpenseReport;
delete from ExpenseReportFor;

insert into ViewExpenseReport values('Mike', 'Engineering');
insert into ViewExpenseReport values('Lisa', 'HR');
insert into ViewExpenseReport values('John', 'Research');
insert into ViewExpenseReport values('Mary', 'Management');

go
alter procedure sp_ViewExpenseReport
@Names varchar(100)
as
select		e.Names, v.Department, e.ExpenseType, e.Amount 
from		ViewExpenseReport as v
inner join	ExpenseReportFor as e
ON			e.Names = @Names
and			e.Names = v.Names;
go

exec sp_ViewExpenseReport 'Lisa';
