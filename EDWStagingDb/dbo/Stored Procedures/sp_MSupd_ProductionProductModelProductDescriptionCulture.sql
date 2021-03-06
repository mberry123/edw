﻿create procedure [sp_MSupd_ProductionProductModelProductDescriptionCulture]
		@c1 int = NULL,
		@c2 int = NULL,
		@c3 nchar(6) = NULL,
		@c4 datetime = NULL,
		@pkc1 int = NULL,
		@pkc2 int = NULL,
		@pkc3 nchar(6) = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
if (substring(@bitmap,1,1) & 1 = 1) or
 (substring(@bitmap,1,1) & 2 = 2) or
 (substring(@bitmap,1,1) & 4 = 4)
begin 
update [Production].[ProductModelProductDescriptionCulture] set
		[ProductModelID] = case substring(@bitmap,1,1) & 1 when 1 then @c1 else [ProductModelID] end,
		[ProductDescriptionID] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [ProductDescriptionID] end,
		[CultureID] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [CultureID] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [ModifiedDate] end
	where [ProductModelID] = @pkc1
  and [ProductDescriptionID] = @pkc2
  and [CultureID] = @pkc3
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[ProductModelID] = ' + convert(nvarchar(100),@pkc1,1) + ', '
				set @primarykey_text = @primarykey_text + '[ProductDescriptionID] = ' + convert(nvarchar(100),@pkc2,1) + ', '
				set @primarykey_text = @primarykey_text + '[CultureID] = ' + convert(nvarchar(100),@pkc3,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Production].[ProductModelProductDescriptionCulture]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
else
begin 
update [Production].[ProductModelProductDescriptionCulture] set
		[ModifiedDate] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [ModifiedDate] end
	where [ProductModelID] = @pkc1
  and [ProductDescriptionID] = @pkc2
  and [CultureID] = @pkc3
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[ProductModelID] = ' + convert(nvarchar(100),@pkc1,1) + ', '
				set @primarykey_text = @primarykey_text + '[ProductDescriptionID] = ' + convert(nvarchar(100),@pkc2,1) + ', '
				set @primarykey_text = @primarykey_text + '[CultureID] = ' + convert(nvarchar(100),@pkc3,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Production].[ProductModelProductDescriptionCulture]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
end 
