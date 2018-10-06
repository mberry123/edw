create procedure [sp_MSins_ProductionProductCostHistory]
    @c1 int,
    @c2 datetime,
    @c3 datetime,
    @c4 money,
    @c5 datetime
as
begin  
	insert into [Production].[ProductCostHistory] (
		[ProductID],
		[StartDate],
		[EndDate],
		[StandardCost],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5	) 
end  
