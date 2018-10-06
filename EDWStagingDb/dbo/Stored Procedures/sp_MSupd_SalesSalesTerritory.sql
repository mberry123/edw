create procedure [sp_MSupd_SalesSalesTerritory]
		@c1 int = NULL,
		@c2 nvarchar(50) = NULL,
		@c3 nvarchar(3) = NULL,
		@c4 nvarchar(50) = NULL,
		@c5 money = NULL,
		@c6 money = NULL,
		@c7 money = NULL,
		@c8 money = NULL,
		@c9 uniqueidentifier = NULL,
		@c10 datetime = NULL,
		@pkc1 int = NULL,
		@bitmap binary(2)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
update [Sales].[SalesTerritory] set
		[Name] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [Name] end,
		[CountryRegionCode] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [CountryRegionCode] end,
		[Group] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [Group] end,
		[SalesYTD] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [SalesYTD] end,
		[SalesLastYear] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [SalesLastYear] end,
		[CostYTD] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [CostYTD] end,
		[CostLastYear] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [CostLastYear] end,
		[rowguid] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else [ModifiedDate] end
	where [TerritoryID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[TerritoryID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Sales].[SalesTerritory]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
