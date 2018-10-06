create procedure [sp_MSupd_SalesSalesOrderHeader]
		@c1 int = NULL,
		@c2 tinyint = NULL,
		@c3 datetime = NULL,
		@c4 datetime = NULL,
		@c5 datetime = NULL,
		@c6 tinyint = NULL,
		@c7 bit = NULL,
		@c8 nvarchar(25) = NULL,
		@c9 nvarchar(15) = NULL,
		@c10 int = NULL,
		@c11 int = NULL,
		@c12 int = NULL,
		@c13 int = NULL,
		@c14 int = NULL,
		@c15 int = NULL,
		@c16 int = NULL,
		@c17 varchar(15) = NULL,
		@c18 int = NULL,
		@c19 money = NULL,
		@c20 money = NULL,
		@c21 money = NULL,
		@c22 nvarchar(128) = NULL,
		@c23 uniqueidentifier = NULL,
		@c24 datetime = NULL,
		@pkc1 int = NULL,
		@bitmap binary(3)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
if (substring(@bitmap,1,1) & 1 = 1)
begin 
update [Sales].[SalesOrderHeader] set
		[SalesOrderID] = case substring(@bitmap,1,1) & 1 when 1 then @c1 else [SalesOrderID] end,
		[RevisionNumber] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [RevisionNumber] end,
		[OrderDate] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [OrderDate] end,
		[DueDate] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [DueDate] end,
		[ShipDate] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [ShipDate] end,
		[Status] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [Status] end,
		[OnlineOrderFlag] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [OnlineOrderFlag] end,
		[PurchaseOrderNumber] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [PurchaseOrderNumber] end,
		[AccountNumber] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [AccountNumber] end,
		[CustomerID] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else [CustomerID] end,
		[SalesPersonID] = case substring(@bitmap,2,1) & 4 when 4 then @c11 else [SalesPersonID] end,
		[TerritoryID] = case substring(@bitmap,2,1) & 8 when 8 then @c12 else [TerritoryID] end,
		[BillToAddressID] = case substring(@bitmap,2,1) & 16 when 16 then @c13 else [BillToAddressID] end,
		[ShipToAddressID] = case substring(@bitmap,2,1) & 32 when 32 then @c14 else [ShipToAddressID] end,
		[ShipMethodID] = case substring(@bitmap,2,1) & 64 when 64 then @c15 else [ShipMethodID] end,
		[CreditCardID] = case substring(@bitmap,2,1) & 128 when 128 then @c16 else [CreditCardID] end,
		[CreditCardApprovalCode] = case substring(@bitmap,3,1) & 1 when 1 then @c17 else [CreditCardApprovalCode] end,
		[CurrencyRateID] = case substring(@bitmap,3,1) & 2 when 2 then @c18 else [CurrencyRateID] end,
		[SubTotal] = case substring(@bitmap,3,1) & 4 when 4 then @c19 else [SubTotal] end,
		[TaxAmt] = case substring(@bitmap,3,1) & 8 when 8 then @c20 else [TaxAmt] end,
		[Freight] = case substring(@bitmap,3,1) & 16 when 16 then @c21 else [Freight] end,
		[Comment] = case substring(@bitmap,3,1) & 32 when 32 then @c22 else [Comment] end,
		[rowguid] = case substring(@bitmap,3,1) & 64 when 64 then @c23 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,3,1) & 128 when 128 then @c24 else [ModifiedDate] end
	where [SalesOrderID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[SalesOrderID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Sales].[SalesOrderHeader]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
else
begin 
update [Sales].[SalesOrderHeader] set
		[RevisionNumber] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [RevisionNumber] end,
		[OrderDate] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [OrderDate] end,
		[DueDate] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [DueDate] end,
		[ShipDate] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [ShipDate] end,
		[Status] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [Status] end,
		[OnlineOrderFlag] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [OnlineOrderFlag] end,
		[PurchaseOrderNumber] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [PurchaseOrderNumber] end,
		[AccountNumber] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [AccountNumber] end,
		[CustomerID] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else [CustomerID] end,
		[SalesPersonID] = case substring(@bitmap,2,1) & 4 when 4 then @c11 else [SalesPersonID] end,
		[TerritoryID] = case substring(@bitmap,2,1) & 8 when 8 then @c12 else [TerritoryID] end,
		[BillToAddressID] = case substring(@bitmap,2,1) & 16 when 16 then @c13 else [BillToAddressID] end,
		[ShipToAddressID] = case substring(@bitmap,2,1) & 32 when 32 then @c14 else [ShipToAddressID] end,
		[ShipMethodID] = case substring(@bitmap,2,1) & 64 when 64 then @c15 else [ShipMethodID] end,
		[CreditCardID] = case substring(@bitmap,2,1) & 128 when 128 then @c16 else [CreditCardID] end,
		[CreditCardApprovalCode] = case substring(@bitmap,3,1) & 1 when 1 then @c17 else [CreditCardApprovalCode] end,
		[CurrencyRateID] = case substring(@bitmap,3,1) & 2 when 2 then @c18 else [CurrencyRateID] end,
		[SubTotal] = case substring(@bitmap,3,1) & 4 when 4 then @c19 else [SubTotal] end,
		[TaxAmt] = case substring(@bitmap,3,1) & 8 when 8 then @c20 else [TaxAmt] end,
		[Freight] = case substring(@bitmap,3,1) & 16 when 16 then @c21 else [Freight] end,
		[Comment] = case substring(@bitmap,3,1) & 32 when 32 then @c22 else [Comment] end,
		[rowguid] = case substring(@bitmap,3,1) & 64 when 64 then @c23 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,3,1) & 128 when 128 then @c24 else [ModifiedDate] end
	where [SalesOrderID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[SalesOrderID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Sales].[SalesOrderHeader]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
end 
