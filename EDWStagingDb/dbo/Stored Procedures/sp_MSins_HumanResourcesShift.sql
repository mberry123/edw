create procedure [sp_MSins_HumanResourcesShift]
    @c1 tinyint,
    @c2 nvarchar(50),
    @c3 time,
    @c4 time,
    @c5 datetime
as
begin  
	insert into [HumanResources].[Shift] (
		[ShiftID],
		[Name],
		[StartTime],
		[EndTime],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5	) 
end  
