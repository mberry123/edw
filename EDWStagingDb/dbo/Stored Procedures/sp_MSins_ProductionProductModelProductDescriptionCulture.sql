create procedure [sp_MSins_ProductionProductModelProductDescriptionCulture]
    @c1 int,
    @c2 int,
    @c3 nchar(6),
    @c4 datetime
as
begin  
	insert into [Production].[ProductModelProductDescriptionCulture] (
		[ProductModelID],
		[ProductDescriptionID],
		[CultureID],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4	) 
end  
