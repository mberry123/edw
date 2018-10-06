create procedure [sp_MSupd_PersonAddress]
		@c1 int = NULL,
		@c2 nvarchar(60) = NULL,
		@c3 nvarchar(60) = NULL,
		@c4 nvarchar(30) = NULL,
		@c5 int = NULL,
		@c6 nvarchar(15) = NULL,
		@c7 [geography] = NULL,
		@c8 uniqueidentifier = NULL,
		@c9 datetime = NULL,
		@pkc1 int = NULL,
		@bitmap binary(2)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
update [Person].[Address] set
		[AddressLine1] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [AddressLine1] end,
		[AddressLine2] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [AddressLine2] end,
		[City] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [City] end,
		[StateProvinceID] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [StateProvinceID] end,
		[PostalCode] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [PostalCode] end,
		[SpatialLocation] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [SpatialLocation] end,
		[rowguid] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [ModifiedDate] end
	where [AddressID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[AddressID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Person].[Address]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
