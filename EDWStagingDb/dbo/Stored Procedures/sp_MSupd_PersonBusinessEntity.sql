﻿create procedure [sp_MSupd_PersonBusinessEntity]
		@c1 int = NULL,
		@c2 uniqueidentifier = NULL,
		@c3 datetime = NULL,
		@pkc1 int = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
update [Person].[BusinessEntity] set
		[rowguid] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [ModifiedDate] end
	where [BusinessEntityID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[BusinessEntityID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Person].[BusinessEntity]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
