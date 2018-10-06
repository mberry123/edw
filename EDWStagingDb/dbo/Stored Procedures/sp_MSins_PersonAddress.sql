create procedure [sp_MSins_PersonAddress]
    @c1 int,
    @c2 nvarchar(60),
    @c3 nvarchar(60),
    @c4 nvarchar(30),
    @c5 int,
    @c6 nvarchar(15),
    @c7 [geography],
    @c8 uniqueidentifier,
    @c9 datetime
as
begin  
	insert into [Person].[Address] (
		[AddressID],
		[AddressLine1],
		[AddressLine2],
		[City],
		[StateProvinceID],
		[PostalCode],
		[SpatialLocation],
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
		@c9	) 
end  
