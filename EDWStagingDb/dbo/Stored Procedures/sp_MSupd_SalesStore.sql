create procedure [sp_MSupd_SalesStore]
		@c1 int = NULL,
		@c2 nvarchar(50) = NULL,
		@c3 int = NULL,
		@c4 xml = NULL,
		@c5 uniqueidentifier = NULL,
		@c6 datetime = NULL,
		@pkc1 int = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
if (substring(@bitmap,1,1) & 1 = 1)
begin 
update [Sales].[Store] set
		[BusinessEntityID] = case substring(@bitmap,1,1) & 1 when 1 then @c1 else [BusinessEntityID] end,
		[Name] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [Name] end,
		[SalesPersonID] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [SalesPersonID] end,
		[Demographics] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else convert(xml,[Demographics]) end,
		[rowguid] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [ModifiedDate] end
	where [BusinessEntityID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[BusinessEntityID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Sales].[Store]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
else
begin 
update [Sales].[Store] set
		[Name] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [Name] end,
		[SalesPersonID] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [SalesPersonID] end,
		[Demographics] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else convert(xml,[Demographics]) end,
		[rowguid] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [ModifiedDate] end
	where [BusinessEntityID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[BusinessEntityID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Sales].[Store]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
end 
