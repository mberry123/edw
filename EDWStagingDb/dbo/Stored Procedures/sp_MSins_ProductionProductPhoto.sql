create procedure [sp_MSins_ProductionProductPhoto]
    @c1 int,
    @c2 varbinary(max),
    @c3 nvarchar(50),
    @c4 varbinary(max),
    @c5 nvarchar(50),
    @c6 datetime
as
begin  
	insert into [Production].[ProductPhoto] (
		[ProductPhotoID],
		[ThumbNailPhoto],
		[ThumbnailPhotoFileName],
		[LargePhoto],
		[LargePhotoFileName],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5,
		@c6	) 
end  
