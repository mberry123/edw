create procedure [sp_MSins_PersonPersonPhone]
    @c1 int,
    @c2 nvarchar(25),
    @c3 int,
    @c4 datetime
as
begin  
	insert into [Person].[PersonPhone] (
		[BusinessEntityID],
		[PhoneNumber],
		[PhoneNumberTypeID],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4	) 
end  
