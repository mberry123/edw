create procedure [sp_MSins_HumanResourcesDepartment]
    @c1 smallint,
    @c2 nvarchar(50),
    @c3 nvarchar(50),
    @c4 datetime
as
begin  
	insert into [HumanResources].[Department] (
		[DepartmentID],
		[Name],
		[GroupName],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4	) 
end  
