create procedure [sp_MSupd_PersonBusinessEntityAddress]
		@c1 int = NULL,
		@c2 int = NULL,
		@c3 int = NULL,
		@c4 uniqueidentifier = NULL,
		@c5 datetime = NULL,
		@pkc1 int = NULL,
		@pkc2 int = NULL,
		@pkc3 int = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
if (substring(@bitmap,1,1) & 1 = 1) or
 (substring(@bitmap,1,1) & 2 = 2) or
 (substring(@bitmap,1,1) & 4 = 4)
begin 
update [Person].[BusinessEntityAddress] set
		[BusinessEntityID] = case substring(@bitmap,1,1) & 1 when 1 then @c1 else [BusinessEntityID] end,
		[AddressID] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [AddressID] end,
		[AddressTypeID] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [AddressTypeID] end,
		[rowguid] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [ModifiedDate] end
	where [BusinessEntityID] = @pkc1
  and [AddressID] = @pkc2
  and [AddressTypeID] = @pkc3
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[BusinessEntityID] = ' + convert(nvarchar(100),@pkc1,1) + ', '
				set @primarykey_text = @primarykey_text + '[AddressID] = ' + convert(nvarchar(100),@pkc2,1) + ', '
				set @primarykey_text = @primarykey_text + '[AddressTypeID] = ' + convert(nvarchar(100),@pkc3,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Person].[BusinessEntityAddress]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
else
begin 
update [Person].[BusinessEntityAddress] set
		[rowguid] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [ModifiedDate] end
	where [BusinessEntityID] = @pkc1
  and [AddressID] = @pkc2
  and [AddressTypeID] = @pkc3
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[BusinessEntityID] = ' + convert(nvarchar(100),@pkc1,1) + ', '
				set @primarykey_text = @primarykey_text + '[AddressID] = ' + convert(nvarchar(100),@pkc2,1) + ', '
				set @primarykey_text = @primarykey_text + '[AddressTypeID] = ' + convert(nvarchar(100),@pkc3,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Person].[BusinessEntityAddress]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
end 
