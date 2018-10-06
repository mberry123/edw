create procedure [sp_MSins_PersonStateProvince]
    @c1 int,
    @c2 nchar(3),
    @c3 nvarchar(3),
    @c4 bit,
    @c5 nvarchar(50),
    @c6 int,
    @c7 uniqueidentifier,
    @c8 datetime
as
begin  
	insert into [Person].[StateProvince] (
		[StateProvinceID],
		[StateProvinceCode],
		[CountryRegionCode],
		[IsOnlyStateProvinceFlag],
		[Name],
		[TerritoryID],
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
		@c8	) 
end  
