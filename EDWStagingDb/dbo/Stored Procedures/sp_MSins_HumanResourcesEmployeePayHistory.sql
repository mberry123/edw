create procedure [sp_MSins_HumanResourcesEmployeePayHistory]
    @c1 int,
    @c2 datetime,
    @c3 money,
    @c4 tinyint,
    @c5 datetime
as
begin  
	insert into [HumanResources].[EmployeePayHistory] (
		[BusinessEntityID],
		[RateChangeDate],
		[Rate],
		[PayFrequency],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5	) 
end  
