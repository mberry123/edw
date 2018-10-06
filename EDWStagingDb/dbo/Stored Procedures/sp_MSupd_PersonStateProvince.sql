create procedure [sp_MSupd_PersonStateProvince]
		@c1 int = NULL,
		@c2 nchar(3) = NULL,
		@c3 nvarchar(3) = NULL,
		@c4 bit = NULL,
		@c5 nvarchar(50) = NULL,
		@c6 int = NULL,
		@c7 uniqueidentifier = NULL,
		@c8 datetime = NULL,
		@pkc1 int = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
update [Person].[StateProvince] set
		[StateProvinceCode] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [StateProvinceCode] end,
		[CountryRegionCode] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [CountryRegionCode] end,
		[IsOnlyStateProvinceFlag] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [IsOnlyStateProvinceFlag] end,
		[Name] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [Name] end,
		[TerritoryID] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [TerritoryID] end,
		[rowguid] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [ModifiedDate] end
	where [StateProvinceID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[StateProvinceID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Person].[StateProvince]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
