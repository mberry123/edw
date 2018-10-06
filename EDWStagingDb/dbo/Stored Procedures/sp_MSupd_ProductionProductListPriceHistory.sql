create procedure [sp_MSupd_ProductionProductListPriceHistory]
		@c1 int = NULL,
		@c2 datetime = NULL,
		@c3 datetime = NULL,
		@c4 money = NULL,
		@c5 datetime = NULL,
		@pkc1 int = NULL,
		@pkc2 datetime = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
if (substring(@bitmap,1,1) & 1 = 1) or
 (substring(@bitmap,1,1) & 2 = 2)
begin 
update [Production].[ProductListPriceHistory] set
		[ProductID] = case substring(@bitmap,1,1) & 1 when 1 then @c1 else [ProductID] end,
		[StartDate] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [StartDate] end,
		[EndDate] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [EndDate] end,
		[ListPrice] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [ListPrice] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [ModifiedDate] end
	where [ProductID] = @pkc1
  and [StartDate] = @pkc2
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[ProductID] = ' + convert(nvarchar(100),@pkc1,1) + ', '
				set @primarykey_text = @primarykey_text + '[StartDate] = ' + convert(nvarchar(100),@pkc2,21)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Production].[ProductListPriceHistory]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
else
begin 
update [Production].[ProductListPriceHistory] set
		[EndDate] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [EndDate] end,
		[ListPrice] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [ListPrice] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [ModifiedDate] end
	where [ProductID] = @pkc1
  and [StartDate] = @pkc2
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[ProductID] = ' + convert(nvarchar(100),@pkc1,1) + ', '
				set @primarykey_text = @primarykey_text + '[StartDate] = ' + convert(nvarchar(100),@pkc2,21)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Production].[ProductListPriceHistory]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
end 
