create procedure [sp_MSins_PersonCountryRegion]
    @c1 nvarchar(3),
    @c2 nvarchar(50),
    @c3 datetime
as
begin  
	insert into [Person].[CountryRegion] (
		[CountryRegionCode],
		[Name],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3	) 
end  
