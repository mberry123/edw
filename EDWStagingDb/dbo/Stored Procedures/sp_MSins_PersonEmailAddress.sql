create procedure [sp_MSins_PersonEmailAddress]
    @c1 int,
    @c2 int,
    @c3 nvarchar(50),
    @c4 uniqueidentifier,
    @c5 datetime
as
begin  
	insert into [Person].[EmailAddress] (
		[BusinessEntityID],
		[EmailAddressID],
		[EmailAddress],
		[rowguid],
		[ModifiedDate]
	) values (
		@c1,
		@c2,
		@c3,
		@c4,
		@c5	) 
end  
