create procedure [sp_MSupd_HumanResourcesEmployeeDepartmentHistory]
		@c1 int = NULL,
		@c2 smallint = NULL,
		@c3 tinyint = NULL,
		@c4 date = NULL,
		@c5 date = NULL,
		@c6 datetime = NULL,
		@pkc1 int = NULL,
		@pkc3 smallint = NULL,
		@pkc4 tinyint = NULL,
		@pkc2 date = NULL,
		@bitmap binary(1)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
if (substring(@bitmap,1,1) & 1 = 1) or
 (substring(@bitmap,1,1) & 8 = 8) or
 (substring(@bitmap,1,1) & 2 = 2) or
 (substring(@bitmap,1,1) & 4 = 4)
begin 
update [HumanResources].[EmployeeDepartmentHistory] set
		[BusinessEntityID] = case substring(@bitmap,1,1) & 1 when 1 then @c1 else [BusinessEntityID] end,
		[DepartmentID] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [DepartmentID] end,
		[ShiftID] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [ShiftID] end,
		[StartDate] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [StartDate] end,
		[EndDate] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [EndDate] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [ModifiedDate] end
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
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[HumanResources].[EmployeeDepartmentHistory]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
else
begin 
update [HumanResources].[EmployeeDepartmentHistory] set
		[EndDate] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [EndDate] end,
		[ModifiedDate] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [ModifiedDate] end
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
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[HumanResources].[EmployeeDepartmentHistory]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
end 
