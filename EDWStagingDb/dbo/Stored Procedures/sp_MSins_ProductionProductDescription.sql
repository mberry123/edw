create procedure [sp_MSins_ProductionProductDescription]
    @c1 int,
    @c2 nvarchar(400),
    @c3 uniqueidentifier,
    @c4 datetime
as
begin  
	insert into [Production].[ProductDescription] (
		[ProductDescriptionID],
		[Description],
		[rowguid],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4	) 
end  
