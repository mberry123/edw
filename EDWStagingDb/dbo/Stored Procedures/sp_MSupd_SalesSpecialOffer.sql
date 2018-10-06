create procedure [sp_MSupd_SalesSpecialOffer]
		@c1 int = NULL,
		@c2 nvarchar(255) = NULL,
		@c3 smallmoney = NULL,
		@c4 nvarchar(50) = NULL,
		@c5 nvarchar(50) = NULL,
		@c6 datetime = NULL,
		@c7 datetime = NULL,
		@c8 int = NULL,
		@c9 int = NULL,
		@c10 uniqueidentifier = NULL,
		@c11 datetime = NULL,
		@pkc1 int = NULL,
		@bitmap binary(2)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
update [Sales].[SpecialOffer] set
		[Description] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [Description] end,
		[DiscountPct] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [DiscountPct] end,
		[Type] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [Type] end,
		[Category] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [Category] end,
		[StartDate] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [StartDate] end,
		[EndDate] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [EndDate] end,
		[MinQty] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [MinQty] end,
		[MaxQty] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [MaxQty] end,
		[rowguid] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,2,1) & 4 when 4 then @c11 else [ModifiedDate] end
	where [SpecialOfferID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[SpecialOfferID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Sales].[SpecialOffer]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
