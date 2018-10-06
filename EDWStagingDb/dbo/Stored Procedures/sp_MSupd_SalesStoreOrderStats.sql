create procedure [sp_MSupd_SalesStoreOrderStats]
		@c1 int = NULL,
		@c2 char(1) = NULL,
		@c3 tinyint = NULL,
		@c4 int = NULL,
		@c5 int = NULL,
		@c6 tinyint = NULL,
		@c7 money = NULL,
		@pkc1 int = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
if (substring(@bitmap,1,1) & 1 = 1)
begin 
update [Sales].[StoreOrderStats] set
		[BusinessEntityID] = case substring(@bitmap,1,1) & 1 when 1 then @c1 else [BusinessEntityID] end,
		[OrderFrequency] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [OrderFrequency] end,
		[OrderMonth] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [OrderMonth] end,
		[FirstOrderYear] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [FirstOrderYear] end,
		[LastOrderYear] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [LastOrderYear] end,
		[MinPaymentType] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [MinPaymentType] end,
		[MinPaymentAmount] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [MinPaymentAmount] end
	where [BusinessEntityID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[BusinessEntityID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Sales].[StoreOrderStats]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
else
begin 
update [Sales].[StoreOrderStats] set
		[OrderFrequency] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [OrderFrequency] end,
		[OrderMonth] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [OrderMonth] end,
		[FirstOrderYear] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [FirstOrderYear] end,
		[LastOrderYear] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [LastOrderYear] end,
		[MinPaymentType] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [MinPaymentType] end,
		[MinPaymentAmount] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [MinPaymentAmount] end
	where [BusinessEntityID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[BusinessEntityID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Sales].[StoreOrderStats]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
end 
