create procedure [sp_MSins_SalesStore]
    @c1 int,
    @c2 nvarchar(50),
    @c3 int,
    @c4 xml,
    @c5 uniqueidentifier,
    @c6 datetime
as
begin  
	insert into [Sales].[Store] (
		[BusinessEntityID],
		[Name],
		[SalesPersonID],
		[Demographics],
		[rowguid],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5,
		@c6	) 
end  
