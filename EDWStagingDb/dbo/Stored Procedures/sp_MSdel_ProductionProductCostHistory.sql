create procedure [sp_MSdel_ProductionProductCostHistory]
		@pkc1 int,
		@pkc2 datetime
as
begin  
	declare @primarykey_text nvarchar(100) = ''
	delete [Production].[ProductCostHistory] 
	where [ProductID] = @pkc1
  and [StartDate] = @pkc2
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[ProductID] = ' + convert(nvarchar(100),@pkc1,1) + ', '
				set @primarykey_text = @primarykey_text + '[StartDate] = ' + convert(nvarchar(100),@pkc2,21)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[Production].[ProductCostHistory]', @param2=@primarykey_text, @param3=13234 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
