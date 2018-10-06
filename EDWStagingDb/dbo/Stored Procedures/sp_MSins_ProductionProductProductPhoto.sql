create procedure [sp_MSins_ProductionProductProductPhoto]
    @c1 int,
    @c2 int,
    @c3 bit,
    @c4 datetime
as
begin  
	insert into [Production].[ProductProductPhoto] (
		[ProductID],
		[ProductPhotoID],
		[Primary],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4	) 
end  
