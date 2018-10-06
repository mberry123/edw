create procedure [sp_MSins_SalesCurrency]
    @c1 nchar(3),
    @c2 nvarchar(50),
    @c3 datetime
as
begin  
	insert into [Sales].[Currency] (
		[CurrencyCode],
		[Name],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3	) 
end  
