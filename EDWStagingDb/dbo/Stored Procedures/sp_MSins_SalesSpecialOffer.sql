create procedure [sp_MSins_SalesSpecialOffer]
    @c1 int,
    @c2 nvarchar(255),
    @c3 smallmoney,
    @c4 nvarchar(50),
    @c5 nvarchar(50),
    @c6 datetime,
    @c7 datetime,
    @c8 int,
    @c9 int,
    @c10 uniqueidentifier,
    @c11 datetime
as
begin  
	insert into [Sales].[SpecialOffer] (
		[SpecialOfferID],
		[Description],
		[DiscountPct],
		[Type],
		[Category],
		[StartDate],
		[EndDate],
		[MinQty],
		[MaxQty],
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
		@c10,
		@c11	) 
end  
