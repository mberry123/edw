create procedure [sp_MSupd_PersonPerson]
		@c1 int = NULL,
		@c2 nchar(2) = NULL,
		@c3 bit = NULL,
		@c4 nvarchar(8) = NULL,
		@c5 nvarchar(50) = NULL,
		@c6 nvarchar(50) = NULL,
		@c7 nvarchar(50) = NULL,
		@c8 nvarchar(10) = NULL,
		@c9 int = NULL,
		@c10 xml = NULL,
		@c11 xml = NULL,
		@c12 uniqueidentifier = NULL,
		@c13 datetime = NULL,
		@pkc1 int = NULL,
		@bitmap binary(2)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
if (substring(@bitmap,1,1) & 1 = 1)
begin 
update [Person].[Person] set
		[BusinessEntityID] = case substring(@bitmap,1,1) & 1 when 1 then @c1 else [BusinessEntityID] end,
		[PersonType] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [PersonType] end,
		[NameStyle] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [NameStyle] end,
		[Title] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [Title] end,
		[FirstName] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [FirstName] end,
		[MiddleName] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [MiddleName] end,
		[LastName] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [LastName] end,
		[Suffix] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [Suffix] end,
		[EmailPromotion] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [EmailPromotion] end,
		[AdditionalContactInfo] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else convert(xml,[AdditionalContactInfo]) end,
		[Demographics] = case substring(@bitmap,2,1) & 4 when 4 then @c11 else convert(xml,[Demographics]) end,
		[rowguid] = case substring(@bitmap,2,1) & 8 when 8 then @c12 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,2,1) & 16 when 16 then @c13 else [ModifiedDate] end
	where [BusinessEntityID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[BusinessEntityID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Person].[Person]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
else
begin 
update [Person].[Person] set
		[PersonType] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [PersonType] end,
		[NameStyle] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [NameStyle] end,
		[Title] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [Title] end,
		[FirstName] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [FirstName] end,
		[MiddleName] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [MiddleName] end,
		[LastName] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [LastName] end,
		[Suffix] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [Suffix] end,
		[EmailPromotion] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [EmailPromotion] end,
		[AdditionalContactInfo] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else convert(xml,[AdditionalContactInfo]) end,
		[Demographics] = case substring(@bitmap,2,1) & 4 when 4 then @c11 else convert(xml,[Demographics]) end,
		[rowguid] = case substring(@bitmap,2,1) & 8 when 8 then @c12 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,2,1) & 16 when 16 then @c13 else [ModifiedDate] end
	where [BusinessEntityID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[BusinessEntityID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Person].[Person]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
end 
