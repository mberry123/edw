create procedure [sp_MSupd_SalesSalesTerritoryImage]
		@c1 int = NULL,
		@c2 varbinary(max) = NULL,
		@pkc1 int = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
if (substring(@bitmap,1,1) & 1 = 1)
begin 
update [Sales].[SalesTerritoryImage] set
		[TerritoryID] = case substring(@bitmap,1,1) & 1 when 1 then @c1 else [TerritoryID] end,
		[SalesTerritoryImage] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [SalesTerritoryImage] end
	where [TerritoryID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[TerritoryID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Sales].[SalesTerritoryImage]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
else
begin 
update [Sales].[SalesTerritoryImage] set
		[SalesTerritoryImage] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [SalesTerritoryImage] end
	where [TerritoryID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[TerritoryID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Sales].[SalesTerritoryImage]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
end 
