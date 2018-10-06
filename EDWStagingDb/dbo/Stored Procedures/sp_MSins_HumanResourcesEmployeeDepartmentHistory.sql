create procedure [sp_MSins_HumanResourcesEmployeeDepartmentHistory]
    @c1 int,
    @c2 smallint,
    @c3 tinyint,
    @c4 date,
    @c5 date,
    @c6 datetime
as
begin  
	insert into [HumanResources].[EmployeeDepartmentHistory] (
		[BusinessEntityID],
		[DepartmentID],
		[ShiftID],
		[StartDate],
		[EndDate],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5,
		@c6	) 
end  
