create procedure [sp_MSins_ProductionProductModel]
    @c1 int,
    @c2 nvarchar(50),
    @c3 xml,
    @c4 xml,
    @c5 uniqueidentifier,
    @c6 datetime
as
begin  
	insert into [Production].[ProductModel] (
		[ProductModelID],
		[Name],
		[CatalogDescription],
		[Instructions],
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
