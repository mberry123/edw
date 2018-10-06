create procedure [sp_MSins_PersonPhoneNumberType]
    @c1 int,
    @c2 nvarchar(50),
    @c3 datetime
as
begin  
	insert into [Person].[PhoneNumberType] (
		[PhoneNumberTypeID],
		[Name],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3	) 
end  
