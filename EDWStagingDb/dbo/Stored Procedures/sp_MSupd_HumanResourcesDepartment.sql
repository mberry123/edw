﻿create procedure [sp_MSupd_HumanResourcesDepartment]
		@c1 smallint = NULL,
		@c2 nvarchar(50) = NULL,
		@c3 nvarchar(50) = NULL,
		@c4 datetime = NULL,
		@pkc1 smallint = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
update [HumanResources].[Department] set
		[Name] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [Name] end,
		[GroupName] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [GroupName] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [ModifiedDate] end
	where [DepartmentID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[DepartmentID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[HumanResources].[Department]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
