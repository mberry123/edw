create procedure [sp_MSins_SalesCountryRegionCurrency]
    @c1 nvarchar(3),
    @c2 nchar(3),
    @c3 datetime
as
begin  
	insert into [Sales].[CountryRegionCurrency] (
		[CountryRegionCode],
		[CurrencyCode],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3	) 
end  
