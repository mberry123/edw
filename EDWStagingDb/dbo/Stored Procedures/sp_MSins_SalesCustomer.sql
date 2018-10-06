create procedure [sp_MSins_SalesCustomer]
    @c1 int,
    @c2 int,
    @c3 int,
    @c4 int,
    @c5 uniqueidentifier,
    @c6 datetime
as
begin  
	insert into [Sales].[Customer] (
		[CustomerID],
		[PersonID],
		[StoreID],
		[TerritoryID],
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
