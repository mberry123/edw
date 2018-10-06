create procedure [sp_MSins_SalesStoreOrderStats]
    @c1 int,
    @c2 char(1),
    @c3 tinyint,
    @c4 int,
    @c5 int,
    @c6 tinyint,
    @c7 money
as
begin  
	insert into [Sales].[StoreOrderStats] (
		[BusinessEntityID],
		[OrderFrequency],
		[OrderMonth],
		[FirstOrderYear],
		[LastOrderYear],
		[MinPaymentType],
		[MinPaymentAmount]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5,
		@c6,
		@c7	) 
end  
