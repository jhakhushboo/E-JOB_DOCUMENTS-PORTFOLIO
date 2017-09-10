go
create procedure sp_GetEmpIdName
as
select Employee.EmployeeId, Employee.EmployeeName 
from Employee;
go

exec sp_GetEmpIdName;