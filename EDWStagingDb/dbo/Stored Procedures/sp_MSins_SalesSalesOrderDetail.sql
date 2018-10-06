create procedure [sp_MSins_SalesSalesOrderDetail]
    @c1 int,
    @c2 int,
    @c3 nvarchar(25),
    @c4 smallint,
    @c5 int,
    @c6 int,
    @c7 money,
    @c8 money,
    @c9 uniqueidentifier,
    @c10 datetime
as
begin  
	insert into [Sales].[SalesOrderDetail] (
		[SalesOrderID],
		[SalesOrderDetailID],
		[CarrierTrackingNumber],
		[OrderQty],
		[ProductID],
		[SpecialOfferID],
		[UnitPrice],
		[UnitPriceDiscount],
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
		@c9,
		@c10	) 
end  
