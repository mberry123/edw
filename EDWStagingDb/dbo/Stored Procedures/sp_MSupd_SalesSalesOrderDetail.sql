create procedure [sp_MSupd_SalesSalesOrderDetail]
		@c1 int = NULL,
		@c2 int = NULL,
		@c3 nvarchar(25) = NULL,
		@c4 smallint = NULL,
		@c5 int = NULL,
		@c6 int = NULL,
		@c7 money = NULL,
		@c8 money = NULL,
		@c9 uniqueidentifier = NULL,
		@c10 datetime = NULL,
		@pkc1 int = NULL,
		@pkc2 int = NULL,
		@bitmap binary(2)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
if (substring(@bitmap,1,1) & 1 = 1) or
 (substring(@bitmap,1,1) & 2 = 2)
begin 
update [Sales].[SalesOrderDetail] set
		[SalesOrderID] = case substring(@bitmap,1,1) & 1 when 1 then @c1 else [SalesOrderID] end,
		[SalesOrderDetailID] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [SalesOrderDetailID] end,
		[CarrierTrackingNumber] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [CarrierTrackingNumber] end,
		[OrderQty] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [OrderQty] end,
		[ProductID] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [ProductID] end,
		[SpecialOfferID] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [SpecialOfferID] end,
		[UnitPrice] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [UnitPrice] end,
		[UnitPriceDiscount] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [UnitPriceDiscount] end,
		[rowguid] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else [ModifiedDate] end
	where [SalesOrderID] = @pkc1
  and [SalesOrderDetailID] = @pkc2
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[SalesOrderID] = ' + convert(nvarchar(100),@pkc1,1) + ', '
				set @primarykey_text = @primarykey_text + '[SalesOrderDetailID] = ' + convert(nvarchar(100),@pkc2,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Sales].[SalesOrderDetail]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
else
begin 
update [Sales].[SalesOrderDetail] set
		[CarrierTrackingNumber] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [CarrierTrackingNumber] end,
		[OrderQty] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [OrderQty] end,
		[ProductID] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [ProductID] end,
		[SpecialOfferID] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [SpecialOfferID] end,
		[UnitPrice] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [UnitPrice] end,
		[UnitPriceDiscount] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [UnitPriceDiscount] end,
		[rowguid] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else [ModifiedDate] end
	where [SalesOrderID] = @pkc1
  and [SalesOrderDetailID] = @pkc2
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[SalesOrderID] = ' + convert(nvarchar(100),@pkc1,1) + ', '
				set @primarykey_text = @primarykey_text + '[SalesOrderDetailID] = ' + convert(nvarchar(100),@pkc2,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Sales].[SalesOrderDetail]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
end 
