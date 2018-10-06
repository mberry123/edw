create procedure [sp_MSins_ProductionProductCategory]
    @c1 int,
    @c2 nvarchar(50),
    @c3 uniqueidentifier,
    @c4 datetime
as
begin  
	insert into [Production].[ProductCategory] (
		[ProductCategoryID],
		[Name],
		[rowguid],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4	) 
end  
