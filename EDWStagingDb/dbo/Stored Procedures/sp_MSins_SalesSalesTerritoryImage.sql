create procedure [sp_MSins_SalesSalesTerritoryImage]
    @c1 int,
    @c2 varbinary(max)
as
begin  
	insert into [Sales].[SalesTerritoryImage] (
		[TerritoryID],
		[SalesTerritoryImage]
	) values (
		@c1,
		@c2	) 
end  
