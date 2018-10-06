create procedure [sp_MSupd_ProductionProductPhoto]
		@c1 int = NULL,
		@c2 varbinary(max) = NULL,
		@c3 nvarchar(50) = NULL,
		@c4 varbinary(max) = NULL,
		@c5 nvarchar(50) = NULL,
		@c6 datetime = NULL,
		@pkc1 int = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
update [Production].[ProductPhoto] set
		[ThumbNailPhoto] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [ThumbNailPhoto] end,
		[ThumbnailPhotoFileName] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [ThumbnailPhotoFileName] end,
		[LargePhoto] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [LargePhoto] end,
		[LargePhotoFileName] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [LargePhotoFileName] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [ModifiedDate] end
	where [ProductPhotoID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[ProductPhotoID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Production].[ProductPhoto]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
