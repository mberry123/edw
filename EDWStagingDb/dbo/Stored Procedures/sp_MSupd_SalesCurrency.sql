create procedure [sp_MSupd_SalesCurrency]
		@c1 nchar(3) = NULL,
		@c2 nvarchar(50) = NULL,
		@c3 datetime = NULL,
		@pkc1 nchar(3) = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
if (substring(@bitmap,1,1) & 1 = 1)
begin 
update [Sales].[Currency] set
		[CurrencyCode] = case substring(@bitmap,1,1) & 1 when 1 then @c1 else [CurrencyCode] end,
		[Name] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [Name] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [ModifiedDate] end
	where [CurrencyCode] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[CurrencyCode] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Sales].[Currency]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
else
begin 
update [Sales].[Currency] set
		[Name] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [Name] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [ModifiedDate] end
	where [CurrencyCode] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[CurrencyCode] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Sales].[Currency]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
end 
