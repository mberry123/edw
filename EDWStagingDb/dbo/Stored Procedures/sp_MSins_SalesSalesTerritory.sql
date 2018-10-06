create procedure [sp_MSins_SalesSalesTerritory]
    @c1 int,
    @c2 nvarchar(50),
    @c3 nvarchar(3),
    @c4 nvarchar(50),
    @c5 money,
    @c6 money,
    @c7 money,
    @c8 money,
    @c9 uniqueidentifier,
    @c10 datetime
as
begin  
	insert into [Sales].[SalesTerritory] (
		[TerritoryID],
		[Name],
		[CountryRegionCode],
		[Group],
		[SalesYTD],
		[SalesLastYear],
		[CostYTD],
		[CostLastYear],
		[rowguid],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5,
		@c6,
		@c7,
		@c8,
		@c9,
		@c10	) 
end  
