create procedure [sp_MSdel_ProductionProductModelProductDescriptionCulture]
		@pkc1 int,
		@pkc2 int,
		@pkc3 nchar(6)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
	delete [Production].[ProductModelProductDescriptionCulture] 
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
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Production].[ProductModelProductDescriptionCulture]', @param2=@primarykey_text, @param3=13234 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
