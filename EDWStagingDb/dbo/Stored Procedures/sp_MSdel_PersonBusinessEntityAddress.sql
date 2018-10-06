﻿create procedure [sp_MSdel_PersonBusinessEntityAddress]
		@pkc1 int,
		@pkc2 int,
		@pkc3 int
as
begin  
	declare @primarykey_text nvarchar(100) = ''
	delete [Person].[BusinessEntityAddress] 
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
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Person].[BusinessEntityAddress]', @param2=@primarykey_text, @param3=13234 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
