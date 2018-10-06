create procedure [sp_MSupd_HumanResourcesEmployee]
		@c1 int = NULL,
		@c2 nvarchar(15) = NULL,
		@c3 nvarchar(256) = NULL,
		@c4 [hierarchyid] = NULL,
		@c5 nvarchar(50) = NULL,
		@c6 date = NULL,
		@c7 nchar(1) = NULL,
		@c8 nchar(1) = NULL,
		@c9 date = NULL,
		@c10 bit = NULL,
		@c11 smallint = NULL,
		@c12 smallint = NULL,
		@c13 bit = NULL,
		@c14 uniqueidentifier = NULL,
		@c15 datetime = NULL,
		@pkc1 int = NULL,
		@bitmap binary(2)
as
begin  
	declare @primarykey_text nvarchar(100) = ''
if (substring(@bitmap,1,1) & 1 = 1)
begin 
update [HumanResources].[Employee] set
		[BusinessEntityID] = case substring(@bitmap,1,1) & 1 when 1 then @c1 else [BusinessEntityID] end,
		[NationalIDNumber] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [NationalIDNumber] end,
		[LoginID] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [LoginID] end,
		[OrganizationNode] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [OrganizationNode] end,
		[JobTitle] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [JobTitle] end,
		[BirthDate] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [BirthDate] end,
		[MaritalStatus] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [MaritalStatus] end,
		[Gender] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [Gender] end,
		[HireDate] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [HireDate] end,
		[SalariedFlag] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else [SalariedFlag] end,
		[VacationHours] = case substring(@bitmap,2,1) & 4 when 4 then @c11 else [VacationHours] end,
		[SickLeaveHours] = case substring(@bitmap,2,1) & 8 when 8 then @c12 else [SickLeaveHours] end,
		[CurrentFlag] = case substring(@bitmap,2,1) & 16 when 16 then @c13 else [CurrentFlag] end,
		[rowguid] = case substring(@bitmap,2,1) & 32 when 32 then @c14 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,2,1) & 64 when 64 then @c15 else [ModifiedDate] end
	where [BusinessEntityID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[BusinessEntityID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[HumanResources].[Employee]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end  
else
begin 
update [HumanResources].[Employee] set
		[NationalIDNumber] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [NationalIDNumber] end,
		[LoginID] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [LoginID] end,
		[OrganizationNode] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [OrganizationNode] end,
		[JobTitle] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [JobTitle] end,
		[BirthDate] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [BirthDate] end,
		[MaritalStatus] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [MaritalStatus] end,
		[Gender] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [Gender] end,
		[HireDate] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [HireDate] end,
		[SalariedFlag] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else [SalariedFlag] end,
		[VacationHours] = case substring(@bitmap,2,1) & 4 when 4 then @c11 else [VacationHours] end,
		[SickLeaveHours] = case substring(@bitmap,2,1) & 8 when 8 then @c12 else [SickLeaveHours] end,
		[CurrentFlag] = case substring(@bitmap,2,1) & 16 when 16 then @c13 else [CurrentFlag] end,
		[rowguid] = case substring(@bitmap,2,1) & 32 when 32 then @c14 else [rowguid] end,
		[ModifiedDate] = case substring(@bitmap,2,1) & 64 when 64 then @c15 else [ModifiedDate] end
	where [BusinessEntityID] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
		Begin
			if exists (Select * from sys.all_parameters where object_id = OBJECT_ID('sp_MSreplraiserror') and [name] = '@param3')
			Begin
				
				set @primarykey_text = @primarykey_text + '[BusinessEntityID] = ' + convert(nvarchar(100),@pkc1,1)
				exec sp_MSreplraiserror @errorid=20598, @param1=N'[HumanResources].[Employee]', @param2=@primarykey_text, @param3=13233 
			End
			Else
				exec sp_MSreplraiserror @errorid=20598
		End
end 
end 
