create procedure [sp_MSupd_ProductionProduct]
		@c1 int = NULL,
		@c2 nvarchar(50) = NULL,
		@c3 nvarchar(25) = NULL,
		@c4 bit = NULL,
		@c5 bit = NULL,
		@c6 nvarchar(15) = NULL,
		@c7 smallint = NULL,
		@c8 smallint = NULL,
		@c9 money = NULL,
		@c10 money = NULL,
		@c11 nvarchar(5) = NULL,
		@c12 nchar(3) = NULL,
		@c13 nchar(3) = NULL,
		@c14 decimal(8,2) = NULL,
		@c15 int = NULL,
		@c16 nchar(2) = NULL,
		@c17 nchar(2) = NULL,
		@c18 nchar(2) = NULL,
		@c19 int = NULL,
		@c20 int = NULL,
		@c21 datetime = NULL,
		@c22 datetime = NULL,
		@c23 datetime = NULL,
		@c24 uniqueidentifier = NULL,
		@c25 datetime = NULL,
		@pkc1 int = NULL,
		@bitmap binary(4)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
update [Production].[Product] set
		[Name] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [Name] end,
		[ProductNumber] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [ProductNumber] end,
		[MakeFlag] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [MakeFlag] end,
		[FinishedGoodsFlag] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [FinishedGoodsFlag] end,
		[Color] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [Color] end,
		[SafetyStockLevel] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [SafetyStockLevel] end,
		[ReorderPoint] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [ReorderPoint] end,
		[StandardCost] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [StandardCost] end,
		[ListPrice] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else [ListPrice] end,
		[Size] = case substring(@bitmap,2,1) & 4 when 4 then @c11 else [Size] end,
		[SizeUnitMeasureCode] = case substring(@bitmap,2,1) & 8 when 8 then @c12 else [SizeUnitMeasureCode] end,
		[WeightUnitMeasureCode] = case substring(@bitmap,2,1) & 16 when 16 then @c13 else [WeightUnitMeasureCode] end,
		[Weight] = case substring(@bitmap,2,1) & 32 when 32 then @c14 else [Weight] end,
		[DaysToManufacture] = case substring(@bitmap,2,1) & 64 when 64 then @c15 else [DaysToManufacture] end,
		[ProductLine] = case substring(@bitmap,2,1) & 128 when 128 then @c16 else [ProductLine] end,
		[Class] = case substring(@bitmap,3,1) & 1 when 1 then @c17 else [Class] end,
		[Style] = case substring(@bitmap,3,1) & 2 when 2 then @c18 else [Style] end,
		[ProductSubcategoryID] = case substring(@bitmap,3,1) & 4 when 4 then @c19 else [ProductSubcategoryID] end,
		[ProductModelID] = case substring(@bitmap,3,1) & 8 when 8 then @c20 else [ProductModelID] end,
		[SellStartDate] = case substring(@bitmap,3,1) & 16 when 16 then @c21 else [SellStartDate] end,
		[SellEndDate] = case substring(@bitmap,3,1) & 32 when 32 then @c22 else [SellEndDate] end,
		[DiscontinuedDate] = case substring(@bitmap,3,1) & 64 when 64 then @c23 else [DiscontinuedDate] end,
		[rowguid] = case substring(@bitmap,3,1) & 128 when 128 then @c24 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,4,1) & 1 when 1 then @c25 else [ModifiedDate] end
	where [ProductID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[ProductID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Production].[Product]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
