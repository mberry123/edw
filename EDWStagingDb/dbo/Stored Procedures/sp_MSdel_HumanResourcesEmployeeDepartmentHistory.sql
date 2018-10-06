create procedure [sp_MSdel_HumanResourcesEmployeeDepartmentHistory]
		@pkc1 int,
		@pkc3 smallint,
		@pkc4 tinyint,
		@pkc2 date
as
begin  
	declare @primarykey_text nvarchar(100) = ''
	delete [HumanResources].[EmployeeDepartmentHistory] 
	where [BusinessEntityID] = @pkc1
  and [StartDate] = @pkc2
  and [DepartmentID] = @pkc3
  and [ShiftID] = @pkc4
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[BusinessEntityID] = ' + convert(nvarchar(100),@pkc1,1) + ', '
				set @primarykey_text = @primarykey_text + '[StartDate] = ' + convert(nvarchar(100),@pkc2,1) + ', '
				set @primarykey_text = @primarykey_text + '[DepartmentID] = ' + convert(nvarchar(100),@pkc3,1) + ', '
				set @primarykey_text = @primarykey_text + '[ShiftID] = ' + convert(nvarchar(100),@pkc4,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[HumanResources].[EmployeeDepartmentHistory]', @param2=@primarykey_text, @param3=13234 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
