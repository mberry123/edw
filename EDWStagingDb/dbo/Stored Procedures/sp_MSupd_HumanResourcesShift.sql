﻿create procedure [sp_MSupd_HumanResourcesShift]
		@c1 tinyint = NULL,
		@c2 nvarchar(50) = NULL,
		@c3 time = NULL,
		@c4 time = NULL,
		@c5 datetime = NULL,
		@pkc1 tinyint = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
update [HumanResources].[Shift] set
		[Name] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [Name] end,
		[StartTime] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [StartTime] end,
		[EndTime] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [EndTime] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [ModifiedDate] end
	where [ShiftID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[ShiftID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[HumanResources].[Shift]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
